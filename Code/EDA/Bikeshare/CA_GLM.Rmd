# Running a logistic regression model: 
beach_trips <- all_trips_to_beach %>%
  mutate(destination = 0)

highpark_trips <- all_trips_to_highpark %>%
  mutate(destination = 1)

all_binary_trips <- bind_rows(beach_trips, highpark_trips)

all_binary_trips <- all_binary_trips %>%
  mutate(
    month = month(Start.Time, label = TRUE, abbr = FALSE) |> factor(ordered = FALSE),
    weekday = wday(Start.Time, label = TRUE, abbr = FALSE) |> factor(ordered = FALSE)
  )

# Creating a file which spatially encodes all the start station's coordinates

# If you would like to run the code, uncomment the following commented lines.
# Otherwise, the file is already prepared to be loaded in.

# all_start_stations <- bind_rows(
#   all_trips_to_beach %>% select(Start.Station.Name),
#   all_trips_to_highpark %>% select(Start.Station.Name)
# ) %>%
#   distinct(Start.Station.Name) %>%
#   filter(!is.na(Start.Station.Name), 
#          Start.Station.Name != "", 
#          Start.Station.Name != "NULL")
# 
# all_start_stations_geo <- all_start_stations %>%
#   mutate(
#     Start.Station.Name = iconv(Start.Station.Name, to = "UTF-8", sub = ""),
#     address = paste0(Start.Station.Name, ", Toronto, ON")
#   ) %>%
#   geocode(address = address,
#           method = "osm",
#           long = longitude,
#           lat = latitude) %>%
#   select(-address)
# 
# saveRDS(all_start_stations_geo,
#         "all_start_stations_geo.rds")

all_start_stations_geo <-
  readRDS("all_start_stations_geo.rds")

# Kew Gardens Coordinates
beach_latitude <- 43.6629
beach_longitude <- -79.3024

all_start_stations_geo <- all_start_stations_geo %>%
  mutate(
    distance_from_beach = distHaversine(
      cbind(longitude, latitude),
      c(beach_longitude, beach_latitude)
    ) / 1000 
  )

all_start_stations_geo <- na.omit(all_start_stations_geo)

all_binary_trips <- all_binary_trips %>%
  left_join(
    all_start_stations_geo %>% select(Start.Station.Name, distance_from_beach)
  ) %>%
  mutate(start_hour = hour(Start.Time)) %>%
  mutate(
    month = factor(month, ordered = FALSE),
    weekday = factor(weekday, ordered = FALSE)
  )

all_binary_trips <- na.omit(all_binary_trips)

model <- glm(
  destination ~ weekday + month + start_hour + distance_from_beach + Trip..Duration,
  data = all_binary_trips,
  family = binomial
)

summary(model)

tidy(model) |>
  mutate(
    group = case_when(
      str_starts(term, "weekday") ~ "Weekday",
      str_starts(term, "month")   ~ "Month",
      term == "(Intercept)"       ~ "Intercept",
      TRUE                        ~ ""
    ),
    term = case_when(
      term == "(Intercept)"         ~ "Intercept",
      term == "start_hour"          ~ "Start Hour",
      term == "distance_from_beach" ~ "Distance from Beach (km)",
      term == "Trip..Duration"      ~ "Trip Duration",
      str_starts(term, "weekday")   ~ str_remove(term, "weekday"),
      str_starts(term, "month")     ~ str_remove(term, "month"),
      TRUE                          ~ term
    ),
    group = factor(group, levels = c("Intercept", "", "Weekday", "Month")),
    odds_ratio = exp(estimate)
  ) |>
  arrange(group) |>
  select(group, term, estimate, odds_ratio, std.error, statistic, p.value) |>
  kable(
    digits = 3,
    col.names = c("Group", "Term", "Estimate (Log-Odds)", "Odds Ratio", "Std. Error", "z value", "p-value"),
    caption = "BIA Destination GLM Output"
  ) |>
  kable_styling(
    bootstrap_options = c("striped", "hover", "condensed"),
    full_width = FALSE
  )

# Testing GLM (logistic regression) assumptions

# Multicollinearity check:
car::vif(model)
car::vif(model) |>
  as.data.frame() |>
  rownames_to_column(var = "Variable") |>
  select(Variable, `GVIF`) |>
  rename(VIF = `GVIF`) |>
  mutate(
    Variable = case_when(
      Variable == "start_hour"          ~ "Start Hour",
      Variable == "distance_from_beach" ~ "Distance from Beach (km)",
      Variable == "Trip..Duration"      ~ "Trip Duration",
      Variable == "weekday"             ~ "Weekday",
      Variable == "month"               ~ "Month",
      TRUE                              ~ Variable
    )
  ) |>
  kable(
    digits = 3,
    col.names = c("Variable", "GVIF"),
    caption = "VIF for GLM Predictors"
  ) |>
  kable_styling(
    bootstrap_options = c("striped", "hover", "condensed"),
    full_width = FALSE
  )

# Linearity of continuous predictors check:
set.seed(10)
all_binary_trips |>
  slice_sample(n = 5000) |>      
  mutate(
    logit = log(fitted(model)[row_number()] / (1 - fitted(model)[row_number()]))
  ) |>
  select(logit, distance_from_beach, start_hour, Trip..Duration) |>
  rename(
    "Distance from Beach (km)" = distance_from_beach,
    "Start Hour"               = start_hour,
    "Trip Duration"            = Trip..Duration
  ) |>
  pivot_longer(-logit, names_to = "predictor", values_to = "value") |>
  ggplot(aes(x = value, y = logit)) +
  geom_smooth(method = "loess", colour = "blue") +
  facet_wrap(~ predictor, scales = "free_x") +
  labs(
    x = "Predictor Value",
    y = "Log-Odds",
    title = "Linearity of Continuous Predictors vs Log-Odds"
  ) +
  theme_minimal()

# Time series plot:
highpark_population <- 23925
beach_population <- 21135

daily_proportion_bike <- function(trips_to_bia, bia, population) {
  trips_to_bia %>%
    transmute(Start.Time = mdy_hm(Start.Time)) %>%
    mutate(Date = as_date(Start.Time)) %>%
    count(Date, name = "trip_count") %>%
    mutate(
      prop_count = trip_count / population,
      BIA = bia
    )
}

highpark_daily_trips <- daily_proportion_bike(all_trips_to_highpark, "High Park", highpark_population)
beach_daily_trips <- daily_proportion_bike(all_trips_to_beach, "Beach", beach_population) 

both_daily_trips <- bind_rows(highpark_daily_trips, beach_daily_trips)

ggplot(both_daily_trips, aes(x = Date, y = prop_count, color = BIA)) +
  geom_line(linewidth = 0.7, alpha = 0.8, show.legend = FALSE) +
  facet_wrap(~BIA, ncol = 1, scales = "free_y") +
  labs(
    title = "Daily BikeShare Users by BIA (January 2021 - December 2024)",
    x = "Time (Day)",
    y = "Proportion of Daily Bike Trips to Population"
  ) +
  theme_minimal(base_size = 16) +
  scale_color_manual(
    values = c(
      "High Park" = "#FF7F0E",
      "Beach" = "#1F77B4"
    )
  ) + 
  theme(
    text = element_text(family = "Georgia"),
    plot.title = element_text(size = 20),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 16),
    strip.text = element_text(size = 18) 
  )


# Time series plot continued: looking for an annual trend
# Creating a proportion: yearly trips over population, this represents the 
# "average" number of trips taken by an individual within the BIA

annual_trips <- both_daily_trips %>%
  mutate(
    Year = year(Date),
    population = case_when(
      BIA == "Beach" ~ 21135,
      BIA == "High Park" ~ 23925
    )
  ) %>%
  group_by(BIA, Year) %>%
  summarise(
    yearly_trip_count = sum(trip_count),
    yearly_prop = sum(trip_count) / unique(population),
    .groups = "drop"
  ) %>%
  arrange(BIA, Year)

ggplot(annual_trips, aes(x = Year, y = yearly_prop, color = BIA )) +
  geom_line() +
  geom_point() +
  facet_wrap(~BIA, ncol = 1, scales = "free_y") +
  labs(
    title = "Average Annual Bike Trips per Resident by BIA",
    x = "Year",
    y = "Proportion of Annual Number of Trips over BIA Population"
  ) +
  theme_minimal(base_size = 16) + 
  scale_color_manual(
    values = c(
      "High Park" = "#FF7F0E",
      "Beach" = "#1F77B4"
    )
  ) + 
  theme(
    text = element_text(family = "Georgia"),
    plot.title = element_text(size = 20),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 16),
    strip.text = element_text(size = 18) 
  )

# Hourly plot:
clean_time <- function(df) {
  df %>%
    mutate(
      Start_Time_trim = trimws(Start.Time),
      Start_Time = case_when(
        as.numeric(sub("^\\d{2}/(\\d{2})/\\d{4}.*", "\\1", Start_Time_trim)) > 12 ~ 
          mdy_hm(Start_Time_trim),
        TRUE ~ dmy_hm(Start_Time_trim)
      )
    )
}

highpark_clean <- clean_time(all_trips_to_highpark)
beach_clean    <- clean_time(all_trips_to_beach)

hourly_highpark <- highpark_clean %>%
  mutate(hour = hour(Start_Time)) %>%
  count(hour) %>%
  mutate(BIA = "High Park")

hourly_beach <- beach_clean %>%
  mutate(hour = hour(Start_Time)) %>%
  count(hour) %>%
  mutate(BIA = "Beach")

hourly_combined <- bind_rows(hourly_highpark, hourly_beach)

ggplot(hourly_combined, aes(x = hour, y = n, fill = n)) +
  geom_col() +
  coord_polar(start = 0 - pi / 24) +
  facet_wrap(~BIA, ncol = 2) +
  scale_x_continuous(
    breaks = 0:23,
    labels = c("12 AM","1 AM","2 AM","3 AM","4 AM","5 AM","6 AM","7 AM",
               "8 AM","9 AM","10 AM","11 AM",
               "12 PM","1 PM","2 PM","3 PM","4 PM","5 PM","6 PM","7 PM",
               "8 PM","9 PM","10 PM","11 PM")
  ) +
  scale_fill_gradient(
    low  = "#E65100",   
    high = "lightblue",
    name = "Trips per Hour"
  ) +
  labs(
    title = "Hourly Distribution of Bike Trips by BIA",
    x = "Time of Day",
    y = "Number of Trips"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.y = element_blank(),
    text = element_text(family = "Georgia"),
    plot.title = element_text(size = 20),
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 14),
    strip.text = element_text(size = 16) 
  )

# Trip duration histogram (standardized):
# Need to standardize by number of total trips, NOT population

highpark_hist <- all_trips_to_highpark %>%
  mutate(BIA = "High Park") %>%
  filter(Start.Station.Name %in% highpark_bike_stations)

sum(highpark_hist$Trip..Duration > 86400)/nrow(highpark_hist)
summary(highpark_hist$Trip..Duration)


beach_hist <- all_trips_to_beach %>%
  mutate(BIA = "Beach") %>%
  filter(Start.Station.Name %in% beach_bike_stations)

summary(beach_hist$Trip..Duration)

combined_hist <- bind_rows(highpark_hist, beach_hist)

ggplot(combined_hist, aes(x = Trip..Duration, fill = BIA)) +
  geom_histogram(
    aes(y = after_stat(density)),
    binwidth = 120,
    alpha = 0.4,
    position = "identity",
    color = "white"
  ) +
  coord_cartesian(xlim = c(0, 8000)) +
  scale_fill_manual(values = c(
    "High Park" = "#FF7F0E",
    "Beach" = "#1F77B4"
  )) +
  labs(
    title = "Distribution of Density of Trip Durations by BIA",
    x = "Trip Duration (Seconds)",
    y = "Density"
  ) +
  theme_minimal(base_size = 16) +
  theme(
    panel.grid = element_blank(),
    text = element_text(family = "Georgia"),
    plot.title = element_text(size = 20),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 16),
    strip.text = element_text(size = 18),
    legend.text = element_text(size = 16),   
    legend.title = element_text(size = 18)
  )

# Bar plot for trips stratified by day of the week 
beach_week <- all_trips_to_beach %>%
  mutate(
    Start.Time = parse_date_time(Start.Time, orders = c("ymd HMS", "mdy HM")),
    weekday = wday(Start.Time, label = TRUE, abbr = FALSE, week_start = 1)
  ) %>%
  count(weekday) %>%
  mutate(
    prop = n / sum(n),
    location = "Beach"
  )

highpark_week <- all_trips_to_highpark %>%
  mutate(
    Start.Time = parse_date_time(Start.Time, orders = c("ymd HMS", "mdy HM")),
    weekday = wday(Start.Time, label = TRUE, abbr = FALSE, week_start = 1)
  ) %>%
  count(weekday) %>%
  mutate(
    prop = n / sum(n),
    location = "High Park"
  )

combined_week <- bind_rows(beach_week, highpark_week)
combined_week <- na.omit(combined_week)

ggplot(combined_week, aes(x = weekday, y = prop, fill = location)) +
  geom_col(position = "dodge") +
  scale_y_continuous(labels = percent) +
  scale_fill_manual(values = c("Beach" = "skyblue", "High Park" = "#F4A261")) +
  labs(
    title = "Percentage of Bike Trips for Day of Week by BIA",
    x = "Day of Week",
    y = "Percent of Trips",
    fill = "BIA"
  ) +
  theme_minimal(base_size = 16) +
  theme(
    panel.grid = element_blank(),
    text = element_text(family = "Georgia"),
    plot.title = element_text(size = 20),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 16),
    strip.text = element_text(size = 18),
    legend.text = element_text(size = 16),   
    legend.title = element_text(size = 18)
  )

print(as.data.frame(combined_week %>%
                       mutate(prop = scales::percent(prop, accuracy = 0.1)) %>%
                       select(location, weekday, prop) %>%
                       arrange(location, weekday)))

# Bike Membership Pie Chart:
user_breakdown <- all_trips_to_beach %>%
  count(User.Type) %>%
  mutate(prop = n / sum(n) * 100)

ggplot(user_breakdown, aes(x = "", y = prop, fill = User.Type)) +
  geom_col(width = 1, color = "white") +
  coord_polar(theta = "y") +
  theme_void() +
  labs(title = "Distribution of User Types") +
  geom_text(aes(label = paste0(round(prop, 1), "%")),
            position = position_stack(vjust = 0.5),
            size = 4) +
  scale_fill_manual(values = c("#a6cee3", "#fbb4ae")
  ) +
  theme(text = element_text(family = "Georgia"))

# Finding the proportion of bike trips to the Commercial Strip.

commercial_beach_bike_stations <- c("Hubbard Blvd / Balsam Av",
                                    "Hubbard Blvd. / Glen Manor Dr",
                                    "Queen St. E / Eastern Ave",
                                    "Queen St. E / Spruce Hill Rd",
                                    "Queen St E / Hammersmith Ave",
                                    "Queen St. E / Spruce Hill Rd.",
                                    "Queen St E / Nursewood Rde")

commercial_beach_trips <- all_trips_to_beach %>%
  filter(
    End.Station.Name %in% commercial_beach_bike_stations
  )
prop_commercial_trips <- nrow(commercial_beach_trips) / nrow(all_trips_to_beach)
prop_commercial_trips

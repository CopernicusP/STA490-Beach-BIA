# Spatial plot of where trips to High Park STARTED:

# Creating a file which saves the spatial locations of each bike trip, as this
# spatial encoding process took extremely long to run. 

# If you would like to run the code, uncomment the following commented lines.
# Otherwise, the file is already prepared to be loaded in.

# all_trips_to_highpark$Start.Station.Name <- iconv(
#   all_trips_to_highpark$Start.Station.Name,
#   from = "",
#   to   = "UTF-8",
#   sub  = "?"
# )
# 
# start_stations_to_highpark <- all_trips_to_highpark %>%
#   filter(!is.na(Start.Station.Name),
#          Start.Station.Name != "",
#          Start.Station.Name != "NULL") %>%
#   distinct(Start.Station.Name) %>%
#   rename(start_station = Start.Station.Name)
# 
# start_stations_to_highpark_geo <- start_stations_to_highpark %>%
#   geocode(address = start_station,
#           method = "osm",
#           long = longitude,
#           lat = latitude) %>%
#   filter(!is.na(longitude) & !is.na(latitude))
# 
# saveRDS(start_stations_to_highpark_geo,
#         "start_stations_to_highpark_geo.rds")

start_stations_to_highpark_geo <-
  readRDS("Data/bike_stations_spatial/start_stations_to_highpark_geo.rds")

start_stations_to_beach_geo <-
  readRDS("Data/bike_stations_spatial/start_stations_to_beach_geo.rds")

all_trips_to_highpark <- all_trips_to_highpark %>%
  mutate(Start.Time = mdy_hm(Start.Time))

start_stations_to_highpark_count <- all_trips_to_highpark %>%
  filter(!is.na(Start.Station.Name),
         Start.Station.Name != "",
         Start.Station.Name != "NULL") %>%
  count(Start.Station.Name, name = "trips_highpark") 

all_trips_to_beach <- all_trips_to_beach %>%
  mutate(Start.Time = mdy_hm(Start.Time))

start_stations_to_beach_count <- all_trips_to_beach %>%
  filter(!is.na(Start.Station.Name),
         Start.Station.Name != "",
         Start.Station.Name != "NULL") %>%
  count(Start.Station.Name, name = "trips_beach") 

start_stations_to_highpark_sf <- start_stations_to_highpark_geo %>%
  left_join(start_stations_to_highpark_count, by = c("start_station" = "Start.Station.Name")) %>%
  mutate(trips_highpark = tidyr::replace_na(trips_highpark, 0L)) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326)

start_stations_to_beach_sf <- start_stations_to_beach_geo %>%
  left_join(start_stations_to_beach_count, by = c("start_station" = "Start.Station.Name")) %>%
  mutate(trips_beach = tidyr::replace_na(trips_beach, 0L)) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326)

start_stations_combined <- full_join(
  start_stations_to_highpark_sf %>% st_drop_geometry() %>% select(start_station, trips_highpark),
  start_stations_to_beach_sf %>% st_drop_geometry() %>% select(start_station, trips_beach),
  by = "start_station"
) %>%
  mutate(
    trips_highpark = tidyr::replace_na(trips_highpark, 0L),
    trips_beach    = tidyr::replace_na(trips_beach, 0L),
    diff           = trips_beach - trips_highpark,
    total          = trips_beach + trips_highpark
  )

combined_sf <- start_stations_to_beach_sf %>%
  select(start_station, geometry) %>%
  left_join(start_stations_combined, by = "start_station")

combined_sf <- combined_sf %>%
  filter(
    st_coordinates(.)[, 1] > -80,
    st_coordinates(.)[, 1] < -78,
    st_coordinates(.)[, 2] > 43,
    st_coordinates(.)[, 2] < 44
  )

max_abs_diff <- max(abs(combined_sf$diff), na.rm = TRUE)

pal_diff <- colorNumeric(
  palette = colorRampPalette(c("#F46D43", "#F3E9D2", "#1F78B4"))(100),
  domain  = c(-max_abs_diff, max_abs_diff),
  na.color = "gray"
)

leaflet(combined_sf) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addCircleMarkers(
    popup = ~paste0(
      "<b>", start_station, "</b>",
      "<br>Beach trips: ", trips_beach,
      "<br>High Park trips: ", trips_highpark,
      "<br>Diff: ", diff
    ),
    color = ~pal_diff(diff),
    radius = ~pmax(3, log(total + 1) * 2),
    fillOpacity = 0.95,
    stroke = FALSE
  ) %>%
  addLegend(
    "bottomright",
    pal = pal_diff,
    values = ~diff,
    title = "Difference of Beach Trips to High Park Trips"
  )

# Adding a square root transformation to make the difference more visible
combined_sf <- combined_sf %>%
  mutate(diff_transformed = sign(diff) * sqrt(abs(diff)))

max_abs_transformed <- max(abs(combined_sf$diff_transformed), na.rm = TRUE)

pal_diff <- colorNumeric(
  palette = colorRampPalette(c("#F46D43", "#F3E9D2", "#1F78B4"))(100),
  domain = c(-max_abs_transformed, max_abs_transformed),
  na.color = "gray"
)

leaflet(combined_sf) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addCircleMarkers(
    popup = ~paste0(
      "<b>", start_station, "</b>",
      "<br>Beach trips: ", trips_beach,
      "<br>High Park trips: ", trips_highpark,
      "<br>Diff: ", diff
    ),
    color = ~pal_diff(diff_transformed), 
    radius = ~pmax(3, log(total + 1) * 2),
    fillOpacity = 0.95,
    stroke = FALSE
  ) %>%
  addLegend(
    "bottomright",
    pal = pal_diff,
    values = ~diff_transformed,
    title = "Transformed Difference in Bike Trips"
  )

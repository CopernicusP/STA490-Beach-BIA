# Spatial Plot of where trips to the Beach STARTED:

# Creating a file which saves the spatial locations of each bike trip, as this
# spatial encoding process took extremely long to run. 

# If you would like to run the code, uncomment the following commented lines.
# Otherwise, the file is already prepared to be loaded in.

# all_trips_to_beach$Start.Station.Name <- iconv(
#   all_trips_to_beach$Start.Station.Name,
#   from = "",
#   to   = "UTF-8",
#   sub  = "?"
# )
# 
# start_stations_to_beach <- all_trips_to_beach %>%
#   filter(!is.na(Start.Station.Name),
#          Start.Station.Name != "",
#          Start.Station.Name != "NULL") %>%
#   distinct(Start.Station.Name) %>%
#   rename(start_station = Start.Station.Name)
# 
# start_stations_to_beach_geo <- start_stations_to_beach %>%
#   geocode(address = start_station,
#           method = "osm",
#           long = longitude,
#           lat = latitude) %>%
#   filter(!is.na(longitude) & !is.na(latitude))
# 
# saveRDS(start_stations_to_beach_geo,
#         "start_stations_to_beach_geo.rds")

start_stations_to_beach_geo <-
  readRDS("start_stations_to_beach_geo.rds")

start_stations_to_beach_coord <- st_as_sf(start_stations_to_beach_geo,
  coords = c("longitude", "latitude"),
  crs = 4326
)

start_station_counts <- all_trips_to_beach %>%
  filter(!is.na(Start.Station.Name),
         Start.Station.Name != "",
         Start.Station.Name != "NULL") %>%
  group_by(Start.Station.Name) %>%
  summarise(trip_count = n())

start_stations_to_beach_coord <- start_stations_to_beach_coord %>%
  distinct(start_station, .keep_all = TRUE) %>%
  left_join(start_station_counts, by = c("start_station" = "Start.Station.Name")
  ) %>%
  filter(!is.na(trip_count))

start_stations_to_beach_coord <- start_stations_to_beach_coord %>%
  filter(
    st_coordinates(.)[, 1] > -80,
    st_coordinates(.)[, 1] < -78,
    st_coordinates(.)[, 2] > 43,
    st_coordinates(.)[, 2] < 44
  )

pal <- colorNumeric(
  palette = "YlOrRd",
  domain = start_stations_to_beach_coord$trip_count
)

leaflet(start_stations_to_beach_coord) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addCircleMarkers(
    popup = ~paste0("<b>", start_station, "</b><br>Trips: ", trip_count),
    color = ~pal(trip_count),
    radius = ~pmax(3, log(trip_count + 1) * 2),
    fillOpacity = 0.9,
    stroke = FALSE
  ) %>%
  addLegend(
    position = "bottomright",
    pal = pal,
    values = ~trip_count,
    title = "Number of Trips"
)

# Spatial Plot of where trips from the Beach ENDED:

# all_trips_from_beach$End.Station.Name <- iconv(
#   all_trips_from_beach$End.Station.Name,
#   from = "",
#   to   = "UTF-8",
#   sub  = "?"
# )
# 
# end_stations_from_beach <- all_trips_from_beach %>%
#   filter(!is.na(End.Station.Name),
#          End.Station.Name != "",
#          End.Station.Name != "NULL") %>%
#   distinct(End.Station.Name) %>%
#   rename(end_station = End.Station.Name)
# 
# end_stations_from_beach_geo <- end_stations_from_beach %>%
#   geocode(address = end_station,
#           method = "osm",
#           long = longitude,
#           lat = latitude) %>%
#   filter(!is.na(longitude) & !is.na(latitude))
# 
# saveRDS(end_stations_from_beach_geo,
#         "end_stations_from_beach_geo.rds")

end_stations_from_beach_geo <-
  readRDS("end_stations_from_beach_geo.rds")

end_stations_from_beach_coord <- st_as_sf(end_stations_from_beach_geo,
  coords = c("longitude", "latitude"),
  crs = 4326
)

end_station_counts <- all_trips_from_beach %>%
  filter(!is.na(End.Station.Name),
         End.Station.Name != "",
         End.Station.Name != "NULL") %>%
  group_by(End.Station.Name) %>%
  summarise(trip_count = n())

end_stations_from_beach_coord <- end_stations_from_beach_coord %>%
  distinct(end_station, .keep_all = TRUE) %>%
  left_join(end_station_counts, by = c("end_station" = "End.Station.Name")) %>%
  filter(!is.na(trip_count))

end_stations_from_beach_coord <- end_stations_from_beach_coord %>%
  filter(
    st_coordinates(.)[, 1] > -80,
    st_coordinates(.)[, 1] < -78,
    st_coordinates(.)[, 2] > 43,
    st_coordinates(.)[, 2] < 44
  )

pal <- colorNumeric(
  palette = "YlOrRd",
  domain = end_stations_from_beach_coord$trip_count,
  na.color = "gray"
)

leaflet(end_stations_from_beach_coord) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addCircleMarkers(
    popup = ~paste0("<b>", end_station, "</b><br>Trips: ", trip_count),
    color = ~pal(trip_count),
    radius = ~pmax(3, log(trip_count + 1) * 2),
    fillOpacity = 0.9,
    stroke = FALSE
  ) %>%
  addLegend(
    position = "bottomright",
    pal = pal,
    values = ~trip_count,
    title = "Number of Trips"
  )

# Calculating the proportion of bike trips relating to a Beach BIA station that
# remained within the BIA.
within_beach <- all_trips_from_beach %>%
  filter(End.Station.Name %in% beach_bike_stations)

within_beach2 <- all_trips_to_beach %>%
  filter(Start.Station.Name %in% beach_bike_stations)

proportion_within_beach <- (nrow(within_beach) + nrow(within_beach2)) /
  (nrow(all_trips_from_beach) + nrow(all_trips_to_beach))
proportion_within_beach

# Connecting Bike Trips in a Spatial Plot: 
start_station_coords <- start_stations_to_beach_geo %>%
  rename(
    start_longitude = longitude,
    start_latitude  = latitude
  ) %>%
  distinct(start_station, .keep_all = TRUE) %>%
  select(start_station, start_longitude, start_latitude)

end_station_coords <- all_trips_to_beach %>%
  filter(!is.na(End.Station.Name),
         End.Station.Name != "",
         End.Station.Name != "NULL") %>%
  distinct(End.Station.Name) %>%
  rename(end_station = End.Station.Name) %>%
  geocode(address = end_station, method = "osm",
          long = end_longitude, lat = end_latitude) %>%
  filter(!is.na(end_longitude), !is.na(end_latitude),
         end_longitude > -80, end_longitude < -78,
         end_latitude  > 43,  end_latitude  < 44) %>%
  distinct(end_station, .keep_all = TRUE)

all_trips_to_beach_with_coords <- all_trips_to_beach %>%
  mutate(
    Start.Station.Name = iconv(Start.Station.Name, from = "", to = "UTF-8", sub = "?"),
    End.Station.Name   = iconv(End.Station.Name,   from = "", to = "UTF-8", sub = "?")
  ) %>%
  left_join(start_station_coords, by = c("Start.Station.Name" = "start_station")) %>%
  left_join(end_station_coords,   by = c("End.Station.Name"   = "end_station")) %>%
  filter(
    start_longitude > -79.9, start_longitude < -78.9,
    start_latitude  > 43.55, start_latitude  < 43.95,
    end_longitude   > -79.9, end_longitude   < -78.9,
    end_latitude    > 43.55, end_latitude    < 43.95
  ) %>%
  na.omit()

trip_pairs_to_beach <- all_trips_to_beach_with_coords %>%
  filter(!is.na(start_longitude), !is.na(start_latitude),
         !is.na(end_longitude),   !is.na(end_latitude)) %>%
  count(Start.Station.Name, End.Station.Name,
        start_longitude, start_latitude,
        end_longitude,   end_latitude,
        name = "trip_count")

trip_pair_lines <- trip_pairs_to_beach %>%
  rowwise() %>%
  mutate(geometry = st_sfc(
    st_linestring(matrix(c(start_longitude, start_latitude,
                           end_longitude,   end_latitude),
                         ncol = 2, byrow = TRUE)), crs = 4326)
  ) %>%
  ungroup() %>%
  st_as_sf(sf_column_name = "geometry", crs = 4326)

start_points <- all_trips_to_beach_with_coords %>%
  filter(!is.na(start_longitude), !is.na(start_latitude)) %>%
  distinct(Start.Station.Name, start_longitude, start_latitude) %>%
  st_as_sf(coords = c("start_longitude", "start_latitude"), crs = 4326, remove = FALSE) %>%
  rename(station = Start.Station.Name)

end_points <- all_trips_to_beach_with_coords %>%
  filter(!is.na(end_longitude), !is.na(end_latitude)) %>%
  distinct(End.Station.Name, end_longitude, end_latitude) %>%
  st_as_sf(coords = c("end_longitude", "end_latitude"), crs = 4326, remove = FALSE) %>%
  rename(station = End.Station.Name)

beach_polygon <- neighbourhoods %>%
  filter(AREA_SHORT_CODE == "063") %>%
  st_transform(4326)

beach_utm <- st_transform(beach_polygon, 26917) %>% st_make_valid()

breaks <- seq(0, 2000, by = 200)
bands <- length(breaks) - 1

rings_utm <- do.call(rbind, lapply(seq_len(bands), function(i) {
  ring <- st_difference(st_buffer(beach_utm, breaks[i + 1]),
                        st_buffer(beach_utm, breaks[i])) %>%
    st_make_valid() %>%
    st_collection_extract("POLYGON", warn = FALSE)
  ring <- ring[!st_is_empty(ring), ]
  st_sf(band_m     = breaks[i + 1],
        band_label = paste0(breaks[i], "–", breaks[i + 1], " m"),
        geometry   = st_geometry(ring))
}))

rings <- st_transform(rings_utm, st_crs(beach_polygon))

ring_color_scale <- rev(brewer.pal(max(3, min(9, bands)), "YlOrBr"))
ring_colors <- colorFactor(palette = ring_color_scale, domain = sort(unique(rings$band_m)))
line_colors <- colorNumeric(palette = "#6baed6", domain = trip_pair_lines$trip_count, na.color = "gray")

start_points <- st_transform(start_points, st_crs(rings))
end_points <- st_transform(end_points, st_crs(rings))
trip_pair_lines <- st_transform(trip_pair_lines, st_crs(rings))

start_points_with_ring <- st_join(
  start_points,
  rings %>% select(band_label, band_m),
  join = st_intersects, left = TRUE
)

trip_pair_lines <- trip_pair_lines %>%
  left_join(
    start_points_with_ring %>% st_drop_geometry() %>% select(station, band_label, band_m),
    by = c("Start.Station.Name" = "station")
  )

ring_groups <- paste0("Ring ", rings$band_label)

map <- leaflet() %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(data = beach_polygon, fill = FALSE, color = "#08306b",
              weight = 2, opacity = 1, group = "Beach Boundary")

for (i in seq_len(nrow(rings))) {
  ring_data  <- rings[i, ]
  this_label <- ring_data$band_label
  group_name <- paste0("Ring ", this_label)
  
  map <- map %>%
    addPolygons(
      data = ring_data,
      fillColor = ring_colors(ring_data$band_m), fillOpacity = 0.3,
      color = NA, stroke = FALSE, popup = ~band_label, group = group_name
    ) %>%
    addPolylines(
      data = trip_pair_lines %>% filter(band_label == this_label),
      color = ~line_colors(trip_count),
      weight = ~pmax(1, log(trip_count + 1) * 1.2),
      opacity = 0.15,
      popup = ~paste0("<b>Start:</b> ", Start.Station.Name,
                      "<br><b>End:</b> ", End.Station.Name,
                      "<br><b>Trips:</b> ", trip_count,
                      "<br><b>Ring:</b> ", band_label),
      group = group_name
    ) %>%
    addCircleMarkers(
      data = start_points_with_ring %>% filter(band_label == this_label),
      radius = 2, color = "#2171b5", fillColor = "#2171b5",
      fillOpacity = 0.8, stroke = FALSE,
      popup = ~paste0("<b>Start:</b> ", station, "<br><b>Ring:</b> ", band_label),
      group = group_name
    )
}

map %>%
  addCircleMarkers(
    data = end_points, radius = 2,
    color = "#041f4a", fillColor = "#041f4a",
    fillOpacity = 0.95, stroke = FALSE,
    popup = ~paste0("<b>End:</b> ", station),
    group = "End Stations"
  ) %>%
  addLayersControl(
    overlayGroups = c("Beach Boundary", ring_groups, "End Stations"),
    options = layersControlOptions(collapsed = FALSE)
  ) %>%
  showGroup("Beach Boundary") %>%
  showGroup("End Stations")

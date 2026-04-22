install.packages("opendatatoronto")
install.packages("dplyr")
install.packages("tidygeocoder")
install.packages("sf")
install.packages("lintr")
install.packages('gridExtra')
library(opendatatoronto)
library(dplyr)
library(tidygeocoder)
library(sf)
library(lintr)
library(leaflet)
library(scales)
library(RColorBrewer)
library(ggplot2)
library(gridExtra)

all_trips_to_beach <- read.csv("all_trips_to_beach.csv")
all_trips_from_beach <- read.csv("all_trips_from_beach.csv")

neighbourhoods <- st_read("Neighbourhoods - 4326.geojson")

beach_bike_stations <- c("Coxwell Ave /  Lake Shore Blvd E", "Lake Shore Blvd E / Knox Ave",
                         "Hubbard Blvd / Balsam Av", "Kingston Rd / Beech Ave", "Queen St. E / Eastern Ave",
                         "Woodbine Ave / Lake Shore Blvd E", "Southwood Dr / Kingston Rd - SMART",
                         "Queen St. E / Spruce Hill Rd.", "Hubbard Blvd. / Glen Manor Dr.",
                         "Queen St E / Hammersmith Ave", "Victoria Park Ave / Kingston Rd",
                         "Queen St E / Nursewood Rd", "Kewbeach Ave / Kenilworth Ave",
                         "85 Lee Ave", "Queen St E / Joseph Duggan Rd"                        
)

install.packages("opendatatoronto")
install.packages("dplyr")
install.packages("tidygeocoder")
install.packages("sf")
install.packages("lintr")
install.packages("tidymodels")
install.packages('geosphere')
install.packages('kableExtra')
install.packages('car')
library(geosphere)
library(tidymodels)
library(opendatatoronto)
library(dplyr)
library(tidygeocoder)
library(sf)
library(lintr)
library(leaflet)
library(broom)
library(knitr)
library(kableExtra)
library(scales)
library(car)

all_trips_to_highpark <- read.csv('Data/bikeshare_trips/all_trips_to_highpark.csv')
all_trips_to_beach <- read.csv("Data/bikeshare_trips/all_trips_to_beach.csv")

neighbourhoods <- st_read("Data/neighbourhoods/Neighbourhoods - 4326.shp")


highpark_bike_stations <- c("High Park Subway", "Parkside Dr / Bloor St W - SMART", 
                            "Sunnyside Ave / The Queensway - SMART", "High Park - West Rd",
                            "Ellis Ave / The Queensway", "High Park Outdoor Pool",      
                            "High Park - Grenadier Cafe", "High Park Amphitheatre", 
                            "Ripley Ave / Ormskirk Ave", "Bloor St W / High Park Ave (High Park)",
                            "Roncesvalles Ave / Marmaduke St", "The Queensway at South Kingsway",
                            "Bloor St W / Riverside Dr", "High Park Blvd / Parkside Dr",
                            "Howard Park Ave / Parkside Dr")

beach_bike_stations <- c("Coxwell Ave /  Lake Shore Blvd E", "Lake Shore Blvd E / Knox Ave",
                         "Hubbard Blvd / Balsam Av", "Kingston Rd / Beech Ave", "Queen St. E / Eastern Ave",
                         "Woodbine Ave / Lake Shore Blvd E", "Southwood Dr / Kingston Rd - SMART",
                         "Queen St. E / Spruce Hill Rd.", "Hubbard Blvd. / Glen Manor Dr.",
                         "Queen St E / Hammersmith Ave", "Victoria Park Ave / Kingston Rd",
                         "Queen St E / Nursewood Rd", "Kewbeach Ave / Kenilworth Ave",
                         "85 Lee Ave", "Queen St E / Joseph Duggan Rd"                        
)

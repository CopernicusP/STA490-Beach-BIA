# STA490-Beach-BIA
Beach BIA — 311 Complaints
Short exploratory analysis of 311 complaints around Toronto’s The Beaches area, combining:

311 Complaints from 2022 to 2025 (CSV)
Outputs include quick stats and tidy CSVs.

Repo layout
. ├─ Dataset/ # raw data (CSV/SHP/GeoJSON) ├─ outputs/ # auto-generated tables & maps ├─ Beach_BIA_Biodiversity_CONSOLIDATED.Rmd # main analysis └─ README.md

Data (expected filenames)
Dataset/SR2022.csv (fallback: observations-624727.csv or observations.csv)
Dataset/Business Improvement Areas Data - 4326.shp (+ .dbf/.shx/.prj)
Dataset/Green Spaces - 4326.shp (+ sidecars)
Dataset/Neighbourhoods - 4326.shp (+ sidecars)
Dataset/TOPO_TREE_WGS84.shp (+ sidecars)
Dataset/TOPO_Waterbody_WGS84.shp (+ sidecars)
Optional: Dataset/WoodbineBeach.shp
The Rmd searches in getwd()/Dataset, getwd()/data, getwd(), and /mnt/data.

How to run
Open the project in RStudio.
Open Beach_BIA_Biodiversity_CONSOLIDATED.Rmd.
Click Knit (HTML), or run
Results are written to outputs/.
Required R packages
sf, dplyr, readr, stringr, janitor, glue, leaflet, purrr, ggplot2, lubridate, tibble, tidyr, htmlwidgets, rlang

Parameters
AOI_BUFFER_M = 30 (area-of-interest buffer)

WATER_BUF_M = 20 (near-water proximity)

Key outputs (all in outputs/)
Tables (CSV):
bio_summary_final.csv — totals, area (ha), species/ha

bio_summary_by_area.csv — BIA / Woodbine / AOI (and neighbourhood if present)

category_summary.csv — obs by category

top_species.csv, top_observers.csv

Notes on data updates
If you add a newer complaints CSV, keep the naming pattern (e.g., 2026SR.csv).

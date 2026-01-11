# STA490 - Beach BIA - 311 Complaints
Short exploratory analysis of 311 complaints around Toronto’s The Beaches area, combining:
Add intro

main goal:

data:
311 Complaints from 2022 to 2025 (CSV)

language:
use R

tidy

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

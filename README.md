# STA490 - Beach BIA - 311 Complaints
Short exploratory analysis of 311 complaints around Toronto’s The Beaches area, combining:
Add intro

Main Goal:
Identify the most common types of complaints.
Examine whether there are temporal or seasonal patterns.
This study investigates 311 complaints within the Beach BIA area to understand public service needs and local infrastructure challenges.

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




# Toronto 311 Complaints Analysis (Beach BIA Case Study)

This project analyzes Toronto 311 service request data with a focus on the **Beach BIA area**, aiming to understand complaint patterns, temporal trends, and category-level distributions of municipal service requests.

The analysis combines exploratory data analysis (EDA), geospatial filtering, and time-series visualization to provide insights into how different types of city services are requested over time and across categories.

---

## Project Motivation

Toronto’s 311 system serves as a primary interface between residents and city services.  
Understanding complaint patterns can help:
- Identify high-demand service areas
- Reveal seasonal or temporal trends
- Inform data-driven urban planning and resource allocation

This project focuses on the **Beach BIA** as a case study to explore how complaint behavior differs by category and service section within a defined local area.

---

## Data Source

- **Toronto Open Data Portal – 311 Service Requests**
- Data includes:
  - Request creation date
  - Major complaint category
  - Service section
  - Location (postal code / geographic reference)
  - Status and service type

> Data were cleaned, filtered, and aggregated for analysis.  
> Only relevant records within the Beach BIA boundary were retained.

---

## Methodology

### 1. Data Cleaning & Preprocessing
- Removed incomplete or invalid records
- Standardized date formats
- Filtered complaints to the Beach BIA area
- Grouped complaints by:
  - Major category
  - Service section
  - Time (year / month)

### 2. Exploratory Data Analysis (EDA)
- Distribution of complaints across major categories
- Section-level breakdown within dominant categories
- Temporal trends in complaint volume
- Comparison of relative frequencies across services

### 3. Visualization
- Time-series plots of complaint counts
- Bar charts for category and section distributions
- Clear labeling and consistent color schemes for interpretability

---

## Key Findings

- **Waste & Environmental Enforcement** is the dominant complaint category in the Beach BIA area.
- A small number of service sections account for a large share of total complaints.
- Complaint volumes exhibit clear temporal variation, suggesting seasonal or event-driven effects.
- Bike-related and transportation complaints represent a relatively small but distinct subset of total requests.

---

## Tools & Technologies

- **R**
  - `tidyverse` (data manipulation & visualization)
  - `lubridate` (date handling)
  - `sf` (spatial filtering, if applicable)
- **ggplot2** for all visualizations
- Reproducible scripts for data cleaning and analysis

---

## Repository Structure

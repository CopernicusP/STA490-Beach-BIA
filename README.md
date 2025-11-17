# Beach BIA — Biodiversity EDA

Short exploratory analysis of biodiversity around Toronto’s **The Beaches** area, combining:
- iNaturalist observations (CSV)
- City of Toronto trees, waterbodies (SHP)
- Business Improvement Areas, Neighbourhoods (SHP)

Outputs include quick stats, tidy CSVs, and interactive Leaflet maps saved under `outputs/`.

---

## Repo layout
.
├─ Dataset/ # raw data (CSV/SHP/GeoJSON)
├─ outputs/ # auto-generated tables & maps
├─ Beach_BIA_Biodiversity_CONSOLIDATED.Rmd # main analysis
└─ README.md

## Data (expected filenames)
- `Dataset/observations-631589.csv` (fallback: `observations-624727.csv` or `observations.csv`)
- `Dataset/Business Improvement Areas Data - 4326.shp` (+ .dbf/.shx/.prj)
- `Dataset/Green Spaces - 4326.shp` (+ sidecars)
- `Dataset/Neighbourhoods - 4326.shp` (+ sidecars)
- `Dataset/TOPO_TREE_WGS84.shp` (+ sidecars)
- `Dataset/TOPO_Waterbody_WGS84.shp` (+ sidecars)
- Optional: `Dataset/WoodbineBeach.shp`

> The Rmd searches in `getwd()/Dataset`, `getwd()/data`, `getwd()`, and `/mnt/data`.

## How to run
1. Open the project in RStudio.
2. Open `Beach_BIA_Biodiversity_CONSOLIDATED.Rmd`.
3. Click **Knit** (HTML), or run
4. Results are written to outputs/.

## Required R packages

sf, dplyr, readr, stringr, janitor, glue, leaflet, purrr, ggplot2, lubridate, tibble, tidyr, htmlwidgets, rlang

## Processing choices (quick answers)

NAs / bad coords: drop rows with missing lat/lon; keep only -90 ≤ lat ≤ 90, -180 ≤ lon ≤ 180.

CRS: read and transform everything to EPSG:4326; use EPSG:32617 for area/buffer calculations.

AOI: union of (Beach BIA ∪ Woodbine Beach ∪ The Beaches neighbourhood) then 30 m buffer.

Geometry issues: st_make_valid() on polygons; planar union/buffer with sf_use_s2(FALSE) to avoid “crossing edges”.

Trees / obs filtering: spatial filter within AOI.

Duplicates: if id/observation_id exists, sort then distinct(...) to de-dup.

Categories: derive from iconic_taxon_name (fallback taxon_iconic_name) → Plants/Birds/Insects/Mammals/Reptiles/Spiders/Other.

Dates: parse observed_on; monthly counts since 2020-01-01.

## Parameters

AOI_BUFFER_M = 30 (area-of-interest buffer)

WATER_BUF_M = 20 (near-water proximity)

## Key outputs (all in outputs/)

# Tables (CSV):

bio_summary_final.csv — totals, area (ha), species/ha

bio_summary_by_area.csv — BIA / Woodbine / AOI (and neighbourhood if present)

category_summary.csv — obs by category

top_species.csv, top_observers.csv

neighbourhood_biodiversity_summary.csv — species, area, species/ha

near_water_by_category.csv — near vs away counts and shares

top5_species_by_area.csv

outputs_data_dictionary.csv — tiny data dictionary

# Maps (HTML):

map_categories_and_trees.html — category layers + trees

map_heat.html — heatmap (if leaflet.extras installed)

map_top10_species.html — per-species overlays

map_by_year.html — per-year layers

## Notes on data updates

If you add a newer iNaturalist CSV, keep the naming pattern (e.g., observations-631589.csv).

Re-knit to refresh caches; the script auto-writes filtered GeoJSONs to outputs/ for faster re-runs.
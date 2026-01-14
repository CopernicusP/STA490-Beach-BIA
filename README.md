# STA490 — Beach BIA (Peter branch)

This branch focuses on the **Biodiversity EDA** work for the Beach BIA project.

## What I did (Peter branch)

- Improved **readability** of the Biodiversity EDA notebooks by adding concise header/section comments and helper-function documentation.
- Prepared the notebooks for the **GitHub check-in** by clarifying inputs/outputs and the intended workflow.
- (Recommended) Applied consistent formatting via `styler` (instructions below).

### Files edited

- `EDA/Biodiversity/01_data_eda.Rmd`
- `EDA/Biodiversity/02_eda_part2.Rmd`
- `EDA/Biodiversity/BIAmaps.Rmd`
- `EDA/Biodiversity/Beach_BIA_Biodiversity_CONSOLIDATED.Rmd`

## How to run

1. Open the R project: `STA490-Beach-BIA.Rproj`
2. Make sure your working directory is the project root (or a directory that contains the expected data subfolders).
3. Knit notebooks (recommended order):
   - `EDA/Biodiversity/01_data_eda.Rmd` (build AOI + basic stats + map; writes `outputs/biodiversity_summary.csv`)
   - `EDA/Biodiversity/02_eda_part2.Rmd` (uses `outputs/*.geojson` caches if present; writes `outputs/top_species.csv`, `outputs/top_observers.csv`, `outputs/bio_summary_final.csv`)
   - `EDA/Biodiversity/Beach_BIA_Biodiversity_CONSOLIDATED.Rmd` (single end-to-end notebook that reproduces key tables/maps; writes multiple artifacts to `outputs/`)

> Note: Some notebooks look for a specific iNaturalist filename pattern (e.g., `observations-624727.csv`).  
> If your iNaturalist export has a different number, rename it or adjust the pattern in the notebook.

## Formatting (recommended)

To enforce consistent formatting across `.R` and `.Rmd` files, run this once in R:

```r
install.packages("styler")
styler::style_file("EDA/Biodiversity/01_data_eda.Rmd")
styler::style_file("EDA/Biodiversity/02_eda_part2.Rmd")
styler::style_file("EDA/Biodiversity/BIAmaps.Rmd")
styler::style_file("EDA/Biodiversity/Beach_BIA_Biodiversity_CONSOLIDATED.Rmd")
```

Then commit the resulting formatting-only changes as a separate commit (easy to review).

## Key files (what each notebook does)

- **01_data_eda.Rmd**— Author: Peter: loads raw iNaturalist + spatial layers, constructs the AOI (Beach BIA ∪ Woodbine Beach, buffered), filters points, produces basic summary stats, and renders a leaflet map.
- **02_eda_part2.Rmd**— Author: Peter: extended EDA; uses cached AOI-filtered layers when available, generates top tables (species/observers), monthly trend plot, and a leaflet layer map.
- **BIAmaps.Rmd**— Author: Peter: an alternative mapping notebook focused on visualizing polygons + points (BIA/park/trees/iNaturalist).
- **Beach_BIA_Biodiversity_CONSOLIDATED.Rmd**— Original author: Derek; included here for comparison; minor edits (if any): Peter: consolidated end-to-end notebook that reproduces the key outputs and additional analyses (neighbourhood richness, water proximity, top species layers, etc.).

## Contribution notes (for check-in)

### Authorship (Biodiversity EDA notebooks)
- Peter: primary author of `EDA/Biodiversity/01_data_eda.Rmd`, `EDA/Biodiversity/02_eda_part2.Rmd`, and `EDA/Biodiversity/Beach_BIA_Biodiversity_CONSOLIDATED.Rmd`.
- Derek: initial author of `EDA/Biodiversity/BIAmaps.Rmd` (Peter included it here for reference and aligned it with the branch workflow/structure).

### Repo / documentation work
- Peter: organized the Peter-BIa-EDA branch for the GitHub check-in; added/standardized notebook header comments and section comments; updated README ("How to run", "Key files", and workflow notes).
- Derek: leading the presentation component and producing the final graphs/maps for the class presentation.


# STA490 — Beach BIA (Biodiversity EDA) — Peter branch

This branch contains the **Biodiversity EDA notebooks** for the Beach BIA project.  
Goal: a clean GitHub check-in (readable notebooks + clear workflow + clear authorship).

## What I did (Peter branch)

- Cleaned up notebook **readability**: consistent formatting + concise header/section comments.
- Clarified **inputs/outputs** and the intended **run order**.
- Updated documentation in this README (how to run, key files, and contributions).

## How to run (locally)

1. Clone the repo and open `STA490-Beach-BIA.Rproj` in RStudio.
2. Make sure the project **data / spatial files** are available.
   - This branch focuses on notebooks and may not duplicate all datasets.
   - If you need data from `main`, either merge `main` into your local branch or copy/link the `Data/` folder locally.
3. Knit notebooks in order:
   - `EDA/Biodiversity/01_data_eda.Rmd`
   - `EDA/Biodiversity/02_eda_part2.Rmd`
   - `EDA/Biodiversity/Beach_BIA_Biodiversity_CONSOLIDATED.Rmd`
   - `EDA/Biodiversity/BIAmaps.Rmd` (optional, mapping-focused)
4. Outputs are written to `outputs/` (created if missing).

## Key files (with authorship)

- `EDA/Biodiversity/01_data_eda.Rmd`  
  **Author: Peter** — Loads/filters biodiversity datasets for the Beach BIA AOI and produces first-pass summaries + maps.

- `EDA/Biodiversity/02_eda_part2.Rmd`  
  **Author: Peter** — Extends EDA (richness/species/observers trends) with additional plots and mapping outputs.

- `EDA/Biodiversity/Beach_BIA_Biodiversity_CONSOLIDATED.Rmd`  
  **Author: Peter** — Consolidated biodiversity workflow (end-to-end notebook for summaries + mapping layers).

- `EDA/Biodiversity/BIAmaps.Rmd`  
  **Original author: Derek**; **documentation/formatting edits: Peter** — Mapping notebook focused on visualizing polygons + points (BIA/park/trees/iNaturalist).

## Files touched in this cleanup

- `README.md`
- `EDA/Biodiversity/01_data_eda.Rmd`
- `EDA/Biodiversity/02_eda_part2.Rmd`
- `EDA/Biodiversity/BIAmaps.Rmd`
- `EDA/Biodiversity/Beach_BIA_Biodiversity_CONSOLIDATED.Rmd`

## Contribution notes (for check-in)

- **Peter**: primary author of `01_data_eda.Rmd`, `02_eda_part2.Rmd`, and `Beach_BIA_Biodiversity_CONSOLIDATED.Rmd`; organized this branch for the GitHub check-in; improved readability (formatting/comments) and documentation.
- **Derek**: initial author of `BIAmaps.Rmd`; leading the presentation component (graphs/maps + High Park comparison / final presentation selection).

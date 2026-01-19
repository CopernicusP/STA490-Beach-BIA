# STA490 — Beach BIA Project

This repository contains our STA490 project work for the **Beach BIA** area, organized by shared data, code/notebooks, figures, and results.

## Quick navigation
- **Code / notebooks:** `Code/`
- **Shared data:** `Data/`
- **Tables / plots exports:** `Figures/`
- **Maps / GeoJSON / HTML outputs:** `Results/`

## Workstreams
This project includes multiple workstreams. Each workstream should have a clear entry point under `Code/` (and/or `EDA/` if used).

- **Biodiversity (iNaturalist + City Open Data)**  
  Entry: `Code/Beach_BIA_Biodiversity_CONSOLIDATED.Rmd` (or the Biodiversity folder entry point used by the team)
- **BikeShare (draft/ongoing)**  
  Entry: `Code/Beach_BIA_BikeShare/` (update with the main script/notebook)
- **311 Complaints (Toronto Open Data)**
  Entry: `Code/Beach_BIA_311_Complaints.Rmd/` (or under 311 complaints branch contains more)

> If a workstream has detailed assumptions / parameters / file naming rules, place them in that workstream’s own README (not here).

## Repo structure (convention)
We keep the top-level structure consistent so everyone can find things quickly:

- `Data/` — raw inputs (CSV/SHP/GeoJSON)
- `Code/` — main scripts / consolidated notebooks that generate outputs
- `Figures/` — exported tables/CSVs and figure outputs
- `Results/` — exported maps, GeoJSON layers, HTML widgets

(If `EDA/` exists, treat it as exploratory notebooks; finalized pipelines should be linked or moved into `Code/`.)

## How to run (high-level)
1. Open the project in RStudio (use the `.Rproj` if available).
2. Ensure required inputs are present under `Data/`.
3. Start from the workstream entry notebook/script (see “Workstreams” above).
4. Knit / run to reproduce outputs:
   - tables/CSVs → `Figures/`
   - maps/geojson/html → `Results/`

## Contributions (for check-in)
Please keep this section updated so it’s clear who did what.

<<<<<<< HEAD
- **Peter (Yudian Pan):** biodiversity EDA + consolidated notebook work; repo cleanup/documentation for check-in; branch organization and readability improvements.
- **Derek Li:** biodiversity EDA and mapping (all in bio_eda) + presentation figures + leading final graphs/maps + High Park comparison / presentation selection.
- **Other members/groups:** (add names + 1–2 bullet responsibilities here)
=======
- **Peter (Yudian Pan):** biodiversity EDA + consolidated notebook work; Repo structure cleanup (Code/Data/Figures/Results), documentation + navigation in main README; branch organization and readability improvements.
- **Derek Li:** biodiversity mapping + presentation artifacts; leading final graphs/maps + High Park comparison / presentation selection.
- **Jingyi & Gengqi** 311 complaint part. The specific contributions are under the branch.
>>>>>>> origin/main

## Notes
- Don’t duplicate large raw datasets in multiple places—prefer `Data/` as the shared source of truth.
- Auto-generated artifacts (e.g., `*_files/`, caches) should generally stay in `Results/` or be ignored via `.gitignore` unless required for submission.

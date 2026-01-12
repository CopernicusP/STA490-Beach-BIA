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
  - Division
  - Location (postal code / geographic reference)
  - Status (open / closed)
  - Service request type
  - ...

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
<img width="722" height="493" alt="image" src="https://github.com/user-attachments/assets/22b629aa-c922-4c57-b788-0b8ee599bca0" />
<img width="956" height="464" alt="image" src="https://github.com/user-attachments/assets/84bac603-9e9a-40a4-aa80-43701bd41635" />
<img width="1115" height="595" alt="image" src="https://github.com/user-attachments/assets/f3ffaec2-e320-4f5f-8c00-aa4d83d660d0" />

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

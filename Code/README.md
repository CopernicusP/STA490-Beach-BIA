# Toronto 311 Complaints Analysis (Beach BIA Case Study)

This project analyzes Toronto 311 service request data with a focus on the **Beach BIA area**, aiming to understand complaint patterns, temporal trends, and distributions of municipal service requests.

The analysis combines exploratory data analysis (EDA) and time-series visualization to provide insights into how different types of city services are requested over time and across categories.

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

The raw Toronto 311 service request data are not included in this repository due to file size limitations.
They can be downloaded from the Toronto Open Data Portal: [https://open.toronto.ca/dataset/311-service-requests/](https://open.toronto.ca/dataset/311-service-requests-customer-initiated/).
All analysis in this project is based on the processed dataset generated from the raw data.

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

### 3. Visualization
- Time-series plots of complaint counts, including decompositions of trend and seasonality.
- Pie chart and Bar charts for category and section distributions

---

## Key Findings
### Among sections
- **Waste & Environmental Enforcement** is the dominant complaint category in the Beach BIA area.
- A small number of service sections account for a large share of total complaints.
- Bike-related and transportation complaints represent a relatively small but distinct subset of total requests.
### time series
- **Overall level trend**: Across all four years, complaint volumes remain high, with no evidence of structural decline.
- **Within-year shape**: Lower complaint volumes in winter months, rising into spring, and peaking around summer before easing in late autumn.
<p align="center">
  <img src="https://github.com/user-attachments/assets/22b629aa-c922-4c57-b788-0b8ee599bca0" width="280" />
  <img src="https://github.com/user-attachments/assets/f3ffaec2-e320-4f5f-8c00-aa4d83d660d0" width="280" />
</p>
<p align="center">
  <img width="280" alt="Monthly trend 2022-2025oct" src="https://github.com/user-attachments/assets/b943eb24-7700-4b8c-83c0-4086fb57c33b" />
  <img width="280" alt="Seasonality" src="https://github.com/user-attachments/assets/733e3f74-5061-4c0f-b83f-023947a09eeb" />
</p>
---

## Tools & Technologies

- **R and jupyer notebook** for all coding, including packages: dplyr, lubridate, ggplot2, scales, stringr.

---

## Contributions

This project was completed as a group effort, with tasks divided across different components of the analysis.

### Jinyi's contributions focused on the **complaint count analysis** and the **bike-related service request analysis**, including both data processing and interpretation.

Specifically, Jinyi was responsible for:
- Computing and analyzing **311 complaint counts**, including aggregations by time and major service categories to examine overall complaint patterns.
- Analyzing **bike-related complaints** , which included:
  - Identifying and filtering bike-related service requests from the full dataset
  - Conducting exploratory data analysis (EDA) on bike complaints
  - Producing visualizations to examine trends and relative prevalence
  - Interpreting bike-related findings in the context of overall 311 service demand
  - Analyzing the composition of bike-related request types (e.g. abandoned bikes, bike lane maintenance, lane damage)

These components provide key quantitative insights into both general complaint patterns and bike-specific service issues within the Beach BIA area.

### Gengqi’s contributions focused on over-sections complaint distributions, time trends, and gratiffi-related service requests in the Beach BIA area.

Specifically, gengqi was responsible for:

- Analyzing overall 311 complaint volumes in the Beach BIA, including:
  - Aggregating complaints by service section and major category
  - Examining the distribution of complaints across divisions such as Collections, Road Operations, and Investigation Services
  - Interpreting complaint patterns
- Conducting time-trend and seasonal analysis of complaint counts, including:
  - Examining daily and monthly complaint trends (2022–2025)
  - Identifying recurring seasonal patterns and overall trend using daily and  monthly aggregation.
  - Specifying trend and seasonal pattern for 2024.
  - Specifying trend and seasonal pattern for five categories.
- Analyzing the composition of Graffiti-related request types

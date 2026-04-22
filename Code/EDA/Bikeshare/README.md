# beachBIA_bikeshare
The following repository is an exploratory data analysis of BikeShare Toronto Ridership Data, a collection of public datasets from the city of Toronto. This analysis focuses on post-COVID trends, specifically from January 2021 to September 2024. The three main objectives is to observe spatial trends, temporal trends, and biker attribute trends within the data to inform budget and planning strategies for the Beach Business Improvement Area (BIA).
## Key Components
-   `scripts` contains the R scripts used to filter the data and create graphs/figures.
-   `visualizations` contains images of the outputted graphs.
## Important Notes
-   This repository does not contain the raw datasets as many of the datasets were too large to upload. Instead, we will assume that the BikeShare CSV files and the Neighbourhood GeoJSON are stored locally in the user's home directory. Some files may need to be renamed to fit the format below, due to inconsistent naming uploads accross years. 
    -   [Neighbourhoods - 4326.geojson](https://open.toronto.ca/dataset/neighbourhoods/): a dataset which stores spatial information about each BIA
    -   [BikeShare_2021_01.csv - BikeShare_2024_09.csv](https://open.toronto.ca/dataset/bike-share-toronto-ridership-data/): monthly datasets which contain BikeShare data
-   These scripts can work with other BIAs, in order to perform new or comparative analysis.

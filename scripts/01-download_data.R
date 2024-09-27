#### Preamble ####
# Purpose: Downloads and saves the hate crimes open data from the City of Toronto's Open Data portal.
# Author: Arshh Relan
# Date: 27 September, 2024
# Contact: arshh.relan@mail.utoronto.ca
# License: MIT
# Pre-requisites: Ensure that the necessary libraries (opendatatoronto, tidyverse) are installed.
# Any other information needed? This script downloads the hate crimes data and saves it for future use.

#### Workspace setup ####

library(opendatatoronto)
library(dplyr)

# Get package
package <- show_package("hate-crimes-open-data")
package

# Get all resources for this package
resources <- list_package_resources("hate-crimes-open-data")

# Identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# Load the first datastore resource as a sample
data <- filter(datastore_resources, row_number() == 1) %>% get_resource()

# Ensure the raw_data folder exists
dir.create("data/raw_data", recursive = TRUE, showWarnings = FALSE)

# Save the data to the raw_data folder
write_csv(data, "../data/raw_data/hate_crimes_raw_data.csv")

# Print success message
message("Data downloaded and saved successfully in raw_data folder.")

#### Preamble ####
# Purpose: Simulates data for hate crimes analysis focusing on geographical and bias-specific trends.
# Author: Arshh Relan
# Date: 27 September, 2024
# Contact: arshh.relan@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# 1. Ensure that the necessary R libraries (`tidyverse`) are installed.
# 2. This script generates synthetic data for testing purposes.
# Any other information needed? 
# This script will be used to simulate data in case of incomplete or unavailable real-world datasets for analysis.

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
# Example simulation: Creating a dataset similar to the real dataset with geographical and bias-specific columns
set.seed(123)

# Define geographical areas (e.g., neighborhood or division codes)
geographical_areas <- c("D12", "D13", "D14", "D52", "D53", "D95", "D102")

# Define bias types (e.g., racial, religious, gender, sexual orientation)
bias_types <- c("Racial", "Religious", "Gender", "Sexual Orientation")

# Simulating a dataset with 500 rows
simulated_data <- tibble(
  OCCURRENCE_YEAR = sample(2018:2023, 500, replace = TRUE),
  OCCURRENCE_DATE = as.Date("2023-01-01") + sample(0:1825, 500, replace = TRUE),
  OCCURRENCE_TIME = sample(0:2359, 500, replace = TRUE),
  REPORTED_YEAR = sample(2018:2023, 500, replace = TRUE),
  REPORTED_DATE = as.Date("2023-01-01") + sample(0:1825, 500, replace = TRUE),
  DIVISION = sample(geographical_areas, 500, replace = TRUE),
  BIAS_TYPE = sample(bias_types, 500, replace = TRUE),
  PRIMARY_OFFENCE = sample(c("Assault", "Mischief", "Wilful Promotion of Hatred"), 500, replace = TRUE),
  ARREST_MADE = sample(c("YES", "NO"), 500, replace = TRUE)
)

# Preview the simulated data
head(simulated_data)

# Save simulated data to a CSV file for testing purposes
write_csv(simulated_data, "simulated_hate_crimes_data.csv")


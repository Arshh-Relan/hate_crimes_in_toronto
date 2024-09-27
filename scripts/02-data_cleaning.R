#### Preamble ####
# Purpose: Cleans the raw hate crimes data recorded in Toronto, focusing on geographical and bias-specific columns.
# Author: Arshh Relan
# Date: 27 September, 2024
# Contact: arshh.relan@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# 1. The raw hate crimes dataset should be downloaded using the `01-download_data.R` script.
# 2. Ensure that the necessary R libraries (`tidyverse` and `janitor`) are installed.
# Any other information needed? 
# The cleaned data will be saved in "Data/analysis data/" for future use.

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
# Load the raw data (assuming it's already loaded into the `data` object)

cleaned_data <- 
  data |>
  janitor::clean_names() |>
  select(occurrence_year, occurrence_date, division, 
         age_bias, race_bias, religion_bias, sexual_orientation_bias, 
         gender_bias, primary_offence, arrest_made) |>
  
  # Convert 'None' values to NA in bias columns
  mutate(
    race_bias = na_if(race_bias, "None"),
    religion_bias = na_if(religion_bias, "None"),
    sexual_orientation_bias = na_if(sexual_orientation_bias, "None"),
    gender_bias = na_if(gender_bias, "None"),
    age_bias = na_if(age_bias, "None")
  ) |>
  
  # Create the bias_type column
  mutate(
    bias_type = case_when(
      !is.na(race_bias) ~ "Racial",
      !is.na(religion_bias) ~ "Religious",
      !is.na(sexual_orientation_bias) ~ "Sexual Orientation",
      !is.na(gender_bias) ~ "Gender",
      !is.na(age_bias) ~ "Age",
      TRUE ~ "Other"
    ),
    
    # Convert dates and factor variables
    occurrence_date = as.Date(occurrence_date),
    division = as.factor(division),
    bias_type = as.factor(bias_type),
    primary_offence = as.factor(primary_offence),
    arrest_made = as.factor(arrest_made)
  ) |>
  
  # Filter data by occurrence year
  filter(occurrence_year >= 2010 & occurrence_year <= 2023)


#### Save cleaned data ####
# Create the directory if it doesn't exist
dir.create("data/analysis_data", recursive = TRUE, showWarnings = FALSE)

# Save the cleaned data into the correct folder
write_csv(cleaned_data, "../data/analysis_data/cleaned_hate_crimes_data.csv")

# Print success message
message("Cleaned data saved successfully.")

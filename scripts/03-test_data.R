#### Preamble ####
# Purpose: Tests the cleaned data and visualizations for integrity and consistency.
# Author: Arshh Relan
# Date: 27 September, 2024
# Contact: arshh.relan@mail.utoronto.ca
# License: MIT
# Pre-requisites: The cleaned dataset should be generated and saved as "cleaned_data.csv".
# Any other information needed? Ensure that all necessary libraries (e.g., tidyverse) are installed.


#### Workspace setup ####
library(tidyverse)

# Load cleaned data for testing
cleaned_data <- read_csv("path/to/cleaned_data.csv")


#### Test data ####

# 1. Test that there are no missing values in key columns
test_no_missing_values <- function(data) {
  key_columns <- c("occurrence_year", "occurrence_date", "neighbourhood_158", 
                   "bias_type", "primary_offence", "arrest_made")
  
  missing_values <- data %>%
    select(all_of(key_columns)) %>%
    summarise_all(~ sum(is.na(.))) %>%
    pivot_longer(everything(), names_to = "column", values_to = "missing_count")
  
  if (all(missing_values$missing_count == 0)) {
    message("Test 1 Passed: No missing values in key columns.")
  } else {
    message("Test 1 Failed: Some key columns have missing values.")
    print(missing_values)
  }
}

# 2. Test that the dataset contains at least one record from both 2018 and the present year
test_year_range <- function(data) {
  year_range <- c(2018, 2023)  # Adjust for the present year
  
  years_present <- data %>%
    filter(occurrence_year %in% year_range) %>%
    summarise(count_2018 = sum(occurrence_year == 2018),
              count_present = sum(occurrence_year == 2023))
  
  if (years_present$count_2018 > 0 & years_present$count_present > 0) {
    message("Test 2 Passed: Data contains records for both 2018 and the present year.")
  } else {
    message("Test 2 Failed: Missing records for either 2018 or the present year.")
    print(years_present)
  }
}

# 3. Test that the bias_type column contains the expected categories
test_bias_types <- function(data) {
  expected_bias_types <- c("Racial", "Religious", "Sexual Orientation", "Gender", "Age", "Other")
  
  actual_bias_types <- unique(data$bias_type)
  
  if (all(expected_bias_types %in% actual_bias_types)) {
    message("Test 3 Passed: All expected bias types are present.")
  } else {
    message("Test 3 Failed: Some expected bias types are missing.")
    print(setdiff(expected_bias_types, actual_bias_types))
  }
}

# 4. Test that the neighborhood names are valid (i.e., no missing or incorrect neighborhood names)
test_neighborhood_names <- function(data) {
  invalid_neighborhoods <- data %>%
    filter(is.na(neighbourhood_158) | neighbourhood_158 == "")
  
  if (nrow(invalid_neighborhoods) == 0) {
    message("Test 4 Passed: No invalid neighborhood names.")
  } else {
    message("Test 4 Failed: Some records have invalid or missing neighborhood names.")
    print(invalid_neighborhoods)
  }
}

#### Run Tests ####
test_no_missing_values(cleaned_data)
test_year_range(cleaned_data)
test_bias_types(cleaned_data)
test_neighborhood_names(cleaned_data)

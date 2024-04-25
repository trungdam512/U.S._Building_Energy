library(tidyverse)

# Load in 2015 ACS data
acs2015 <- tidycensus::get_acs(
  year = 2015,
  geography = "state",
  variables = c("B19013_001", "B25003_001", "B25058_001",  "B25003_001", "B25003_002", "B25003_003", "B25077_001", "B25105_001", "B25035_001", "B25024_001", "B25024_002", "B25024_003", "B25024_004", "B25024_005", "B25024_006", "B25024_007", "B25024_008", "B25024_009", "B25024_010"),
  output = "wide",
  geometry = TRUE
) %>%
  rename(
    "medianIncome" = "B19013_001E",
    "medContractRent" = "B25058_001E",
    "tenureTotal" = "B25003_001E",
    "tenureOwned" = "B25003_002E",
    "tenureRented" = "B25003_003E",
    "medianHomeValue"= "B25077_001E",
    "monthHousingCosts" = "B25105_001E",
    "med_year_built" = "B25035_001E",
    "total_units"= "B25024_001E",
    "unit_1_detached" = "B25024_002E",
    "unit_1_attached" = "B25024_003E",
    "unit_2" = "B25024_004E",
    "unit_3_4" = "B25024_005E",
    "unit_5_9" = "B25024_006E",
    "unit_10_19" = "B25024_007E",
    "unit_20_49" ="B25024_008E",
    "unit_50_plus" = "B25024_009E",
    "mobile_home" = "B25024_010E") %>% 
  shift_geometry()


# Divide ACS data by region and aggregate unit type to match RECS data
acs2015_region <- acs2015 %>%
  filter(NAME != "Puerto Rico") %>%
  mutate(
    units_2_4 = unit_2 + unit_3_4,
    units_5_plus = unit_5_9 + unit_10_19 + unit_20_49 + unit_50_plus
  ) %>% 
  mutate(
    region = case_when(
      NAME %in% c(
        "Connecticut",
        "Maine",
        "Massachusetts",
        "New Hampshire",
        "Rhode Island",
        "Vermont",
        "New Jersey",
        "New York",
        "Pennsylvania"
      ) ~ "Northeast",
      NAME %in% c(
        "Illinois",
        "Indiana",
        "Michigan",
        "Ohio",
        "Wisconsin",
        "Iowa",
        "Kansas",
        "Minnesota",
        "Missouri",
        "Nebraska",
        "North Dakota",
        "South Dakota"
      ) ~ "Midwest",
      NAME %in% c(
        "Delaware",
        "Florida",
        "Georgia",
        "Maryland",
        "North Carolina",
        "South Carolina",
        "Virginia",
        "District of Columbia",
        "West Virginia",
        "Alabama",
        "Kentucky",
        "Mississippi",
        "Tennessee",
        "Arkansas",
        "Louisiana",
        "Oklahoma",
        "Texas"
      ) ~ "South",
      NAME %in% c(
        "Arizona",
        "Colorado",
        "Idaho",
        "Montana",
        "Nevada",
        "New Mexico",
        "Utah",
        "Wyoming",
        "Alaska",
        "California",
        "Hawaii",
        "Oregon",
        "Washington"
      ) ~ "West",
    )
  )

write_rds(acs2015_region, "data/acs_2015_cleaned.RDS")

# explore 2015 data
library(tidyverse)

recs2015 <- read.csv("data/recs_2016/recs2015_public_v4.csv")

# recs2020_1 <- readxl::read_xlsx("../data/HC 1.1.xlsx")


# possibly relevant data:
# total site electricity usage, "KWH"
# "BTUEL" - total site electricity usage in BTU
# "DOLLAREL" - total electricity cost in dollars
# also look at cost for space heating and air conditioning? i just think that's interesting
# "CUFEETNG" - NG usage in cubic feet
# "BTUNG" and "DOLLARNG"
# "BTULP" and "DOLLARLP" for propane
# "BTUFO" and "DOLLARFO" for kerosene and fuel oil
# "TOTALBTU" and "TOTALDOL"
# geographic/demographic: "REGIONC" through "TYPEHUQ"

recs2015_cleaned <- recs2015 %>% 
  select(
    DOEID:TYPEHUQ,
    YEARMADERANGE,
    OCCUPYYRANGE,
    HEATHOME,
    EQUIPMUSE,
    BTUEL,
    DOLLAREL,
    BTUNG,
    DOLLARNG,
    BTULP,
    DOLLARLP,
    BTUFO,
    DOLLARFO,
    TOTALBTU,
    TOTALDOL
  ) %>% 
  mutate(
    region_name = case_when(
      REGIONC == 1 ~ "Northeast",
      REGIONC == 2 ~ "Midwest",
      REGIONC == 3 ~ "South",
      REGIONC == 4 ~ "West"
    ),
    housing_type = case_when(
      TYPEHUQ == 1 ~ "Mobile home",
      TYPEHUQ == 2 ~ "Single family detached",
      TYPEHUQ == 3 ~ "Single family attached",
      TYPEHUQ == 4 ~ "Apt small building",
      TYPEHUQ == 5 ~ "Apt large building"
    ),
    yearmade = case_when(
      YEARMADERANGE == 1 ~ "Before 1950",
      YEARMADERANGE == 2 ~ "1950 to 1959",
      YEARMADERANGE == 3 ~ "1960 to 1969",
      YEARMADERANGE == 4 ~ "1970 to 1979",
      YEARMADERANGE == 5 ~ "1980 to 1989",
      YEARMADERANGE == 6 ~ "1990 to 1999",
      YEARMADERANGE == 7 ~ "2000 to 2009",
      YEARMADERANGE == 8 ~ "2010 to 2015"
    ),
    homeheat = case_when(
      HEATHOME == 1 ~ "Yes",
      HEATHOME == 0 ~ "No"
    ),
    equip_used = case_when(
      EQUIPMUSE == 1 ~ "Set one temperature and leave it there most of the time",
      EQUIPMUSE == 2 ~ "Manually adjust the temperature at night or when no one is at home",
      EQUIPMUSE == 3 ~ "Program the thermostat to automatically adjust the temperature during the day and night at certain times",
      EQUIPMUSE == 4 ~ "Turn equipment on or off as needed",
      EQUIPMUSE == 5 ~ "Our household does not have control over the equipment",
      EQUIPMUSE == 6 ~ "Other",
      EQUIPMUSE == 7 ~ "Not applicable"
    ),
    equip_used_short = case_when(
      EQUIPMUSE == 1 ~ "One temp",
      EQUIPMUSE == 2 ~ "Manually adjust",
      EQUIPMUSE == 3 ~ "Program thermostat",
      EQUIPMUSE == 4 ~ "As needed",
      EQUIPMUSE == 5 ~ "No control",
      EQUIPMUSE == 9 ~ "Other",
      EQUIPMUSE == -2 ~ "Not applicable"
    )
  )

write_rds(recs2015_cleaned, "data/recs_2015_cleaned.RDS")

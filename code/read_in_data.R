# explore 2015 data
library(tidyverse)

recs2015 <- read.csv("data/recs_2016/recs2015_public_v4.csv")

# recs2020_1 <- readxl::read_xlsx("../data/HC 1.1.xlsx")

yesno_factor <- function(var){
  case_when(
        {{ var }} == 1 ~ "Yes",
        {{ var }} == 0 ~ "No"
      )
}

recs2015_cleaned <- recs2015 %>% 
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
    homeheat = yesno_factor(HEATHOME),
    equip_used = case_when(
      EQUIPMUSE == 1 ~ "Set one temperature and leave it there most of the time",
      EQUIPMUSE == 2 ~ "Manually adjust the temperature at night or when no one is at home",
      EQUIPMUSE == 3 ~ "Program the thermostat to automatically adjust the temperature during the day and night at certain times",
      EQUIPMUSE == 4 ~ "Turn equipment on or off as needed",
      EQUIPMUSE == 5 ~ "Our household does not have control over the equipment",
      EQUIPMUSE == 6 ~ "Other",
      EQUIPMUSE == 7 ~ NA
    ),
    equip_used_short = case_when(
      EQUIPMUSE == 1 ~ "One temp",
      EQUIPMUSE == 2 ~ "Manually adjust",
      EQUIPMUSE == 3 ~ "Program thermostat",
      EQUIPMUSE == 4 ~ "As needed",
      EQUIPMUSE == 5 ~ "No control",
      EQUIPMUSE == 9 ~ "Other",
      EQUIPMUSE == -2 ~ NA
    ),
    adq_insulation = case_when(
      ADQINSUL == 1 ~"Well insulated",
      ADQINSUL == 2 ~"Adequately insulated",
      ADQINSUL == 3 ~"Poorly insulated",
      ADQINSUL == 4 ~"Not insulated"
    ),
    thermostat = case_when(
      THERMAIN == 1 ~ "Yes",
      THERMAIN == 0 ~ "No",
      THERMAIN == -2 ~ NA
    ),
    aircon = yesno_factor(AIRCOND),
    elec_warm = yesno_factor(ELWARM),
    elec_cool = yesno_factor(ELCOOL),
    elec_water = yesno_factor(ELWATER),
    ng_warm = yesno_factor(UGWARM),
    ng_water = yesno_factor(UGWATER),
    audit = yesno_factor(AUDIT),
    audit_change = yesno_factor(AUDITCHG),
    smart_meter = yesno_factor(SMARTMETER),
    smart_meter_access = yesno_factor(INTDATA),
    smart_meter_viewed = yesno_factor(INTDATAACC),
    # update later with across()
    hh_income = case_when(
      MONEYPY == 1 ~ "Less than $20,000",
      MONEYPY == 2 ~ "$20,000 - $39,999",
      MONEYPY == 3 ~ "$40,000 - $59,999",
      MONEYPY == 4 ~ "$60,000 to $79,999",
      MONEYPY == 5 ~ "$80,000 to $99,999",
      MONEYPY == 6 ~ "$100,000 to $119,999",
      MONEYPY == 7 ~ "$120,000 to $139,999",
      MONEYPY == 8 ~ "$140,000 or more"
    ),
    energy_asst_prgm = yesno_factor(ENERGYASST)
  ) %>%
  select(
    ID = DOEID,
    region_name,
    census_div = DIVISION,
    METROMICRO,
    UATYP10,
    housing_type,
    yearmade,
    OCCUPYYRANGE,
    YEARMADERANGE,
    homeheat,
    equip_used,
    equip_used_short,
    ADQINSUL,
    # heating details
    adq_insulation,
    thermostat,
    aircon,
    elec_warm,
    elec_cool,
    elec_water,
    ng_warm,
    ng_water,
    sqft_cooled= TOTCSQFT,
    sqft_warmed = TOTHSQFT,
    # details
    TOTROOMS,
    TOTSQFT_EN,
    audit,
    audit_change,
    smart_meter,
    smart_meter_access,
    smart_meter_viewed,
    hh_income,
    energy_asst_prgm,
    # energy use
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
  )

write_rds(recs2015_cleaned, "data/recs_2015_cleaned.RDS")

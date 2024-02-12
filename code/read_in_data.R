# explore 2015 data
library(tidyverse)

recs2015 <- read.csv("../data/recs_2016/recs2015_public_v4.csv")

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

write_rds(recs2015_cleaned, "../data/recs_2015_cleaned.RDS")

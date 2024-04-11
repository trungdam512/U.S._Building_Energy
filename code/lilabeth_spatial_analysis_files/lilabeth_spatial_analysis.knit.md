---
title: "Building Energy Spatial Viz"
format: html
editor: visual
---

::: {.cell}
::: {.cell-output .cell-output-stderr}
```
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.4.4     ✔ tibble    3.2.1
✔ lubridate 1.9.3     ✔ tidyr     1.3.0
✔ purrr     1.0.2     
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
Linking to GEOS 3.11.0, GDAL 3.5.3, PROJ 9.1.0; sf_use_s2() is TRUE

terra 1.7.65


Attaching package: 'terra'


The following object is masked from 'package:tidyr':

    extract


To enable caching of data, set `options(tigris_use_cache = TRUE)`
in your R script or .Rprofile.


Attaching package: 'tigris'


The following object is masked from 'package:terra':

    blocks
```
:::
:::

::: {.cell}
::: {.cell-output .cell-output-stderr}
```
Getting data from the 2011-2015 5-year ACS
```
:::

::: {.cell-output .cell-output-stderr}
```
Warning: • You have not set a Census API key. Users without a key are limited to 500
queries per day and may experience performance limitations.
ℹ For best results, get a Census API key at
http://api.census.gov/data/key_signup.html and then supply the key to the
`census_api_key()` function to use it throughout your tidycensus session.
This warning is displayed once per session.
```
:::

::: {.cell-output .cell-output-stderr}
```
Downloading feature geometry from the Census website.  To cache shapefiles for use in future sessions, set `options(tigris_use_cache = TRUE)`.
```
:::

::: {.cell-output .cell-output-stdout}
```

  |                                                                            
  |                                                                      |   0%
  |                                                                            
  |=                                                                     |   1%
  |                                                                            
  |=                                                                     |   2%
  |                                                                            
  |==                                                                    |   3%
  |                                                                            
  |====                                                                  |   5%
  |                                                                            
  |====                                                                  |   6%
  |                                                                            
  |=====                                                                 |   6%
  |                                                                            
  |=====                                                                 |   7%
  |                                                                            
  |======                                                                |   8%
  |                                                                            
  |=======                                                               |   9%
  |                                                                            
  |=========                                                             |  12%
  |                                                                            
  |=========                                                             |  13%
  |                                                                            
  |==================                                                    |  26%
  |                                                                            
  |=======================                                               |  33%
  |                                                                            
  |========================                                              |  34%
  |                                                                            
  |=========================                                             |  36%
  |                                                                            
  |==========================                                            |  38%
  |                                                                            
  |============================                                          |  40%
  |                                                                            
  |=============================                                         |  42%
  |                                                                            
  |===============================                                       |  44%
  |                                                                            
  |================================                                      |  46%
  |                                                                            
  |=================================                                     |  47%
  |                                                                            
  |==================================                                    |  49%
  |                                                                            
  |===================================                                   |  50%
  |                                                                            
  |====================================                                  |  51%
  |                                                                            
  |=====================================                                 |  53%
  |                                                                            
  |=======================================                               |  55%
  |                                                                            
  |=======================================                               |  56%
  |                                                                            
  |==========================================                            |  60%
  |                                                                            
  |============================================                          |  63%
  |                                                                            
  |==================================================                    |  72%
  |                                                                            
  |=====================================================                 |  75%
  |                                                                            
  |=======================================================               |  79%
  |                                                                            
  |========================================================              |  79%
  |                                                                            
  |========================================================              |  80%
  |                                                                            
  |=========================================================             |  81%
  |                                                                            
  |==========================================================            |  82%
  |                                                                            
  |===========================================================           |  84%
  |                                                                            
  |============================================================          |  86%
  |                                                                            
  |======================================================================| 100%
```
:::
:::

::: {.cell}

```{.r .cell-code}
ggplot() +
  geom_sf(data = acs2015, aes(fill = medContractRent)) +  
  scale_fill_distiller(palette = "Greens", 
                       direction = 1) + 
  labs(title = "Median Rent by State (Utilities Not Included), 2011-2015",
       caption = "Data source: 2011-2015 5-year ACS, US Census Bureau",
       fill = "ACS estimate") + 
    ggthemes::theme_map()
```

::: {.cell-output-display}
![](lilabeth_spatial_analysis_files/figure-html/unnamed-chunk-3-1.png){width=672}
:::

```{.r .cell-code}
ggplot() +
  geom_sf(data = acs2015, aes(fill = medianHomeValue)) +
  scale_fill_distiller(palette = "Greens", 
                       direction = 1) + 
  labs(title = "Median Home Value by State, 2011-2015",
       caption = "Data source: 2011-2015 5-year ACS, US Census Bureau",
       fill = "ACS estimate") + 
    ggthemes::theme_map()
```

::: {.cell-output-display}
![](lilabeth_spatial_analysis_files/figure-html/unnamed-chunk-3-2.png){width=672}
:::

```{.r .cell-code}
ggplot() +
  geom_sf(data = acs2015, aes(fill = med_year_built)) +
    scale_fill_distiller(palette = "Greens", 
                       direction = 1) + 
  labs(title = "Median Year House Was Built by State, 2011-2015",
       caption = "Data source: 2011-2015 5-year ACS, US Census Bureau",
       fill = "ACS estimate") + 
    ggthemes::theme_map()
```

::: {.cell-output-display}
![](lilabeth_spatial_analysis_files/figure-html/unnamed-chunk-3-3.png){width=672}
:::

```{.r .cell-code}
ggplot() +
  geom_sf(data = acs2015, aes(fill = `1_unit_detached`/total_units)) +
    scale_fill_distiller(palette = "Purples", 
                       direction = 1) + 
  labs(title = "Proportion of 1 Unit Detached Homes, 2011-2015",
       caption = "Data source: 2011-2015 5-year ACS, US Census Bureau",
       fill = "ACS estimate") + 
    ggthemes::theme_map()
```

::: {.cell-output-display}
![](lilabeth_spatial_analysis_files/figure-html/unnamed-chunk-3-4.png){width=672}
:::

```{.r .cell-code}
ggplot() +
  geom_sf(data = acs2015, aes(fill = `1_unit_attached`/total_units)) +
      scale_fill_distiller(palette = "Purples", 
                       direction = 1) + 
  labs(title = "Proportion of 1 Unit Attached Homes, 2011-2015",
       caption = "Data source: 2011-2015 5-year ACS, US Census Bureau",
       fill = "ACS estimate") + 
    ggthemes::theme_map()
```

::: {.cell-output-display}
![](lilabeth_spatial_analysis_files/figure-html/unnamed-chunk-3-5.png){width=672}
:::

```{.r .cell-code}
ggplot() +
  geom_sf(data = acs2015, aes(fill = `2_unit`/total_units)) +
       scale_fill_distiller(palette = "Purples", 
                       direction = 1) + 
  labs(title = "Proportion of 2 Unit Homes, 2011-2015",
       caption = "Data source: 2011-2015 5-year ACS, US Census Bureau",
       fill = "ACS estimate") + 
    ggthemes::theme_map()
```

::: {.cell-output-display}
![](lilabeth_spatial_analysis_files/figure-html/unnamed-chunk-3-6.png){width=672}
:::

```{.r .cell-code}
ggplot() +
  geom_sf(data = acs2015, aes(fill = `3_4_unit`/total_units)) +
        scale_fill_distiller(palette = "Purples", 
                       direction = 1) + 
  labs(title = "Proportion of 3-4 Unit Homes, 2011-2015",
       caption = "Data source: 2011-2015 5-year ACS, US Census Bureau",
       fill = "ACS estimate") + 
    ggthemes::theme_map()
```

::: {.cell-output-display}
![](lilabeth_spatial_analysis_files/figure-html/unnamed-chunk-3-7.png){width=672}
:::

```{.r .cell-code}
ggplot() +
  geom_sf(data = acs2015, aes(fill = `5_9_unit`/total_units)) +
        scale_fill_distiller(palette = "Purples", 
                       direction = 1) + 
  labs(title = "Proportion of 5-9 Unit Homes, 2011-2015",
       caption = "Data source: 2011-2015 5-year ACS, US Census Bureau",
       fill = "ACS estimate") + 
    ggthemes::theme_map()
```

::: {.cell-output-display}
![](lilabeth_spatial_analysis_files/figure-html/unnamed-chunk-3-8.png){width=672}
:::

```{.r .cell-code}
ggplot() +
  geom_sf(data = acs2015, aes(fill = `10_19_unit`/total_units)) +
        scale_fill_distiller(palette = "Purples", 
                       direction = 1) + 
  labs(title = "Proportion of 10-19 Unit Homes, 2011-2015",
       caption = "Data source: 2011-2015 5-year ACS, US Census Bureau",
       fill = "ACS estimate") + 
    ggthemes::theme_map()
```

::: {.cell-output-display}
![](lilabeth_spatial_analysis_files/figure-html/unnamed-chunk-3-9.png){width=672}
:::

```{.r .cell-code}
ggplot() +
  geom_sf(data = acs2015, aes(fill = `20_49_unit`/total_units)) +
        scale_fill_distiller(palette = "Purples", 
                       direction = 1) + 
  labs(title = "Proportion of 20-49 Unit Homes, 2011-2015",
       caption = "Data source: 2011-2015 5-year ACS, US Census Bureau",
       fill = "ACS estimate") + 
    ggthemes::theme_map()
```

::: {.cell-output-display}
![](lilabeth_spatial_analysis_files/figure-html/unnamed-chunk-3-10.png){width=672}
:::
:::


# Effects of interannual weather on understory plant traits in old-growth beech forests

[![DOI](https://img.shields.io/badge/DOI-doi-blue)](https://doi.org/doi) ![Code License](https://img.shields.io/badge/code%20license-GPL--3.0-green) ![Data License](https://img.shields.io/badge/data%20license-CC%20BY%204.0-blue)

## Description
Data and code supporting the analyses in the article "Effects of interannual weather on understory plant traits in old-growth beech forests", De Benedictis et al.

## Abstract
abstract

## Instructions
To reproduce the analyses, render or inspect the quarto notebooks following the numbering. R ≥ 4.1 at least is required.
You need to install `cmdstanr`, following [these instructions](https://mc-stan.org/cmdstanr/). There are implicit dependencies or non-CRAN packages, documented in the setup of each notebook, which are the following:

- `install.packages('datawizard')`
- `install.packages('shape')`
- `install.packages('hexbin')`
- `pak::pak("teunbrand/elementalist")`

## Authors
- authors

## Affiliations
- affiliations

## Contact
📧 luciano.debenedictis@unicam.it

## Funding
- funding

## Citation
If you use this work please cite it using the DOI(s) above.

> citation placeholder

## License
- **Code:** licensed under GPL-3.0.
- **Data:** licensed under CC BY 4.0.

## Additional information
While distributional properties of imputations are conserved, strict reproducibility of exact imputed with the package mice was found to depend on the specific implementation of matrix products. For this reason, setting a seed only ensures reproducibility on the same machine and OS. Additionally setting a standard matrix backend was found to be sufficient to achieve reproducibility across machines and OSs. Alternatively, the provided weather.RData and cwm_itp.rds can be used as inputs to notebooks 6 and 8, respectively.

## Directory Structure
```text
Project/
├── Data/
│   ├── abundances.csv
│   ├── cover.csv
│   ├── sample_dates.csv
│   ├── traits.csv
│   ├── traits.xlsx
│   ├── try_data.txt
│   ├── try_traits.csv
│   └── weather_data.csv
├── fits/
│   ├── cwm/
│   │   ├── BBRsize.itp.rds
│   │   ├── la.itp.rds
│   │   ├── ln.itp.rds
│   │   ├── offspring.itp.rds
│   │   ├── persistence.itp.rds
│   │   ├── ph.itp.rds
│   │   ├── sla.itp.rds
│   │   ├── sm.itp.rds
│   │   ├── spread.itp.rds
│   │   └── ssd.itp.rds
│   ├── extra/
│   │   ├── subplot.above.rds
│   │   ├── subplot.below.rds
│   │   └── subplot.overall.rds
│   ├── fd/
│   │   ├── above.itp.rds
│   │   ├── above.ofd.rds
│   │   ├── below.itp.rds
│   │   ├── below.ofd.rds
│   │   ├── overl.itp.rds
│   │   └── overl.ofd.rds
│   ├── sim/
│   │   ├── sim.cent.neg.rds
│   │   ├── sim.cent.nul.rds
│   │   ├── sim.cent.pos.rds
│   │   ├── sim.conf.neg.rds
│   │   ├── sim.conf.nul.rds
│   │   ├── sim.conf.pos.rds
│   │   ├── sim.fix.neg.rds
│   │   ├── sim.fix.nul.rds
│   │   ├── sim.fix.pos.rds
│   │   ├── sim.int.dd.w.b.rds
│   │   ├── sim.int.dd.w.c1.rds
│   │   ├── sim.int.dd.w.rds
│   │   ├── sim.int.dd.x.rds
│   │   ├── sim.int.dem.w.b.rds
│   │   ├── sim.int.dem.w.c1.rds
│   │   ├── sim.int.dem.w.rds
│   │   ├── sim.int.dem.x.rds
│   │   ├── sim.int.std.w.b.rds
│   │   ├── sim.int.std.w.c1.rds
│   │   ├── sim.int.std.w.rds
│   │   ├── sim.int.std.x.rds
│   │   ├── sim.lat.me.neg.rds
│   │   ├── sim.lat.me.nul.rds
│   │   ├── sim.lat.me.pos.rds
│   │   ├── sim.lat.me.pos.txt
│   │   ├── sim.lat.mi.neg.rds
│   │   ├── sim.lat.mi.nul.rds
│   │   ├── sim.lat.mi.pos.rds
│   │   ├── sim.lat.mi.pos.txt
│   │   ├── sim.mund.neg.rds
│   │   ├── sim.mund.nul.rds
│   │   ├── sim.mund.pos.rds
│   │   ├── sim.nai.neg.rds
│   │   ├── sim.nai.nul.rds
│   │   └── sim.nai.pos.rds
│   ├── prior_fd.rds
│   └── prior_h_ln.rds
├── intermediate/
│   ├── cwm_itp.rds
│   ├── data.RData
│   ├── dates.rds
│   ├── fits_cwm.rds
│   ├── fits_fd.rds
│   ├── SES.RData
│   ├── weat.rds
│   └── weather.RData
├── notebooks/
│   ├── 0_try_data.html
│   ├── 1_DAG.html
│   ├── 2_data.html
│   ├── 3_Rao.html
│   ├── 4_weather.html
│   ├── 5_simulations.html
│   ├── 6_fd_models.html
│   ├── 7_cwm_setup.html
│   ├── 8_cwm_models.html
│   └── 9_figures.html
│   └── 99_extract_clim.html
├── output/
│   ├── clim_comparison.csv
│   ├── coefs_cwm_hu.png
│   ├── coefs_cwm_main.png
│   ├── coefs_fd.png
│   ├── DAG.png
│   ├── itp_ofd_comparison.csv
│   ├── pred_cwm_1.png
│   ├── pred_cwm_2.png
│   ├── pred_cwm_3.png
│   ├── pred_cwm_BBRsize.png
│   ├── pred_cwm_la.png
│   ├── pred_cwm_ln.png
│   ├── pred_cwm_offspring.png
│   ├── pred_cwm_persistence.png
│   ├── pred_cwm_ph.png
│   ├── pred_cwm_sla.png
│   ├── pred_cwm_sm.png
│   ├── pred_cwm_spread.png
│   ├── pred_cwm_ssd.png
│   ├── pred_fd_aboveground_itp.png
│   ├── pred_fd_aboveground_ofd.png
│   ├── pred_fd_belowground_itp.png
│   ├── pred_fd_belowground_ofd.png
│   ├── pred_fd_itp.png
│   ├── pred_fd_overall_itp.png
│   └── pred_fd_overall_ofd.png
├── _quarto.yml
├── 0_try_data.qmd
├── 1_DAG.qmd
├── 2_data.qmd
├── 3_Rao.qmd
├── 4_weather.qmd
├── 5_simulations.qmd
├── 6_fd_models.qmd
├── 7_cwm_setup.qmd
├── 8_cwm_models.qmd
├── 9_figures.qmd
├── 99_extract_clim.qmd
├── beech_filtering.Rproj
├── functions.R
├── README.md
└── references.bib
```

## Data Files

### `Data/abundances.csv`

Vegetation survey data

**Date collected:** 1999–2011

**Dimensions:** 8440 rows × 5 columns

**Variables:**

| Column | Type | Description | Units | Summary |
| :----- | :--- | :---------- | :---- | :------ |
| `date` | numeric | survey year | y | range 1999–2011 \| NAs: 0 |
| `plot` | categorical | site identifier |  | levels: ABR01, CAL03, CAM04, VEN20 \| NAs: 0 |
| `SU` | numeric | progressive sampling unit number |  | range 1–100 \| NAs: 0 |
| `species` | categorical | species name |  | 90 unique values \| NAs: 0 |
| `cover` | numeric | species cover | cm^2 | range 1–2400 \| mean 115.7 \| NAs: 0 |

### `Data/cover.csv`

Canopy cover estimated during the surveys

**Date collected:** 1999–2023

**Dimensions:** 71 rows × 3 columns

**Variables:**

| Column | Type | Description | Units | Summary |
| :----- | :--- | :---------- | :---- | :------ |
| `year` | numeric | survey year | y | range 1999–2023 \| NAs: 0 |
| `site` | categorical | site identifier |  | levels: 01-ABR1, 03-CAL1, 04-CAM1, 20-VEN1 \| NAs: 0 |
| `cover` | numeric | canopy cover | % | range 58.75–97.58 \| mean 89.77 \| NAs: 1 |

### `Data/sample_dates.csv`

Dates of vegetation surveys

**Date collected:** July 1999 – August 2011

**Dimensions:** 32 rows × 9 columns

**Variables:**

| Column | Type | Description | Units | Summary |
| :----- | :--- | :---------- | :---- | :------ |
| `site` | categorical | site identifier |  | levels: 01-ABR1, 03-CAL1, 04-CAM1, 20-VEN1 \| NAs: 0 |
| `code_country` | numeric | ICP country code (5 = Italy) |  | range 5–5 \| NAs: 0 |
| `code_plot` | numeric | progressive site identifier |  | range 1–20 \| NAs: 0 |
| `survey_year` | numeric | survey year | y | range 1999–2011 \| NAs: 0 |
| `date_sampling` | date | sampling date in ISO format |  | range 1999-07-10–2011-08-03 \| NAs: 0 |
| `code_altitude` | numeric | altitude code |  | range 19–31 \| NAs: 0 |
| `code_fence` | numeric | code for surveys 1 = inside the fence 2 = outside |  | range 1–1 \| NAs: 0 |
| `latitude` | numeric | latitude | decimal degrees | range 38.43–46.06 \| NAs: 0 |
| `longitude` | numeric | longitude | decimal degrees | range 12.38–16.18 \| NAs: 0 |

### `Data/traits.csv`

CSV version of `traits.xlsx`

### `Data/traits.xlsx`

Trait data, including sources if different from main sources

**Dimensions:** 82 rows × 18 columns

**Variables:**

| Column | Type | Description | Units | Summary |
| :----- | :--- | :---------- | :---- | :------ |
| `species` | categorical |  |  | 82 unique values \| NAs: 0 |
| `BBRsize` | numeric |  |  | range 0–42.5 \| mean 17.79 \| NAs: 0 |
| `offspring` | numeric |  |  | range 0–6 \| mean 1.562 \| NAs: 0 |
| `spread` | numeric |  |  | range 0–32.6 \| mean 5.521 \| NAs: 0 |
| `persistence` | numeric |  |  | range 0–4 \| mean 2.643 \| NAs: 0 |
| `cgo` | categorical |  |  | levels: Both, NonClonal, Root, Stem \| NAs: 0 |
| `la` | numeric |  |  | range 7.42–70680 \| mean 3474 \| NAs: 3 |
| `ln` | numeric |  |  | range 14.97–51.6 \| mean 27.3 \| NAs: 9 |
| `ph` | numeric |  |  | range 0.07047–1.491 \| mean 0.4046 \| NAs: 0 |
| `sla` | numeric |  |  | range 6.653–104.1 \| mean 36.23 \| NAs: 3 |
| `ssd` | numeric |  |  | range 0.09811–0.5888 \| mean 0.2036 \| NAs: 10 |
| `sm` | numeric |  |  | range 1.94e-05–187.3 \| mean 7.397 \| NAs: 1 |
| `Notes clonality` | categorical |  |  | 16 unique values \| NAs: 66 |
| `Notes aboveground` | categorical |  |  | 20 unique values \| NAs: 50 |
| `species_DB` | categorical |  |  | 81 unique values \| NAs: 0 |
| `Family` | categorical |  |  | 36 unique values \| NAs: 0 |
| `Growth form` | categorical |  |  | levels: climber, fern, herbaceous graminoid, herbaceous non-graminoid, shrub, shrub/tree \| NAs: 0 |
| `Fern_Sapro` | categorical |  |  | levels: F, Sapro \| NAs: 74 |

### `Data/try_data.txt`

Trait data as downloaded from TRY.

**Dimensions:** 88888 rows × 29 columns

### `Data/try_traits.csv`

Processed TRY data from 0_try_data.qmd

**Dimensions:** 31 rows × 7 columns

**Variables:**

| Column | Type | Description | Units | Summary |
| :----- | :--- | :---------- | :---- | :------ |
| `AccSpeciesName` | categorical | species name |  | 31 unique values \| NAs: 0 |
| `LA_mm2` | numeric | leaf area | mm^2 | range 108.2–74420 \| mean 9343 \| NAs: 10 |
| `LN_mg/g` | numeric | leaf nitrogen per mass | mg/g | range 14.59–26.88 \| mean 21.6 \| NAs: 15 |
| `PH_m` | numeric | plant height | m | range 0.125–0.9894 \| mean 0.4903 \| NAs: 2 |
| `SLA_mm2 mg-1` | numeric | specific leaf area | mm^2/mg | range 6.907–52.02 \| mean 27.13 \| NAs: 9 |
| `SSD_g/cm3` | numeric | stem specific density | g/cm^3, equivalent to mg/mm^3 | range 0.08345–0.67 \| mean 0.3926 \| NAs: 26 |
| `SM_mg` | numeric | diaspore mass | mg | range 0.001–196 \| mean 12.14 \| NAs: 6 |

### `Data/weather_data.csv`

Monthly data from weather stations

**Date collected:** January 2000 – July 2016

**Dimensions:** 1151 rows × 24 columns

**Variables:**

| Column | Type | Description | Units | Summary |
| :----- | :--- | :---------- | :---- | :------ |
| `Site` | categorical | site identifier |  | levels: 01-ABR1, 03-CAL1, 04-CAM1, 20-VEN1 \| NAs: 0 |
| `Type (Open field vs in the plot)` | categorical | data origin, sub-canopy or open-field |  | levels: ITP, OFD \| NAs: 0 |
| `Year` | numeric | year | y | range 2000–2016 \| NAs: 0 |
| `Month` | numeric | month | m | range 1–12 \| NAs: 0 |
| `Air T (mean)` | numeric | mean air temperature | °C | range -7.8–24.1 \| mean 7.738 \| NAs: 120 |
| `Air T (min)` | numeric | minimum air temperature | °C | range -14.8–19.8 \| mean 4.225 \| NAs: 120 |
| `Air T (max)` | numeric | maximum air temperature | °C | range -2.5–365.8 \| mean 12.36 \| NAs: 120 |
| `N_Air T` | numeric | number of days with air temperature data |  | range 0–31 \| mean 25.14 \| NAs: 0 |
| `Soil T (mean)` | numeric | mean soil temperature | °C | range -0.4–31.9 \| mean 8.404 \| NAs: 401 |
| `Soil T (min)` | numeric | minimum soil temperature | °C | range -0.5–31.1 \| mean 8.027 \| NAs: 413 |
| `Soil T (max)` | numeric | maximum soil temperature | °C | range -0.3–32.6 \| mean 8.92 \| NAs: 413 |
| `N_Soil T` | numeric | number of days with soil temperature data |  | range 0–31 \| mean 18.05 \| NAs: 0 |
| `Solar radiation (mean)` | numeric | mean solar radiation | W/m^2 | range 2.2–328.1 \| mean 147.3 \| NAs: 568 |
| `Solar radiation (max)` | numeric | maximum solar radiation | W/m^2 | range 82.9–1358 \| mean 772.6 \| NAs: 629 |
| `N_Solar radiation` | numeric | number of days with solar radiation data |  | range 0–31 \| mean 25.24 \| NAs: 501 |
| `Relative humidity (mean)` | numeric | mean relative humidity | % | range 43.8–99.9 \| mean 84.21 \| NAs: 151 |
| `Relative humidity (min)` | numeric | minimum relative humidity | % | range 26.1–99.9 \| mean 64.24 \| NAs: 151 |
| `Relative humidity (max)` | numeric | maximum relative humidity | % | range 60.2–104.2 \| mean 95.36 \| NAs: 151 |
| `N_Relative humidity` | numeric | number of days with relative humidity data |  | range 0–31 \| mean 24.18 \| NAs: 0 |
| `Precipitation` | numeric | precipitation | mm | range 0–779.6 \| mean 112.3 \| NAs: 131 |
| `N_Precipitation` | numeric | number of days with precipitation data |  | range 0–31 \| mean 25.05 \| NAs: 0 |
| `Wind speed (mean)` | numeric | mean wind speed | m/s | range 0–7.1 \| mean 2.027 \| NAs: 698 |
| `Wind speed (max)` | numeric | maximum wind speed | m/s | range 0.6–17.3 \| mean 6.715 \| NAs: 701 |
| `N_wind speed` | numeric | number of days with wind speed data |  | range 0–31 \| mean 19.35 \| NAs: 501 |

## Model fits `fits/`

### `fits/sim/sim.lat.me.pos.txt`

**Dimensions:** 104 rows × 1 columns

**Variables:**

| Column | Type | Description | Units | Summary |
| :----- | :--- | :---------- | :---- | :------ |
| `// generated with brms 2.23.0` | categorical |  |  | 91 unique values \| NAs: 0 |

### `fits/sim/sim.lat.mi.pos.txt`

**Dimensions:** 141 rows × 1 columns

**Variables:**

| Column | Type | Description | Units | Summary |
| :----- | :--- | :---------- | :---- | :------ |
| `// generated with brms 2.23.0` | categorical |  |  | 116 unique values \| NAs: 0 |

## Model fits `fits/`

This folder contains `brms` model fits (`.rds`) and Stan code (`.txt`).

### `fits/cwm`

Fits from the trait mean models.

### `fits/extra`

Fits for models of within-site FD variation.

### `fits/fd`

Fits for models of trait diversity.

### `fits/sim`

Fits and Stan code for simulations of different model specifications.

### `fits/prior_fd.rds`

Prior predictive simulation for gaussian models.

### `fits/prior_h_ln.rds`

Prior predictive simulation for hurdle and lognormal models.

## Intermediate files `intermediate/`

Intermediate files generated by R

### `intermediate/cwm_itp.rds`

Traits and weather imputations ready for trait mean models

### `intermediate/data.RData`

Output from `2_data.qmd`

### `intermediate/dates.rds`

Survey dates

### `intermediate/fits_cwm.rds`

Tibble of trait mean fits from `8_cwm_models.qmd`

### `intermediate/fits_fd.rds`

Tibble of trait diversity fits from `6_fd_models.qmd`

### `intermediate/SES.RData`

FD-SES from `3_rao.qmd`

### `intermediate/weat.rds`

Raw weather data (cleaned and wrangled but not imputed)

### `intermediate/weather.RData`

Imputations for trait diversity models from `4_weather.qmd`

## HTML notebooks `notebooks/`

Folder with pre-rendered HTML notebooks.

## Outputs `output/`

Persistent outputs from notebooks.

### `output/clim_comparison.csv`

Table comparing gridded climate and measured weather.

### `output/coefs*.png`

Model coefficient plots from notebooks 6 and 8.

### `output/DAG.png`

Directed acyclic graph generated in notebook 1.

### `output/itp_ofd_comparison.csv`

Comparisons between ITP and OFD weather from the end of notebook 4.

### `output/pred*.png`

Model prediction plots from notebooks 6 and 8.

## Other Files

### `_quarto.yml`

Quarto YAML configuration

### `beech_filtering.Rproj`

Rstudio project

### `references.bib`

References used in the notebooks

### `functions.R`

Functions used by the notebooks

## Models

Location and specification of each analysis, linking the outcome and predictors to the underlying data, and (kept separately) where the analysis is described, where its results are reported, and where the code that produced it lives. **Results location** = where the output is reported; **Code location** = script and line.

| Outcome (paper) | Outcome (data) | Predictors (data) | Test | Results location | Code location |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Overall FD-SES (sub-canopy) | overall | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 3 | 6_fd_models.qmd:519 |
| Aboveground FD-SES (sub-canopy) | above | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 3c-d | 6_fd_models.qmd:457 |
| Belowground FD-SES (sub-canopy) | below | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 3e-f | 6_fd_models.qmd:488 |
| Leaf area (mm^2) | la | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 4a-b | 8_cwm_models.qmd:346 |
| Plant height (m) | ph | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 4c-d | 8_cwm_models.qmd:410 |
| Diaspore mass (mg) | sm | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 4e-f | 8_cwm_models.qmd:509 |
| Leaf nitrogen per mass (mg/g) | ln | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 5a-b | 8_cwm_models.qmd:378 |
| Specific leaf area (mm^2/mg) | sla | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 5c-d | 8_cwm_models.qmd:442 |
| Stem specific density (mg/mm^3) | ssd | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 5e-f | 8_cwm_models.qmd:476 |
| Bud bank size | BBRsize | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 6a-b | 8_cwm_models.qmd:544 |
| Multiplication rate | offspring | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 6c-d | 8_cwm_models.qmd:575 |
| Lateral spread (cm/year) | spread | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 6e-f | 8_cwm_models.qmd:613 |
| Persistence (years) | persistence | air_t_mean_centered, precipitation_centered, cover, site | Linear Regression | Figure 6g-h | 8_cwm_models.qmd:653 |

## Code
Scripts should be run in the following order:

1. **`0_try_data.qmd`**
   
   TRY data processing. Optional, results are stored into try_traits.csv

2. **`1_DAG.qmd`**
   
   Causal diagram and dagitty analysis

3. **`2_data.qmd`**
   
   Preliminary data import and processing

4. **`3_Rao.qmd`**
   
   Calculation of Rao diversity and SES

5. **`4_weather.qmd`**
   
   Weather data processing and imputations for FD models

6. **`5_simulations.qmd`**
   
   Model simulations

7. **`6_fd_models.qmd`**
   
   Trait diversity models

8. **`7_cwm_setup.qmd`**
   
   Data processing and imputations for trait mean models

9. **`8_cwm_models.qmd`**
   
   Trait mean models

10. **`9_figures.qmd`**
   
   Figures for the manuscript
   
11. **`99.extract_clim.qmd`**
   
   (Optional, for supporting material) Extract gridded climate and compare with measurements

## R Environment
**R version:** 4.6.1

| Package | Version |
| :------ | :------ |
| `bayesplot` | 1.16.0 |
| `brms` | 2.23.0 |
| `broom` | 1.0.13 |
| `conflicted` | 1.2.0 |
| `dagitty` | 0.3.4 |
| `datawizard` | 1.4.1 |
| `distributional` | 0.9.0 |
| `dplyr` | 1.2.1 |
| `DT` | 0.34.0 |
| `elementalist` | 0.0.0.9000 |
| `FD` | 1.0.12.6 |
| `flexiblas` | 3.4.0 |
| `ggdist` | 3.3.3 |
| `gggrid` | 0.2.0 |
| `ggmice` | 0.1.1 |
| `ggrepel` | 0.9.8 |
| `ggtext` | 0.2.0 |
| `htmltools` | 0.5.9 |
| `janitor` | 2.2.1 |
| `lmodel2` | 1.7.4 |
| `loo` | 2.10.1 |
| `MASS` | 7.3.66 |
| `mice` | 3.19.0 |
| `miceadds` | 3.20.10 |
| `paletteer` | 1.7.0 |
| `patchwork` | 1.3.2 |
| `plotly` | 4.12.1 |
| `posterior` | 1.7.0 |
| `psych` | 2.6.9 |
| `readxl` | 1.6.0 |
| `rlang` | 1.3.0 |
| `rtry` | 1.1.0 |
| `scales` | 1.4.0 |
| `sessioninfo` | 1.2.4 |
| `shape` | 1.4.6.1 |
| `tidybayes` | 3.0.7 |
| `tidyr` | 1.3.2 |
| `tidyverse` | 2.0.0 |

---
*README generated with [READMEBuilder](https://github.com/EIvimeyCook/READMEBuilder/tree/main) on 22 October 2026.*

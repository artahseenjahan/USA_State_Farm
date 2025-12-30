# County-Level Agricultural Production and Mechanization Analysis (Stata)

This repository contains a **Stata-based quantitative analysis** examining the relationship between **crop allocation (corn and wheat)** and **agricultural mechanization**, measured by **tractors per farm**, using **county-level U.S. data**. The project demonstrates data cleaning, dataset merging, variable construction, regression analysis, and interpretation using Stata.

---

## Project Objectives

The goals of this project are to:

1. Clean and prepare county-level agricultural census data.
2. Merge multiple datasets using geographic identifiers.
3. Construct agricultural intensity measures (percentage of farmland in corn and wheat).
4. Analyze how crop composition relates to farm mechanization.
5. Compare regression results with and without state fixed effects.
6. Provide economic interpretations of regression coefficients.

---

## Data Description

### Raw Data
- **`raw_countydata.csv`**  
  Contains county-level agricultural variables including harvested acreage, farmland, farms, and tractors.

### Stata Data Files
- **`test_mergefile.dta`**  
  Supplementary dataset used for merging county identifiers and additional variables.

### Key Variables
- `acres_corn` — Acres of harvested corn  
- `acres_wheat` — Acres of harvested wheat  
- `farmland` — Total farmland (acres)  
- `farms` — Number of farms  
- `tractors` — Number of tractors  

### Constructed Variables
- `pct_corn` — Percentage of farmland allocated to corn  
- `pct_wheat` — Percentage of farmland allocated to wheat  
- `tractors_per_farm` — Number of tractors per farm (proxy for mechanization)

---

## Data Cleaning & Merging

The analysis performs the following steps in Stata:

- Imports raw CSV data with correct encoding.
- Renames variables and applies descriptive labels.
- Identifies and removes duplicate county identifiers (`gisjoin`).
- Saves intermediate datasets for reproducibility.
- Merges datasets using a **1:1 county-level merge**.
- Retains only successfully matched observations (`_merge == 3`).

The final analytical sample contains **1,057 county observations** across Midwestern U.S. states.

---

## Empirical Strategy

### Model 1: Simple OLS Regression
```stata
reg tractors_per_farm pct_corn pct_wheat, robust
```
### Model 2: State Fixed Effects Regression

```stata
reg tractors_per_farm pct_corn pct_wheat i.state_dum, robust
```
This specification controls for unobserved, time-invariant state-level characteristics, including:

- Farm size norms
- Subsidy structures
- Regional mechanization practices
- Crop specialization patterns

By including state fixed effects, the model isolates within-state variation and improves explanatory power.

---

### Key Results

### Simple Regression Results

Both corn and wheat shares are positive and statistically significant (p < 0.001). 
A 10% increase in farmland allocated to corn is associated with: An increase of 0.018 tractors per farm. Approximately 1 additional tractor per 55 farms

A 10% increase in farmland allocated to wheat is associated with: An increase of 0.047 tractors per farm. Approximately 1 additional tractor per 21 farms.

Model explanatory power: R² = 0.246

---

### Regression with State Fixed Effects

- Corn and wheat shares remain **positive and highly statistically significant**.
- Model fit improves substantially:
  - **R² increases from 24.6% to 44.4%**
- Wheat exhibits a **stronger association with mechanization** than corn.
- Several states display statistically significant differences relative to the reference state.

---

### State-Level Interpretation

- **Negative state coefficients** indicate lower mechanization relative to the reference state.
- **Positive state coefficients** indicate higher mechanization.
- States such as **Iowa, Kansas, Minnesota, and North Dakota** do not differ significantly from the reference state.
- **South Dakota** exhibits the highest tractors-per-farm ratio.
- **Missouri** exhibits the lowest tractors-per-farm ratio.

---

### Visualizations

The project includes:

- Scatter plots of corn vs. wheat shares with fitted regression lines
- Bar charts showing average crop shares by state
- Regression output tables

All figures are generated directly in **Stata** using built-in graphing commands.

---

### Repository Structure

- `STATAdofileCodes.do` — Complete Stata do-file containing all commands
- `Logfile.log` — Full Stata execution log with outputs
- `raw_countydata.csv` — Raw county-level dataset
- `test_mergefile.dta` — Merge-support dataset
- `Additional Answers with Explanation.pdf` — Detailed written interpretation of results

---

### How to Run the Analysis

### Requirements

- **Stata (any recent version)**

### Steps

1. Open Stata.
2. Set your working directory to the project folder.
3. Run the analysis:
   ```stata
   do STATAdofileCodes.do


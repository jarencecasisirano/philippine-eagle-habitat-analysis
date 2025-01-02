# Project Title: Mapping Spatial Patterns and Environmental Drivers of Philippine Eagle Presence: Insights from Historical Sightings Data

---

## Research Questions

1. **Are Philippine Eagle sightings spatially random, or do they exhibit clustering or dispersion patterns?**
2. **Where are the high-density hotspots of Philippine Eagle sightings?**
3. **How do environmental factors such as forest cover, elevation, and proximity to rivers influence the spatial variability of Philippine Eagle presence?**
4. **Where are areas with environmental conditions similar to those associated with Philippine Eagle sightings, and how can they inform potential habitat prediction?**

---

## Objectives/Goals

1. To examine the spatial distribution and randomness of Philippine Eagle sightings using point pattern analysis techniques.
2. To generate density maps of Philippine Eagle sightings and identify geographic hotspots.
3. To assess and map the spatially varying relationship between environmental covariates (e.g., forest cover, elevation, proximity to rivers) and Philippine Eagle sightings using Geographically Weighted Regression (GWR).
4. To predict potential habitats for the Philippine Eagle by modeling environmental conditions associated with historical sightings using MaxEnt.

---

## Methodology

### **1. Exploratory Data Analysis**

#### **Point Pattern Analysis**

- **Quadrat Analysis**:
  - Divide the study area into grid cells and count occurrences in each cell.
  - Test for spatial randomness using a chi-square test.
- **Nearest Neighbor Analysis**:
  - Calculate the average distance to the nearest neighbor for each point.
  - Compute the Nearest Neighbor Index (NNI) to classify the pattern as clustered, random, or dispersed.
- **Ripley’s K-function**:
  - Analyze clustering or dispersion at multiple spatial scales.

#### **Kernel Density Estimation (KDE)**

- Generate KDE maps to visualize the intensity of eagle occurrences.
- Use automated bandwidth selection (`bw.diggle`) for optimal smoothing.

### **2. Covariate Extraction and Preprocessing**

- **Covariate Layers**:
  - Elevation (DEM).
  - Proximity to rivers.
  - Forest cover (categorical: forest, rangeland, others).
- **Steps**:
  - Extract covariate values at each point location (eagle sightings).
  - Standardize numerical covariates and handle missing values.
  - Downsample raster layers for computational efficiency (e.g., aggregate to ~30m resolution).

### **3. Geographically Weighted Regression (GWR)**

- **Objective**:
  - Assess spatially varying relationships between eagle presence and environmental covariates.
- **Steps**:
  - Select optimal adaptive bandwidth using cross-validation.
  - Fit a GWR model using the presence data and covariates.
  - Extract and visualize local coefficients and \(R^2\) values.
- **Outputs**:
  - Coefficient maps showing the influence of each covariate across the study area.
  - Local \(R^2\) map to evaluate model performance spatially.

### **4. Habitat Suitability Prediction with MaxEnt**

- **Objective**:
  - Predict potential habitats for the Philippine Eagle by modeling environmental conditions associated with presence points.
- **Steps**:
  - Train a MaxEnt model using presence points and environmental raster layers (elevation, proximity to rivers, and forest cover).
  - Generate habitat suitability maps.
  - Evaluate the model using built-in AUC metrics and mean suitability of test presence points.
- **Outputs**:
  - Habitat suitability map highlighting areas with conditions similar to presence locations.
  - AUC score and summary of suitability values for model validation.

---

## Technology and Concepts to Be Used

1. **Technology**:

   - R programming language (with libraries: `spgwr`, `spatstat`, `raster`, `dismo`, `ggplot2`).
   - GIS tools (e.g., QGIS for additional visualizations).

2. **Concepts**:
   - Point Pattern Analysis: Quadrat Test, Nearest Neighbor Analysis, and Ripley’s K-function.
   - Kernel Density Estimation (KDE): Identifying high-density hotspots of eagle occurrences.
   - Geographically Weighted Regression (GWR): Mapping spatially varying relationships between predictors and eagle presence.
   - MaxEnt Modeling: Predicting habitat suitability based on environmental covariates.

---

## Expected Outputs

1. **Exploratory Data Analysis**:

   - Quadrat Test results showing clustering or randomness at a large scale.
   - Nearest Neighbor Index (NNI) indicating clustering, randomness, or dispersion.
   - Ripley’s K-function plots showing clustering at multiple spatial scales.
   - KDE maps highlighting hotspots of eagle occurrences.

2. **GWR Outputs**:

   - Coefficient maps for elevation, proximity to rivers, and forest cover.
   - Local \(R^2\) map showing spatial variability in model performance.

3. **MaxEnt Outputs**:

   - Habitat suitability map highlighting potential areas for Philippine Eagle habitats.
   - AUC score from MaxEnt training (e.g., 0.7585) and mean suitability for test presence points (e.g., 0.6728).

4. **Visualization and Documentation**:
   - Clear maps and plots illustrating spatial patterns and predictor effects.
   - Statistical summaries and interpretations of findings.

---

## Significance

This project provides insights into the spatial distribution of suitable habitats for the Philippine Eagle. The analysis combines advanced spatial statistics (point pattern analysis, KDE, GWR, and MaxEnt) to inform conservation planning. It highlights regions critical for eagle habitats and identifies environmental factors influencing their distribution, offering actionable recommendations for habitat protection.

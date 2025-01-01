# Project Title: Mapping Spatial Patterns and Environmental Influences on Philippine Eagle Sightings

---

## Research Questions

1. **Are Philippine Eagle sightings spatially random, or do they exhibit clustering or dispersion patterns?**
2. **Where are the high-density hotspots of Philippine Eagle sightings?**
3. **How do environmental factors such as forest cover, elevation, and proximity to rivers influence the spatial variability of Philippine Eagle presence?**

---

## Objectives/Goals

1. To examine the spatial distribution and randomness of Philippine Eagle sightings using point pattern analysis techniques.
2. To generate density maps of Philippine Eagle sightings and identify geographic hotspots.
3. To assess and map the spatially varying relationship between environmental covariates (e.g., forest cover, elevation, proximity to rivers) and Philippine Eagle sightings using Geographically Weighted Regression (GWR).

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
  - Extract covariate values at each point location (eagle sightings and pseudo-absences).
  - Standardize numerical covariates and handle missing values.
  - Generate pseudo-absence points to balance presence data.

### **3. Geographically Weighted Regression (GWR)**

- **Objective**:
  - Assess spatially varying relationships between eagle presence and environmental covariates.
- **Steps**:
  - Select optimal adaptive bandwidth using cross-validation.
  - Fit a GWR model using the presence-absence dataset and covariates.
  - Extract and visualize local coefficients and \(R^2\) values.
- **Outputs**:
  - Coefficient maps showing the influence of each covariate across the study area.
  - Local \(R^2\) map to evaluate model performance spatially.

---

## Technology and Concepts to Be Used

1. **Technology**:

   - R programming language (with libraries: `spgwr`, `spatstat`, `raster`, `ggplot2`).
   - GIS tools (e.g., QGIS for additional visualizations).

2. **Concepts**:
   - Point Pattern Analysis: Quadrat Test, Nearest Neighbor Analysis, and Ripley’s K-function.
   - Kernel Density Estimation (KDE): Identifying high-density hotspots of eagle occurrences.
   - Geographically Weighted Regression (GWR): Mapping spatially varying relationships between predictors and eagle presence.

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

3. **Visualization and Documentation**:
   - Clear maps and plots illustrating spatial patterns and predictor effects.
   - Statistical summaries and interpretations of findings.

---

## Significance

This project provides insights into the spatial distribution of suitable habitats for the Philippine Eagle. The analysis combines advanced spatial statistics (point pattern analysis, KDE, and GWR) to inform conservation planning. It highlights regions critical for eagle habitats and identifies environmental factors influencing their distribution, offering actionable recommendations for habitat protection.

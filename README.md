# Project Title: Habitat Suitability Prediction for the Philippine Eagle Using Variogram Modeling and Kriging

---

## Research Questions

1. **What are the spatial patterns of habitat suitability for the Philippine Eagle in the study area?**
2. **How can habitat suitability be predicted across unsampled locations in the study area?**
3. **What is the spatial distribution of Philippine Eagle occurrence points?**
4. **Where are the hotspots of Philippine Eagle occurrences based on density estimation?**

---

## Objectives/Goals

1. **Analyze spatial autocorrelation in habitat suitability** to understand how suitability varies with distance.
2. **Predict habitat suitability** across the study region to identify unsampled areas with high suitability.
3. **Analyze spatial distribution** of occurrence points to detect clustering or randomness.
4. **Visualize hotspots** of eagle occurrences using density estimation techniques.

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
- Use KDE to identify hotspots and provide preliminary insights for habitat suitability modeling.

### **2. Data Preparation**

- **Data Sources**:
  - Philippine Eagle occurrence dataset (latitude, longitude).
  - Covariate layers: proximity to forests, rivers, elevation, temperature, and rainfall.
- **Steps**:
  - Preprocess and clean the occurrence dataset.
  - Extract covariate values at each occurrence point.
  - Normalize or standardize covariates and compute a "habitat suitability index" as a weighted sum or through regression modeling.

### **3. Variogram Modeling**

- **Steps**:
  - Calculate a variogram for the habitat suitability index to quantify spatial autocorrelation.
  - Fit theoretical models (e.g., spherical, exponential) to the experimental variogram.
  - Identify key parameters: range (distance of spatial dependence), sill (variance explained by spatial structure), and nugget (unexplained variance).
- **Expected Tools**:
  - R packages: `gstat`, `sp`.

### **4. Kriging Interpolation**

- **Steps**:
  - Perform ordinary kriging to interpolate habitat suitability across the study area using the fitted variogram model.
  - Generate a continuous surface map of predicted habitat suitability.
- **Expected Tools**:
  - R packages: `gstat`, `sp`, `raster`.

### **5. Post-Kriging Analysis and Validation**

#### **Kernel Density Estimation (KDE)**

- Use KDE to validate and compare observed eagle density hotspots with predicted habitat suitability from kriging.
- Identify areas of agreement and divergence between KDE and kriging outputs.

### **6. Analysis and Mapping**

- **Steps**:
  - Analyze the kriging results to identify regions with high habitat suitability.
  - Create visualizations (maps and density plots) to communicate findings.
- **Expected Tools**:
  - GIS software (QGIS or R with `tmap`/`ggplot2`).

---

## Technology and Concepts to Be Used

1. **Technology**:

   - R programming language (with libraries: `gstat`, `sp`, `raster`, `ggplot2`).
   - GIS tools (e.g., QGIS for map overlays and visualizations).

2. **Concepts**:

   - Variogram modeling: Understanding spatial autocorrelation and fitting theoretical models.
   - Kriging: Interpolating spatial data to predict values at unsampled locations.
   - Habitat suitability modeling: Using covariates to estimate habitat quality.
   - Spatial Point Pattern Analysis: Quadrat Test, Nearest Neighbor Analysis, and Ripley’s K-function.
   - Kernel Density Estimation (KDE): Visualizing intensity and hotspots of eagle occurrences, and comparing density maps to model predictions.
   - Mapping and visualization: Creating maps to communicate spatial patterns and suitability predictions.

---

## Expected Outputs

1. **Exploratory Data Analysis**:

   - Quadrat Test results showing clustering or randomness at a large scale.
   - Nearest Neighbor Index (NNI) indicating clustering, randomness, or dispersion.
   - Ripley’s K-function plots showing clustering at multiple spatial scales.
   - KDE maps highlighting hotspots of eagle occurrences.

2. **Variogram Analysis**:

   - Experimental variogram plot showing spatial dependence of habitat suitability.
   - Fitted variogram model parameters (range, sill, nugget).

3. **Kriging Prediction**:

   - Continuous surface map of predicted habitat suitability.
   - Spatial distribution of high-suitability regions.

4. **Post-Kriging Validation**:

   - KDE maps compared to kriging predictions to assess alignment of observed and predicted patterns.

5. **Visualization and Documentation**:

   - Clear and visually appealing maps showing spatial patterns.
   - Statistical summaries and interpretation of findings.

---

## Significance

This project will provide insights into the spatial distribution of suitable habitats for the Philippine Eagle, offering valuable information for conservation planning. It demonstrates the application of advanced spatial statistics (variogram modeling, kriging, and point pattern analysis) to a real-world ecological problem, aligning with both academic and practical goals.

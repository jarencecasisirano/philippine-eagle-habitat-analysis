# Spatial Statistical Analysis of Vegetation Health (NDVI) and Its Relationship with Rainfall and Temperature

## **About**

This project explores the spatial distribution of vegetation health, represented by NDVI, and investigates its relationship with climatic factors like rainfall and temperature using spatial statistical techniques. It employs Moran's I to assess spatial autocorrelation, spatial regression to quantify the influence of climatic variables on NDVI while accounting for spatial dependencies, and kriging to interpolate NDVI values and predict spatial patterns. Additionally, it incorporates typhoon track data to analyze the impact of these extreme weather events on vegetation health, adding a dynamic perspective to the analysis. The study integrates GIS and remote sensing data, offering insights into vegetation dynamics for ecological monitoring and conservation planning.

## **Objective**

To analyze the spatial distribution of vegetation health using NDVI and investigate its relationship with rainfall, temperature, and typhoon activity using spatial statistical techniques such as Moran's I, spatial regression, and kriging.

---

## **Software and Tools**

### **1. R (Primary Software)**

- **Packages**: `raster`, `sf`, `sp`, `spdep`, `gstat`, `ggplot2`.
- **Purpose**: Spatial data analysis, spatial statistics, visualization.

### **2. QGIS or ArcGIS**

- **Purpose**:
  - Clip datasets, align spatial resolutions, and export raster values as points or grids for R.

### **3. Google Earth Engine (Optional)**

- **Purpose**:
  - Data acquisition for NDVI, rainfall, and temperature.

---

## **Data Sources**

### **1. NDVI**

- Dataset: MODIS (MOD13Q1) or Sentinel-2 NDVI.
- Platform: Google Earth Engine, NASA Earthdata, or Copernicus Open Hub.

### **2. Rainfall**

- Dataset: CHIRPS (Climate Hazards Group InfraRed Precipitation with Station Data).
- Platform: ClimateSERV or Google Earth Engine.

### **3. Temperature**

- Dataset: ERA5 or CRU TS datasets for mean surface temperature.
- Platform: Copernicus Climate Data Store or Google Earth Engine.

### **4. Typhoon Tracks**

- Dataset: Historical typhoon track data (vector shapefiles).
- Platform: National meteorological agencies or publicly available repositories.

### **5. Boundary Data**

- Administrative or ecological boundaries for clipping the data.
- Platform: Natural Earth, GADM, or OpenStreetMap.

---

## **Execution Plan (Methods)**

### **Step 1: Data Preprocessing**

1. Clip NDVI, rainfall, temperature, and typhoon track data to the study area.
2. Resample all raster datasets to the same spatial resolution.
3. Rasterize typhoon track data to create a binary layer indicating typhoon presence during a specific period.
4. Export raster values to points or grids for analysis in R.

### **Step 2: Exploratory Data Analysis**

1. Visualize NDVI, rainfall, temperature, and typhoon tracks using maps.
2. Compute statistical summaries (means, variances) for each variable.
3. Explore relationships between NDVI, climatic factors, and typhoon presence using scatterplots and time-series plots.

### **Step 3: Spatial Autocorrelation**

1. Compute Moran's I to assess spatial clustering of NDVI.
2. Generate Moran scatterplots and perform permutation tests for significance.

### **Step 4: Spatial Regression**

1. Fit spatial regression models (e.g., spatial lag or spatial error models) to quantify the effect of rainfall, temperature, and typhoon activity on NDVI.
2. Validate model results and interpret coefficients.

### **Step 5: Variogram and Kriging**

1. Perform variogram modeling to understand spatial dependence in NDVI.
2. Use kriging to interpolate NDVI values and generate prediction maps with uncertainties.

### **Step 6: Typhoon Impact Analysis**

1. Aggregate NDVI, rainfall, and temperature data by month or season.
2. Introduce a binary variable indicating the presence or absence of typhoons for each period.
3. Compare NDVI values during months/seasons with and without typhoons.
4. Visualize the impact of typhoons on NDVI using maps and statistical plots.

### **Step 7: Visualization and Reporting**

1. Create maps showing:
   - NDVI distribution and hotspots.
   - Regression residuals.
   - Kriging predictions and uncertainties.
   - Typhoon tracks and their spatial overlap with NDVI.
2. Summarize findings in a report.

---

## **Expected Outputs/Results**

### **1. Spatial Statistics**

- Moran’s I results indicating spatial clustering of NDVI.
- Regression coefficients quantifying the effect of climatic factors and typhoon presence on NDVI.

### **2. Maps**

- NDVI distribution and identified hotspots.
- Kriging predictions with uncertainties.
- Regression residual maps.
- Typhoon track overlays with NDVI.

### **3. Insights**

- Identify areas of poor vegetation health correlated with climatic extremes and typhoon activity.
- Provide recommendations for targeted conservation and disaster mitigation efforts.

### **4. Deliverables**

- Final report containing:
  - Introduction, methodology, results, and discussion.
  - Maps and statistical outputs.

---

## **Why This Project Works**

1. **Alignment with Course Concepts**:
   - Incorporates Moran’s I, spatial regression, variogram analysis, and kriging as taught in class.
2. **GIS and Remote Sensing Integration**:
   - Combines remote sensing data with spatial statistical tools.
   - Includes the analysis of vector-based typhoon tracks in conjunction with raster datasets.
3. **Feasibility**:
   - Uses freely available data and reproducible workflows in R.

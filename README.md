# Spatial Statistical Analysis of Vegetation Health (NDVI) and Its Relationship with Rainfall and Temperature

## **Objective**

To analyze the spatial distribution of vegetation health using NDVI and investigate its relationship with rainfall and temperature using spatial statistical techniques such as Moran's I, spatial regression, and kriging.

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

### **4. Boundary Data**

- Administrative or ecological boundaries for clipping the data.
- Platform: Natural Earth, GADM, or OpenStreetMap.

---

## **Execution Plan (Methods)**

### **Step 1: Data Preprocessing**

1. Clip NDVI, rainfall, and temperature rasters to the study area.
2. Resample all datasets to the same spatial resolution.
3. Export raster values to points or grids for analysis in R.

### **Step 2: Exploratory Data Analysis**

1. Visualize NDVI, rainfall, and temperature using maps.
2. Compute statistical summaries (means, variances) for each variable.
3. Explore relationships between NDVI, rainfall, and temperature using scatterplots.

### **Step 3: Spatial Autocorrelation**

1. Compute Moran's I to assess spatial clustering of NDVI.
2. Generate Moran scatterplots and perform permutation tests for significance.

### **Step 4: Spatial Regression**

1. Fit spatial regression models (e.g., spatial lag or spatial error models) to quantify the effect of rainfall and temperature on NDVI.
2. Validate model results and interpret coefficients.

### **Step 5: Variogram and Kriging**

1. Perform variogram modeling to understand spatial dependence in NDVI.
2. Use kriging to interpolate NDVI values and generate prediction maps with uncertainties.

### **Step 6: Visualization and Reporting**

1. Create maps showing:
   - NDVI distribution and hotspots.
   - Regression residuals.
   - Kriging predictions and uncertainties.
2. Summarize findings in a report.

---

## **Expected Outputs/Results**

### **1. Spatial Statistics**

- Moran’s I results indicating spatial clustering of NDVI.
- Regression coefficients quantifying the effect of climatic factors on NDVI.

### **2. Maps**

- NDVI distribution and identified hotspots.
- Kriging predictions with uncertainties.
- Regression residual maps.

### **3. Insights**

- Identify areas of poor vegetation health correlated with climatic extremes.
- Provide recommendations for targeted conservation efforts.

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
3. **Feasibility**:
   - Uses freely available data and reproducible workflows in R.

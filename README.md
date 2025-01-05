# Mapping Spatial Patterns and Environmental Drivers of Philippine Eagle Presence: Insights from Historical Sightings Data

## Overview

This repository contains the analysis of Philippine Eagle (_Pithecophaga jefferyi_) habitat preferences using advanced spatial statistics and predictive modeling techniques. The study integrates point pattern analysis, kernel density estimation (KDE), Geographically Weighted Regression (GWR), and MaxEnt modeling to uncover spatial patterns and identify critical environmental factors influencing eagle presence. The findings aim to support conservation planning by highlighting priority areas for habitat protection and restoration.

---

## Key Highlights

- **Study Area**: The analysis focuses on forested regions in North Cotabato and Davao del Sur, Philippines, known habitats of the critically endangered Philippine Eagle.
- **Data Used**:
  - Philippine Eagle occurrence points from GBIF.
  - Environmental covariates: elevation (SRTM), proximity to rivers (OSM), and forest cover (ESRI LULC).
- **Methods**:
  - Spatial statistics (e.g., point pattern analysis, KDE).
  - GWR for spatially varying relationships.
  - MaxEnt for habitat suitability prediction.
- **Tools**: R programming (e.g., `spatstat`, `GWmodel`, `dismo`), QGIS, and geospatial data processing techniques.

---

## Final Outputs

### **1. Key Figures**

- **Spatial Clustering**:
  - Quadrat analysis and Ripley’s K-function confirmed significant clustering of eagle sightings in forested areas.
  - **[Figure 6: KDE Plot](https://github.com/jarencecasisirano/philippine-eagle-habitat-analysis/blob/main/assets/figure6.png)**: Hotspots of eagle occurrences.
- **Environmental Drivers**:
  - GWR revealed spatial variations in the influence of covariates.
  - **[Figure 17: Elevation Coefficients](https://github.com/jarencecasisirano/philippine-eagle-habitat-analysis/blob/main/assets/figure17.png)**: Positive association between elevation and eagle presence in specific regions.
  - **[Figure 21: Local R² Map](https://github.com/jarencecasisirano/philippine-eagle-habitat-analysis/blob/main/assets/figure21.png)**: Model performance across the study area.
- **Habitat Suitability**:
  - MaxEnt predicted areas with high ecological suitability for eagle habitats.
  - **[Figure 22: Habitat Suitability Map](https://github.com/jarencecasisirano/philippine-eagle-habitat-analysis/blob/main/assets/figure22.png)**: Priority areas for conservation.

### **2. Statistical Outputs**

- **GWR**:
  - Local \(R^2\) mean: ~0.25, highlighting moderate explanatory power of elevation, proximity to rivers, and forest cover.
  - Coefficient maps showing spatial variability of covariate influence.
- **MaxEnt**:
  - AUC Score: 0.759, demonstrating good predictive accuracy.
  - Habitat suitability score for test presence points: 0.673 (mean).

---

## Repository Contents

1. **Scripts**:
   - R scripts for spatial analysis and modeling.
   - QGIS workflows for preprocessing geospatial data.
2. **Figures**:
   - Key visualizations saved in the `assets/` folder.
   - Examples include KDE maps, GWR coefficient maps, and MaxEnt habitat suitability predictions.
3. **Documentation**:
   - Detailed descriptions of methodologies and interpretations, based on the final report.

---

## Recommendations for Conservation

1. **Preserve Mid-Elevation Forests**:
   - Priority areas are at 900–1,200 meters with dense forest cover near riparian zones.
2. **Restore Riparian Zones**:
   - Maintain buffer zones around rivers to enhance prey availability and water resources.
3. **Expand Habitat Research**:
   - Incorporate additional covariates (e.g., prey availability, anthropogenic disturbance) to refine habitat suitability models.

---

## How to Replicate This Study

1. Clone this repository:
   ```bash
   git clone https://github.com/jarencecasisirano/philippine-eagle-habitat-analysis.git
   ```

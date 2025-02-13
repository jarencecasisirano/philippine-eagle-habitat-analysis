## Chi-Square Test for Spatial Randomness

### **Test Result**

- \( X^2 = 1296.3 \), \( df = 24 \), \( p < 2.2 \times 10^{-16} \)
- The extremely low p-value (< 0.05) suggests that the null hypothesis of Complete Spatial Randomness (CSR) can be **rejected**.

---

### **Interpretation**

1. **What Does This Mean?**

   - The eagle sightings are **not randomly distributed** across the study area.
   - There is evidence of **clustering** or **dispersion** depending on the spatial pattern.

2. **Next Steps**
   - Investigate the nature of this departure:
     - Is it **clustering** (e.g., sightings are concentrated in specific areas)?
     - Or is it **dispersion** (e.g., sightings are evenly spread out, more than expected)?

## Nearest Neighbor Analysis

### **Results**

1. **Mean Nearest Neighbor Distance**:
   - Observed: **0.00096**
2. **Expected Nearest Neighbor Distance (CSR)**:
   - Expected: **0.00247**
3. **Nearest Neighbor Index (NNI)**:
   - \( \text{NNI} = \frac{\text{Observed Mean Distance}}{\text{Expected Mean Distance}} \)
   - \( \text{NNI} = \frac{0.00096}{0.00247} = 0.390 \)

---

### **Interpretation**

- **NNI < 1**: Indicates significant **clustering** of eagle sightings.
- The NNI of **0.39** confirms a strong tendency for points to cluster, supporting the Chi-square test result.

---

### **Next Steps**

- Perform **Ripley’s K-function** analysis to examine clustering patterns across multiple spatial scales.

## Ripley’s K-Function Analysis

### **Understanding the Plot**

- **Lines in the Plot**:
  - **Black Line (\( \hat{K}\_{iso}(r) \))**:
    - The isotropic (observed) K-function, representing the actual clustering pattern of points.
  - **Dashed Blue Line (\( K\_{pois}(r) \))**:
    - The theoretical K-function under Complete Spatial Randomness (CSR).
    - This is used as a benchmark to compare the observed pattern.
  - **Other Lines** (\( \hat{K}_{trans}(r) \), \( \hat{K}_{bord}(r) \)):
    - Variants of the K-function calculated with edge corrections to account for boundary effects.

### **Interpretation**

1. **Clustering or Dispersion**:

   - If the observed \( \hat{K}_{iso}(r) \) (black line) lies **above** the CSR line (\( K_{pois}(r) \)), it indicates **clustering** at the corresponding distance \( r \).
   - If \( \hat{K}_{iso}(r) \) lies **below** \( K_{pois}(r) \), it indicates **dispersion** at that scale.

2. **Results in the Plot**:
   - For most distances (\( r \)), the black line (\( \hat{K}_{iso}(r) \)) is consistently **above** the CSR line (\( K_{pois}(r) \)), indicating **clustering** of eagle sightings across multiple spatial scales.
   - The divergence between \( \hat{K}_{iso}(r) \) and \( K_{pois}(r) \) grows with increasing \( r \), suggesting stronger clustering at larger spatial scales.

### **Key Insights**

- Eagle sightings are **significantly clustered** across the study area, which aligns with the results from the Chi-square test and Nearest Neighbor Analysis.
- Clustering occurs across multiple spatial scales, as indicated by the consistent elevation of \( \hat{K}_{iso}(r) \) above \( K_{pois}(r) \).

---

### **Next Steps**

1. Summarize the clustering behavior:
   - "Ripley's K-function shows significant clustering of eagle sightings across multiple spatial scales, with stronger clustering at larger distances."
2. Use this result to guide habitat suitability analysis:
   - Focus on covariates that may explain this clustering (e.g., proximity to forests, elevation).
3. Proceed to Kernel Density Estimation (KDE) to visualize the clustering intensity.

---

## Kernel Density Estimation (KDE) Map

### **Interpretation**

1. **Density Visualization**:

   - The KDE map shows the density of eagle sightings across the study area.
   - Warmer colors (yellow, orange, and red) represent higher densities of sightings, while cooler colors (blue) represent lower densities.

2. **Hotspots**:

   - The central yellow region indicates the primary **hotspot** where sightings are most concentrated.
   - This aligns with the clustering patterns observed in the **Ripley’s K-function** and the Chi-square test results.

3. **Gradient**:
   - The smooth gradient from yellow to blue suggests a continuous transition in sighting density rather than abrupt changes.

---

### **Key Insights**

- **Clustering Evidence**:
  - The KDE confirms significant clustering, with one or more dense hotspots of eagle sightings.
- **Spatial Relevance**:
  - These hotspots could indicate areas of ecological importance (e.g., preferred habitats or resource-rich zones).
- **Conservation Implications**:
  - The high-density regions could be prioritized for habitat protection or further ecological study.

---

### **Next Steps**

1. **Overlay Environmental Covariates**:
   - Overlay the KDE map with covariates (e.g., forest cover, elevation) to examine potential factors influencing hotspot locations.
2. **Compare with Kriging**:
   - After performing kriging for habitat suitability, compare the predicted habitat suitability map with the KDE map to validate predictions.
3. **Document Findings**:
   - Include this KDE map in your report as visual evidence of clustering and to support habitat suitability modeling.

---

## Main Takeaways from the Exploratory Data Analysis (EDA)

### **1. Chi-Square Test for Spatial Randomness**

- The Chi-square test for CSR indicated a significant departure from randomness (\( X^2 = 1296.3 \), \( p < 2.2 \times 10^{-16} \)).
- This suggests that eagle sightings are **not randomly distributed** and exhibit a structured spatial pattern.

---

### **2. Nearest Neighbor Analysis**

- The **Nearest Neighbor Index (NNI)** was **0.39**, far below 1, confirming significant **clustering** of eagle sightings.
- Observed nearest neighbor distances were smaller than expected under CSR, reinforcing the presence of clustering.

---

### **3. Ripley’s K-Function**

- Ripley’s \( K(r) \)-function showed that the observed clustering is consistent across multiple spatial scales, with \( \hat{K}_{iso}(r) \) consistently above the CSR line (\( K_{pois}(r) \)).
- Clustering becomes more pronounced at larger distances, indicating scale-dependent clustering patterns.

---

### **4. Kernel Density Estimation (KDE)**

- The KDE map revealed clear **hotspots** of eagle sightings, with high-density regions visualized as warm colors.
- These hotspots align with the clustering detected in the statistical tests and highlight areas of ecological or conservation interest.

---

### **Overall Insights**

1. **Clustering**:
   - All EDA methods confirm that eagle sightings are significantly **clustered** rather than randomly distributed.
2. **Scale Dependence**:
   - Clustering patterns vary across spatial scales, as evidenced by Ripley’s \( K(r) \).
3. **Hotspot Identification**:
   - KDE identified high-density regions that could guide conservation efforts or further modeling.

---

### **Next Steps**

1. Use these insights to refine habitat suitability modeling:
   - Focus on covariates that may explain clustering (e.g., proximity to forests or rivers).
2. Proceed with **variogram modeling** to analyze spatial autocorrelation in the habitat suitability index.
3. Use kriging to predict habitat suitability across the study area and compare it with KDE results.

---

# Exploratory Data Analysis (EDA) for Philippine Eagle Project
# Includes Point Pattern Analysis and Kernel Density Estimation

# Load necessary libraries
library(spatstat)
library(raster)

# Load occurrence data (adjust path as necessary)
eagle_sightings <- read.csv("eagle_sightings.csv")

# Inspect the data
head(eagle_sightings)
summary(eagle_sightings)

# Create a spatial point pattern object
# Adjust column names if they differ in your dataset
ppp_data <- ppp(
  x = eagle_sightings$decimalLon, 
  y = eagle_sightings$decimalLat, 
  window = owin(
    xrange = c(min(eagle_sightings$decimalLon), max(eagle_sightings$decimalLon)),
    yrange = c(min(eagle_sightings$decimalLat), max(eagle_sightings$decimalLat))
  )
)

# Plot the occurrence points
plot(ppp_data, main = "Philippine Eagle Sightings")

# ------------------------------------------------
# 1. Quadrat Analysis
# ------------------------------------------------
# Divide the study area into quadrats
quadrat_counts <- quadratcount(ppp_data, nx = 5, ny = 5) # Adjust nx, ny as needed
plot(ppp_data, main = "Quadrat Analysis")
plot(quadrat_counts, add = TRUE, col = "red")

# Perform Chi-square test for spatial randomness
quadrat_test <- quadrat.test(ppp_data, nx = 5, ny = 5)
print(quadrat_test)

# ------------------------------------------------
# 2. Nearest Neighbor Analysis
# ------------------------------------------------
# Calculate nearest neighbor distances
nnd <- nndist(ppp_data)
mean_nnd <- mean(nnd)
cat("Mean Nearest Neighbor Distance:", mean_nnd, "\n")

# Expected nearest neighbor distance under CSR
lambda <- intensity(ppp_data) # Point density
expected_nnd <- 1 / (2 * sqrt(lambda))
cat("Expected Nearest Neighbor Distance (CSR):", expected_nnd, "\n")

# Nearest Neighbor Index (NNI)
nni <- mean_nnd / expected_nnd
cat("Nearest Neighbor Index (NNI):", nni, "\n")

# ------------------------------------------------
# 3. Ripley’s K-function
# ------------------------------------------------
# Calculate Ripley’s K-function
K <- Kest(ppp_data)
plot(K, main = "Ripley's K-function")

# ------------------------------------------------
# 4. Kernel Density Estimation (KDE)
# ------------------------------------------------
# Generate a KDE map
kde <- density(ppp_data, sigma = 0.002) # Adjust sigma for smoothing bandwidth

# KDE plot with color bar
plot(kde, main = "Kernel Density Estimation (KDE)", col = topo.colors(100))

# Overlay points on KDE map
plot(kde, main = "KDE with Occurrence Points", col = topo.colors(100))
points(eagle_sightings$decimalLon, eagle_sightings$decimalLat, pch = 20, col = "black", cex = 0.7)
contour(kde, add = TRUE, col = "red")
legend("topleft", legend = c("High Density", "Low Density"), fill = topo.colors(2), cex = 0.8)

# Save the KDE as a raster
kde_raster <- raster(kde)
writeRaster(kde_raster, "kde_map.tif", overwrite = TRUE)

# ------------------------------------------------
# Completion Message
# ------------------------------------------------
cat("Exploratory Data Analysis complete! Outputs include:\n")
cat("- Quadrat Test results\n")
cat("- Nearest Neighbor Index\n")
cat("- Ripley's K-function plot\n")
cat("- KDE map saved as kde_map.tif\n")

# END OF SCRIPT
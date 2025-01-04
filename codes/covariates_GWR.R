# Load necessary libraries
library(spatstat)
library(raster)
library(ggplot2)
library(dplyr)

# Load eagle sightings data
eagle_sightings <- read.csv("eagle_sightings.csv")

# Inspect the data
head(eagle_sightings)
summary(eagle_sightings)

# Load covariate layers (e.g., forest cover, elevation, rivers proximity)
forest <- raster("forest.tif")
elevation <- raster("elev.tif")
proximity_rivers <- raster("riverProximity.tif")

#############################################

# Define a color palette for the categories
forest_colors <- c("gray", "darkgreen", "orange")  # Colors for others, forest, rangeland

# Define labels for the categories
forest_labels <- c("Others", "Forest", "Rangeland")

par(mfrow = c(1, 3))  # 1 row, 3 columns

# Plot elevation
plot(elevation, main = "Elevation")

# Plot proximity to rivers
plot(proximity_rivers, main = "Proximity to Rivers")

# Plot forest cover with categorical colors
plot(
  forest,
  main = "Forest Cover",
  col = forest_colors,
  legend = FALSE,  # Disable legend here to add manually later
  axes = TRUE,
  box = FALSE
)

# Add the legend for forest cover
legend(
  "topright",                   # Position of the legend
  legend = forest_labels,       # Labels for the categories
  fill = forest_colors,         # Corresponding colors
  title = "Categories",
  cex = 0.7,                    # Text size (smaller)
  y.intersp = 0.7               # Vertical spacing between legend items
)

# Reset par to default (optional)
par(mfrow = c(1, 1))

#############################################


# Create a SpatialPoints object for eagle sightings
sighting_points <- SpatialPoints(cbind(eagle_sightings$decimalLon, eagle_sightings$decimalLat),
                                 proj4string = CRS(proj4string(forest)))

# Extract covariate values at sighting locations
eagle_sightings$elevation <- extract(elevation, sighting_points)
eagle_sightings$proximity_rivers <- extract(proximity_rivers, sighting_points)

# Extract forest cover categories for eagle sighting points
eagle_sightings$forest_cover <- extract(forest, sighting_points)

# Convert forest_cover to a factor
eagle_sightings$forest_cover <- factor(eagle_sightings$forest_cover, 
                                       levels = c(0, 1, 2), 
                                       labels = c("Others", "Forest", "Rangeland"))

# Inspect the updated dataset
table(eagle_sightings$forest_cover)

# Inspect the updated data
head(eagle_sightings)

# Extract forest cover class at sighting locations
eagle_sightings$forest_cover <- extract(forest, sighting_points)

# Inspect forest cover categories
table(eagle_sightings$forest_cover)

# Bar plot: Proportion of sightings in each forest cover class
ggplot(eagle_sightings, aes(x = factor(forest_cover, labels = c("Others", "Forest", "Rangeland")))) +
  geom_bar(aes(y = ..prop.., group = 1), fill = "lightgreen", color = "black") +
  labs(title = "Proportion of Eagle Sightings by Forest Cover Class",
       x = "Forest Cover Class", y = "Proportion") +
  theme_minimal()

# Boxplot: Distribution of elevation for each forest cover class with jitter points
ggplot(eagle_sightings, aes(x = factor(forest_cover, labels = c("Others", "Forest", "Rangeland")), y = elevation)) +
  geom_boxplot(fill = "lightblue", color = "black", outlier.shape = NA) +  # Boxplot without default outliers
  geom_jitter(width = 0.2, alpha = 0.5, color = "darkblue") +  # Add jitter points for individual data visibility
  stat_summary(fun = median, geom = "point", shape = 20, color = "red", size = 3) +  # Highlight median values
  labs(
    title = "Elevation by Forest Cover Class (with Jitter Points)",
    x = "Forest Cover Class",
    y = "Elevation (m)"
  ) +
  theme_minimal()

# Boxplot: Distribution of proximity to rivers for each forest cover class
ggplot(eagle_sightings, aes(x = factor(forest_cover, labels = c("Others", "Forest", "Rangeland")), y = proximity_rivers)) +
  geom_boxplot(fill = "lightcoral", color = "black") +  # Boxplot for proximity to rivers
  geom_jitter(width = 0.2, alpha = 0.3) +  # Add jitter points to show individual data points
  labs(title = "Proximity to Rivers by Forest Cover Class",
       x = "Forest Cover Class", y = "Proximity to Rivers (meters)") +
  theme_minimal()


# Ensure forest_cover is a factor
eagle_sightings$forest_cover <- as.factor(eagle_sightings$forest_cover)

# Density plot: Overall distribution of proximity to rivers by forest cover class
ggplot(eagle_sightings, aes(x = proximity_rivers, fill = forest_cover, group = eagle_sightings$forest_cover)) +
  geom_density(alpha = 0.5) +  # Add semi-transparent density curves
  labs(title = "Density of Proximity to Rivers by Forest Cover Class",
       x = "Proximity to Rivers (meters)", y = "Density") +
  theme_minimal()

# Scatterplot: Relationship between elevation and proximity to rivers, grouped by forest cover
ggplot(eagle_sightings, aes(x = proximity_rivers, y = elevation, color = forest_cover)) +
  geom_point(alpha = 0.7) +  # Scatter points with transparency
  geom_smooth(method = "lm", se = FALSE) +  # Add linear trend lines for each forest cover class
  labs(title = "Elevation vs. Proximity to Rivers",
       x = "Proximity to Rivers (meters)", y = "Elevation (m)") +
  theme_minimal()

# Scatterplot: Faceted Scatterplot of Elevation vs. Proximity to Rivers
ggplot(eagle_sightings, aes(x = proximity_rivers, y = elevation)) +
  geom_point(alpha = 0.7, color = "darkblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Elevation vs. Proximity to Rivers by Forest Cover Class",
       x = "Proximity to Rivers (meters)", y = "Elevation (m)") +
  theme_minimal() +
  facet_wrap(~ forest_cover, labeller = label_both)

# Scatterplot: Relationship between elevation and proximity to rivers with 2D density plot
ggplot(eagle_sightings, aes(x = proximity_rivers, y = elevation)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", alpha = 0.5) +
  geom_point(alpha = 0.7, color = "darkblue") +
  scale_fill_viridis_c() +
  labs(title = "2D Density of Eagle Sightings (Elevation vs. Proximity to Rivers)",
       x = "Proximity to Rivers (meters)", y = "Elevation (m)") +
  theme_minimal()

########################################################################################################

library(spgwr)
library(ggplot2)

# Define bounding box coordinates
bbox_coords <- matrix(c(
  min(eagle_sightings$decimalLon), min(eagle_sightings$decimalLat),  # Bottom-left corner
  max(eagle_sightings$decimalLon), min(eagle_sightings$decimalLat),  # Bottom-right corner
  max(eagle_sightings$decimalLon), max(eagle_sightings$decimalLat),  # Top-right corner
  min(eagle_sightings$decimalLon), max(eagle_sightings$decimalLat),  # Top-left corner
  min(eagle_sightings$decimalLon), min(eagle_sightings$decimalLat)   # Close the polygon
), ncol = 2, byrow = TRUE)

# Create a SpatialPolygons object for the bounding box
bbox_polygon <- SpatialPolygons(list(Polygons(list(Polygon(bbox_coords)), "1")))

# Generate random pseudo-absence points
set.seed(123)  # For reproducibility
random_points <- spsample(bbox_polygon, n = 500, type = "random")

# Convert to a data frame for further processing
pseudo_absences <- data.frame(
  decimalLon = coordinates(random_points)[, 1],
  decimalLat = coordinates(random_points)[, 2]
)

pseudo_absences$elevation <- extract(elevation, random_points)
pseudo_absences$proximity_rivers <- extract(proximity_rivers, random_points)
pseudo_absences$forest_cover <- extract(forest, random_points)
pseudo_absences$presence <- 0  # Label these points as absences

eagle_sightings$presence <- 1
combined_data <- rbind(
  eagle_sightings[, c("decimalLon", "decimalLat", "elevation", "proximity_rivers", "forest_cover", "presence")],
  pseudo_absences
)
combined_data$elevation[is.na(combined_data$elevation)] <- mean(combined_data$elevation, na.rm = TRUE)
combined_data$proximity_rivers[is.na(combined_data$proximity_rivers)] <- mean(combined_data$proximity_rivers, na.rm = TRUE)
# Impute forest_cover missing values with mode
combined_data$forest_cover[is.na(combined_data$forest_cover)] <- 1
summary(combined_data)

coords <- as.matrix(combined_data[, c("decimalLon", "decimalLat")])

# Plot presence and pseudo-absence points
ggplot(combined_data, aes(x = decimalLon, y = decimalLat, color = as.factor(presence))) +
  geom_point(size = 2, alpha = 0.6) +
  scale_color_manual(values = c("blue", "red"), labels = c("Pseudo-Absence", "Presence")) +
  labs(title = "Spatial Distribution of Presence and Pseudo-Absence Points",
       x = "Longitude", y = "Latitude", color = "Type") +
  theme_minimal()


# Determine optimal bandwidth
gwr_bandwidth <- gwr.sel(presence ~ elevation + proximity_rivers + forest_cover,
                         data = combined_data,
                         coords = coords,
                         adapt = TRUE)  # Use adaptive bandwidth for non-uniform distribution

# Fit the GWR model with adaptive bandwidth
gwr_model <- gwr(presence ~ elevation + proximity_rivers + forest_cover,
                 data = combined_data,
                 coords = coords,
                 adapt = gwr_bandwidth)  # Use the numeric value of the selected bandwidth


# View summary
summary(gwr_model)

# View the structure of SDF
str(gwr_model$SDF)

# Extract the first few rows of SDF (local coefficients and diagnostics)
head(gwr_model$SDF@data)

combined_data$coef_elevation <- gwr_model$SDF$elevation
combined_data$coef_proximity_rivers <- gwr_model$SDF$proximity_rivers
combined_data$coef_forest_cover <- gwr_model$SDF$forest_cover

ggplot(combined_data, aes(x = decimalLon, y = decimalLat, color = coef_elevation)) +
  geom_point(size = 2) +
  scale_color_viridis_c() +
  labs(title = "Spatial Variation of Elevation Coefficient",
       x = "Longitude", y = "Latitude", color = "Coefficient") +
  theme_minimal()

ggplot(combined_data, aes(x = decimalLon, y = decimalLat, color = coef_proximity_rivers)) +
  geom_point(size = 2) +
  scale_color_viridis_c() +
  labs(title = "Spatial Variation of Proximity to Rivers Coefficient",
       x = "Longitude", y = "Latitude", color = "Coefficient") +
  theme_minimal()

ggplot(combined_data, aes(x = decimalLon, y = decimalLat, color = gwr_model$SDF$forest_cover1)) +
  geom_point(size = 2) +
  scale_color_viridis_c() +
  labs(title = "Spatial Variation of Forest Cover (Forest vs Others) Coefficient",
       x = "Longitude", y = "Latitude", color = "Coefficient") +
  theme_minimal()

ggplot(combined_data, aes(x = decimalLon, y = decimalLat, color = gwr_model$SDF$forest_cover2)) +
  geom_point(size = 2) +
  scale_color_viridis_c() +
  labs(title = "Spatial Variation of Forest Cover (Rangeland vs Others) Coefficient",
       x = "Longitude", y = "Latitude", color = "Coefficient") +
  theme_minimal()


# Extract local R-squared values
combined_data$local_r2 <- gwr_model$SDF$localR2

# Visualize local R-squared
ggplot(combined_data, aes(x = decimalLon, y = decimalLat, color = local_r2)) +
  geom_point(size = 2) +
  scale_color_viridis_c() +
  labs(title = "Local R-Squared Values",
       x = "Longitude", y = "Latitude", color = "Local R²") +
  theme_minimal()

# END OF SCRIPT



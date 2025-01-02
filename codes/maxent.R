# Load required libraries
library(dismo)
library(rJava)
library(raster)
library(scales)

# Step 1: Load eagle sightings data
eagle_data <- read.csv("eagle_sightings.csv")

# Step 2: Load environmental raster layers
elevation <- raster("elev.tif")
proximity_rivers <- raster("riverProximity.tif")
forest_cover <- raster("forest.tif")

# Validate raster layers
cat("Raster Layers:\n")
print(elevation)
print(proximity_rivers)
print(forest_cover)

# Step 3: Downsample raster layers
factor <- 3  # Aggregation factor (~30m resolution from ~10m)
elevation_coarse <- aggregate(elevation, fact = factor, fun = mean, na.rm = TRUE)
proximity_rivers_coarse <- aggregate(proximity_rivers, fact = factor, fun = mean, na.rm = TRUE)
forest_cover_coarse <- aggregate(forest_cover, fact = factor, fun = modal, na.rm = TRUE)  # Modal for categorical data

# Stack the downsampled layers
env_stack_coarse <- stack(elevation_coarse, proximity_rivers_coarse, forest_cover_coarse)

# Inspect the downsampled raster stack
cat("Downsampled Raster Stack:\n")
print(env_stack_coarse)
cat("Resolution of the coarse stack: ", res(env_stack_coarse), "\n")

# Step 4: Filter presence points within the raster extent
presence <- data.frame(lon = eagle_data$decimalLon, lat = eagle_data$decimalLat)
within_extent <- presence$lon >= extent(env_stack_coarse)@xmin & presence$lon <= extent(env_stack_coarse)@xmax &
  presence$lat >= extent(env_stack_coarse)@ymin & presence$lat <= extent(env_stack_coarse)@ymax

# Keep only points within the valid extent
presence <- presence[within_extent, ]
cat("Number of valid presence points: ", nrow(presence), "\n")

# Step 5: Split data into training and testing subsets
set.seed(123)  # For reproducibility
train_indices <- sample(nrow(presence), size = 0.7 * nrow(presence))  # 70% training data
presence_train <- presence[train_indices, ]
presence_test <- presence[-train_indices, ]

cat("Training Data: ", nrow(presence_train), "points\n")
cat("Testing Data: ", nrow(presence_test), "points\n")

# Step 6: Train the MaxEnt model
maxent_model_coarse <- maxent(
  x = env_stack_coarse, 
  p = presence_train, 
  path = "./maxent_results_coarse", 
  args = c("outputformat=raw")
)

# Step 7: Predict habitat suitability
suitability_coarse <- predict(maxent_model_coarse, env_stack_coarse)

# Step 8: Plot habitat suitability with overlays
# Define a semi-transparent red color
transparent_red <- alpha("red", 0.5)  # 0.5 = 50% transparency

# Plot the habitat suitability raster
plot(suitability_coarse, main = "Habitat Suitability with Contours and Points")

# Add red semi-transparent contour lines
contour(suitability_coarse, add = TRUE, col = transparent_red, lwd = 1)

# Overlay the presence points
points(presence$lon, presence$lat, col = "blue", pch = 20, cex = 0.6)

# Add a legend
legend("topright", legend = c("Presence Points", "Suitability Contours"),
       col = c("blue", transparent_red), pch = c(20, NA), lwd = c(NA, 1), cex = 0.8)

# Save the suitability map
writeRaster(suitability_coarse, "eagle_habitat_suitability_coarse.tif", format = "GTiff", overwrite = TRUE)

# Save the plot as a PNG
png("suitability_with_contours_and_points.png", width = 800, height = 600)
plot(suitability_coarse, main = "Habitat Suitability with Contours and Points")
contour(suitability_coarse, add = TRUE, col = transparent_red, lwd = 1)
points(presence$lon, presence$lat, col = "blue", pch = 20, cex = 0.6)
legend("topright", legend = c("Presence Points", "Suitability Contours"),
       col = c("blue", transparent_red), pch = c(20, NA), lwd = c(NA, 1), cex = 0.8)
dev.off()

# Step 9: Model evaluation using AUC and mean suitability
# Extract the built-in AUC from MaxEnt results
auc <- maxent_model_coarse@results[grep("AUC", rownames(maxent_model_coarse@results)), ]
cat("AUC from MaxEnt training: ", auc, "\n")

# Extract predicted suitability for presence points in the test set
predicted_suitability <- extract(suitability_coarse, presence_test)

# Compute mean suitability for test presence points
mean_suitability <- mean(predicted_suitability, na.rm = TRUE)
cat("Mean suitability of test presence points: ", mean_suitability, "\n")

# Save evaluation results
evaluation_results <- data.frame(AUC = auc, Mean_Suitability = mean_suitability)
write.csv(evaluation_results, "maxent_model_evaluation.csv", row.names = FALSE)

# END OF SCRIPT

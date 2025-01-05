# Load required libraries
library(dismo)
library(rJava)
library(raster)
library(scales)
library(sp)

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

# Step 8: Model Evaluation - AUC
# Extract AUC from MaxEnt results
auc <- maxent_model_coarse@results[grep("AUC", rownames(maxent_model_coarse@results)), ]
cat("AUC from MaxEnt training: ", auc, "\n")

# Step 9: Evaluate mean suitability for test presence points
predicted_suitability <- extract(suitability_coarse, presence_test)
mean_suitability <- mean(predicted_suitability, na.rm = TRUE)
cat("Mean suitability of test presence points: ", mean_suitability, "\n")

# Step 10: Evaluate threshold-based metrics
# Define a threshold (e.g., 10th percentile of training presence points)
threshold <- quantile(extract(suitability_coarse, presence_train), probs = 0.1, na.rm = TRUE)

# Generate binary predictions
binary_predictions <- suitability_coarse >= threshold

# Evaluate metrics using the test data
test_predictions <- extract(binary_predictions, presence_test)

# True Positives (TP) and False Negatives (FN)
TP <- sum(test_predictions == 1, na.rm = TRUE)
FN <- sum(test_predictions == 0, na.rm = TRUE)

# Generate pseudo-absence points for evaluation
pseudo_absence <- spsample(as(extent(env_stack_coarse), "SpatialPolygons"), n = 1000, type = "random")
pseudo_absence_predictions <- extract(binary_predictions, coordinates(pseudo_absence))

# True Negatives (TN) and False Positives (FP)
TN <- sum(pseudo_absence_predictions == 0, na.rm = TRUE)
FP <- sum(pseudo_absence_predictions == 1, na.rm = TRUE)

# Calculate metrics
sensitivity <- TP / (TP + FN)  # True Positive Rate
specificity <- TN / (TN + FP)  # True Negative Rate
TSS <- sensitivity + specificity - 1
accuracy <- (TP + TN) / (TP + TN + FP + FN)
precision <- TP / (TP + FP)

# Print metrics
cat("Model Evaluation Metrics:\n")
cat("Sensitivity: ", sensitivity, "\n")
cat("Specificity: ", specificity, "\n")
cat("TSS: ", TSS, "\n")
cat("Accuracy: ", accuracy, "\n")
cat("Precision: ", precision, "\n")

# Save evaluation metrics to a CSV file
evaluation_metrics <- data.frame(
  AUC = auc,
  Mean_Suitability = mean_suitability,
  Sensitivity = sensitivity,
  Specificity = specificity,
  TSS = TSS,
  Accuracy = accuracy,
  Precision = precision
)
write.csv(evaluation_metrics, "maxent_evaluation_metrics.csv", row.names = FALSE)

# Step 11: Save suitability raster and plot
writeRaster(suitability_coarse, "eagle_habitat_suitability_coarse.tif", format = "GTiff", overwrite = TRUE)

png("suitability_with_metrics.png", width = 800, height = 600)
plot(suitability_coarse, main = "Habitat Suitability with Metrics")
contour(suitability_coarse, add = TRUE, col = alpha("red", 0.6), lwd = 1)
points(presence_test$lon, presence_test$lat, col = "blue", pch = 20, cex = 2)
legend("topright", legend = c("Test Presence Points", "Suitability Contours"),
       col = c("blue", "red"), pch = c(20, NA), lwd = c(NA, 1), cex = 0.8)
dev.off()


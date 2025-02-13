# Load required library
install.packages("raster") # Uncomment if the package is not installed
library(raster)

# Load raster files
elevation <- raster("elev.tif")
rainfall <- raster("rainfall.tif")
LST <- raster("LST.tif")
rivers <- raster("riverProximity.tif")
forest <- raster("forest.tif") # Ensure forest categories remain untouched

# Output directory for processed files
output_dir <- "processed_rasters/"

# Ensure the output directory exists
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Process each raster for standardization and normalization
raster_list <- list(
  elevation = elevation,
  rainfall = rainfall,
  LST = LST,
  rivers = rivers
)

for (name in names(raster_list)) {
  raster_layer <- raster_list[[name]]
  
  # Compute statistics
  raster_mean <- cellStats(raster_layer, 'mean')
  raster_sd <- cellStats(raster_layer, 'sd')
  raster_min <- cellStats(raster_layer, 'min')
  raster_max <- cellStats(raster_layer, 'max')
  
  # Standardization (Z-Score)
  raster_standardized <- (raster_layer - raster_mean) / raster_sd
  writeRaster(raster_standardized, 
              filename = paste0(output_dir, name, "_standardized.tif"), 
              overwrite = TRUE)
  
  # Normalization (Min-Max Scaling)
  raster_normalized <- (raster_layer - raster_min) / (raster_max - raster_min)
  writeRaster(raster_normalized, 
              filename = paste0(output_dir, name, "_normalized.tif"), 
              overwrite = TRUE)
}

# Completion message
cat("Standardization and normalization complete! Files saved to:", output_dir, "\n")


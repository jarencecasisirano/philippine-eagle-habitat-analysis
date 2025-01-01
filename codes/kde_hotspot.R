library(ggplot2)
library(MASS)
library(spatstat)

# Load the CSV file
eagle_data <- read.csv("eagle_sightings.csv")

# Inspect the data
head(eagle_data)

# Ensure columns exist
if (!all(c("decimalLat", "decimalLon") %in% names(eagle_data))) {
  stop("The required columns 'decimalLat' and 'decimalLon' are missing.")
}

# Create a point pattern object for spatstat
ppp_data <- ppp(
  x = eagle_data$decimalLon,
  y = eagle_data$decimalLat,
  window = owin(
    xrange = range(eagle_data$decimalLon, na.rm = TRUE),
    yrange = range(eagle_data$decimalLat, na.rm = TRUE)
  )
)

# Automatically select optimal bandwidth for KDE
sigma_optimal <- bw.diggle(ppp_data)

# Perform KDE using the optimal bandwidth
kde <- density(ppp_data, sigma = sigma_optimal)

# Plot KDE
plot(kde, main = "Kernel Density Estimation of Eagle Sightings",
     xlab = "Longitude", ylab = "Latitude")

# ggplot2 2D KDE visualization with automated bandwidth
ggplot(eagle_data, aes(x = decimalLon, y = decimalLat)) +
  stat_density_2d(
    aes(fill = ..level.., alpha = ..level..),
    geom = "polygon",
    contour = TRUE
  ) +
  geom_point(color = "red", alpha = 0.4) +  # Overlay occurrence points
  scale_fill_viridis_c() +  # Use a color scale for better visualization
  labs(
    title = "2D Kernel Density Estimation of Eagle Sightings",
    x = "Longitude",
    y = "Latitude"
  ) +
  guides(alpha = "none") +  # Suppress the alpha legend
  theme_minimal()

# 1D Density Plots for Latitude and Longitude
# Latitude
ggplot(eagle_data, aes(x = decimalLat)) +
  geom_density(fill = "skyblue", alpha = 0.7) +
  labs(
    title = "Density Plot of Latitude",
    x = "Latitude",
    y = "Density"
  ) +
  theme_minimal()

# Longitude
ggplot(eagle_data, aes(x = decimalLon)) +
  geom_density(fill = "lightgreen", alpha = 0.7) +
  labs(
    title = "Density Plot of Longitude",
    x = "Longitude",
    y = "Density"
  ) +
  theme_minimal()

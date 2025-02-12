

library(ggplot2)
## Normality assessment for total muscle volume and total adipose tissue volume
## Before conducting statistical test I would like to visualize the distribution with histogram and Q-Q plot.

# total muscle volume

typeof(merged_data$muscle_whole_scan)
# The variable is character type. We should convert it to integer.
merged_data$muscle_whole_scan <- as.integer(merged_data$muscle_whole_scan)


ggplot(merged_data, aes(x = muscle_whole_scan)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "steelblue", alpha = 0.7) +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram and Density Plot for muscle") +
  theme_minimal()

# The distribution is right skewed. We can make it as log transformed.

ggplot(merged_data, aes(x = log(muscle_whole_scan))) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "steelblue", alpha = 0.7) +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram and Density Plot for muscle(log transformed)") +
  theme_minimal()

# Now the distribution is more normal than before. We could also try square root transformation.

ggplot(merged_data, aes(x = sqrt(muscle_whole_scan))) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "steelblue", alpha = 0.7) +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram and Density Plot for muscle (sqrt)") +
  theme_minimal()

# Log transformation works better

# We could also look at Q-Q plot

qqnorm(merged_data$muscle_whole_scan)
qqline(merged_data$muscle_whole_scan, col = "red")

# The distribution is kind of banana formed. Which is a clear violation of normality assumption.

# Q-Q plot after log transformation
qqnorm(log(merged_data$muscle_whole_scan))
qqline(log(merged_data$muscle_whole_scan), col = "red")

# After log transformation the distribution are more align with the red line.


# Shapiro-Wilk test to assess the normality
shapiro.test(merged_data$muscle_whole_scan)

# p-value = 8.88e-05 << 0.05; So, the data deviates from normality.

# With log-transformed data
shapiro.test(log(merged_data$muscle_whole_scan))

# p-value = 0.484. After log transformation the total muscle volume follows normal distribution.




### Total adipose tissue volume

typeof(merged_data$toAdiTissue_whole_scan)
# The variable is character type. We should convert it to integer.

merged_data$toAdiTissue_whole_scan <- as.integer(merged_data$toAdiTissue_whole_scan)


ggplot(merged_data, aes(x = toAdiTissue_whole_scan)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "steelblue", alpha = 0.7) +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram and Density Plot for muscle") +
  theme_minimal()

# The distribution is little bit right skewed.
# Lets look on log-transformed data.

ggplot(merged_data, aes(x = log(toAdiTissue_whole_scan))) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "steelblue", alpha = 0.7) +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram and Density Plot for muscle(log transformed)") +
  theme_minimal()

# The distribution gets left skewed. We could try square root transformation.

ggplot(merged_data, aes(x = sqrt(toAdiTissue_whole_scan))) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "steelblue", alpha = 0.7) +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram and Density Plot for muscle (sqrt)") +
  theme_minimal()

# Visually it looks without any transformation the data is more normally distributed.

# Q-Q plot

qqnorm(merged_data$toAdiTissue_whole_scan)
qqline(merged_data$toAdiTissue_whole_scan, col = "red")

# The distribution is not align with the red line.

# Q-Q plot after log transformation
qqnorm(log(merged_data$toAdiTissue_whole_scan))
qqline(log(merged_data$toAdiTissue_whole_scan), col = "red")

# Q-Q plot after square-root transformation
qqnorm(sqrt(merged_data$toAdiTissue_whole_scan))
qqline(sqrt(merged_data$toAdiTissue_whole_scan), col = "red")


# Looks like the square-root transformed data are more align with the red line.


# Shapiro-Wilk test to assess the normality
shapiro.test(merged_data$toAdiTissue_whole_scan)

# p-value = 0.0162 < 0.05; So, the data deviates from normality.

# With log-transformed data
shapiro.test(log(merged_data$toAdiTissue_whole_scan))

# p-value = 4.71e-10

# Square-root transformation
shapiro.test(sqrt(merged_data$toAdiTissue_whole_scan))

# p-value = 0.0258

# In conclusion, the total adipose tissue volume data is not normally distributed. After log transformation the total muscle volume follows normal distribution.






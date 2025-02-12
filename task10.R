

## Visualization
# We can create boxplot, violin plot or density plot to illustrate the distribution of various adipose tissue compartments between genders.

library(ggplot2)
# 1. Box plot
table(merged_data$`sex (MALE/FEMALE)`)


# Boxplot - total adipose tissue volume

ggplot(merged_data, aes(x = `sex (MALE/FEMALE)`, y = toAdiTissue_whole_scan, fill = `sex (MALE/FEMALE)`)) +
  geom_boxplot() +
  labs(title = "Distribution of total adipose tissue by gender",
       x = "Gender",
       y = "Total adipose tissue volume") +
  theme_minimal()


# Violin plot - intramuscular adipose tissue volume

ggplot(merged_data, aes(x = `sex (MALE/FEMALE)`, y = itmAdiTissue_whole_scan, fill = `sex (MALE/FEMALE)`)) +
  geom_violin(trim = FALSE, alpha = 0.5) +
  labs(title = "Violin plot of intramuscular adipose tissue distribution by gender",
       x = "Gender",
       y = "intramuscular adipose tissue volume") +
  theme_minimal()


# Density plot - visceral adipose tissue volume

ggplot(merged_data, aes(x = visAdiTissue_whole_scan, fill = `sex (MALE/FEMALE)`)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density plot of visceral adipose tissue volume between Gender",
       x = "visceral adipose tissue volume",
       y = "Density") +
  theme_minimal()




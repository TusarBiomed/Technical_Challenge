

## To accomplish the task we can do two sample t-test of all body composition metrics for each therapy individually.
## However, it is time consuming. Instead of doing this we can perform linear regression and adjust p-value at the end to check multiple hypothesis testing error.

library(tidyverse)
library(broom)

## Check the data-type of the variables and transform if necessary
typeof(merged_data$adjuvantTherapy)
typeof(merged_data$neoAdjuvantTherapy)

typeof(merged_data$muscle_whole_scan)
typeof(merged_data$toAdiTissue_whole_scan)
typeof(merged_data$itmAdiTissue_whole_scan)
typeof(merged_data$subAdiTissue_whole_scan)
typeof(merged_data$visAdiTissue_whole_scan)


merged_data$itmAdiTissue_whole_scan <- as.integer(merged_data$itmAdiTissue_whole_scan)
merged_data$subAdiTissue_whole_scan <- as.integer(merged_data$subAdiTissue_whole_scan)
merged_data$visAdiTissue_whole_scan <- as.integer(merged_data$visAdiTissue_whole_scan)


# Fit linear regression models for each body composition parameters
totalMuscle_model <- lm(muscle_whole_scan ~ adjuvantTherapy + neoAdjuvantTherapy, data = merged_data)
totalAdipose_model <- lm(toAdiTissue_whole_scan ~ adjuvantTherapy + neoAdjuvantTherapy, data = merged_data)
itmAdipose_model <- lm(itmAdiTissue_whole_scan ~ adjuvantTherapy + neoAdjuvantTherapy, data = merged_data)
subAdipose_model <- lm(subAdiTissue_whole_scan ~ adjuvantTherapy + neoAdjuvantTherapy, data = merged_data)
visAdipose_model <- lm(visAdiTissue_whole_scan ~ adjuvantTherapy + neoAdjuvantTherapy, data = merged_data)


# Get the summary of the regression models
summary(totalMuscle_model)
summary(totalAdipose_model)
summary(itmAdipose_model)
summary(subAdipose_model)
summary(visAdipose_model)


## Adjust for multiple comparison
p_values <- c(summary(totalMuscle_model)$coefficients[,4],
              summary(totalAdipose_model)$coefficients[,4],
              summary(itmAdipose_model)$coefficients[,4],
              summary(subAdipose_model)$coefficients[,4],
              summary(visAdipose_model)$coefficients[,4])

adjusted_p <- p.adjust(p_values, method = "fdr")

adjusted_p

"
adjusted_p
         (Intercept)    adjuvantTherapyyes neoAdjuvantTherapyyes           (Intercept)    adjuvantTherapyyes neoAdjuvantTherapyyes           (Intercept)
          3.41742e-85           7.71786e-01           5.72524e-02           9.23764e-56           7.93333e-01           1.62294e-01           4.13284e-49
   adjuvantTherapyyes neoAdjuvantTherapyyes           (Intercept)    adjuvantTherapyyes neoAdjuvantTherapyyes           (Intercept)    adjuvantTherapyyes
          7.93333e-01           2.14718e-02           9.94613e-44           8.54643e-01           1.62294e-01           1.36914e-36           7.93333e-01
neoAdjuvantTherapyyes
          7.93333e-01
"

# Order of the adjusted p_values are consistent with the body composition parameters order.
# After adjusting for multiple hypothesis testing, only neoAdjuvant therapy are found correlated with intramuscular adipose tissue volume.





# Many variables have a lots of missing values.
# Here, we set a threshold value (<10%). The variable which has missing less than the threshold will consider for imputation.
# Two variables have missing less than the threshold. They are 'neoadjuvant therapy (yes/no)', and 'type_of_surgery'.

library(mice)

# Method selection for missing value imputation
# For 'neoadjuvant therapy (yes/no)' we select logistic regression as it is a binary variable.
# And for 'type_of_surgery' polynomial regression would be the proper choice as it is a non-ordinal categorical variable.


# Creating the method vector with empty strings for all variables
meth <- make.method(merged_data)

# Specify imputation methods for the variables
meth["neoadjuvant therapy (yes/no)"] <- "logreg"
meth["type_of_surgery"] <- "polyreg"

# Define a predictor matrix by stating all the required clinical variables which might play a crucial role for the variables.

pred <- make.predictorMatrix(merged_data)

# Set all entries to 0 (exclude all variables from being predictors)
pred[,] <- 0

# Specify predictors for neoadjuvant_therapy and type_of_surgery
# Here, I am guessing that these predictive variables are the vital one for the respective outcome variables.

pred["neoadjuvant therapy (yes/no)", c("M (metastasen)", "toAdiTissue_whole_scan", "itmAdiTissue_whole_scan", "Grading")] <- 1
pred["type_of_surgery", c("muscle_whole_scan", "CEA before surgery", "Grading", "subAdiTissue_whole_scan")] <- 1

# Implement mice function to generate the imputed datasets
# Create two imputed datasets
imputed_data <- mice(merged_data, method = meth, predictorMatrix = pred, m = 2, maxit = 50, seed = 500)



## The mice package is not working due to naming of the variables e.g; `tumor size (mm), number of locoregional lymph nodes, and others.
## We should remove the empty spaces, and other unwanted symbols from the variable names before running mice function.

# Here I am using simple mode imputation as they are categorical variable

library(dplyr)

# Estimating mode of type_of_surgery
surgery_mode <- merged_data %>%
  count(type_of_surgery, sort = TRUE) %>%
  slice(1) %>%
  pull(type_of_surgery)

# Imputing the mode
merged_data$type_of_surgery[is.na(merged_data$type_of_surgery)] <- surgery_mode


# Estimating the mode of 'neoadjuvant therapy (yes/no)'
neoAdjuvant_mode <- merged_data %>%
  count(`neoadjuvant therapy (yes/no)`, sort = TRUE) %>%
  slice(1) %>%
  pull(`neoadjuvant therapy (yes/no)`)

merged_data$`neoadjuvant therapy (yes/no)`[is.na(merged_data$`neoadjuvant therapy (yes/no)`)] <- neoAdjuvant_mode


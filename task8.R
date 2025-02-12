

# At first create a new variable for intramuscular adipose tissue volume to total muscle volume ratio

merged_data$itmToMuscle <- merged_data$itmAdiTissue_whole_scan / merged_data$muscle_whole_scan


# The cutoff value to determine postoperative complications:

#  Create a Receiver Operating Characteristic (ROC) curve and find out the optimum cutoff point to detect postoperative complications
typeof(merged_data$complications)

merged_data <- merged_data %>%
  mutate(postOperative_complications = ifelse(complications == "yes", 1, 0))


library(pROC)
roc_curve <- roc(merged_data$postOperative_complications, merged_data$itmToMuscle)
plot(roc_curve, col = "blue", main = "ROC curve", print.auc = TRUE)

# The AUC is 0.53. It looks not a good association.

cutoff <- coords(roc_curve, "best", ret = "threshold")
paste0("The cutoff value = ", cutoff)

"
The cutoff value = 0.138409961685824
"

# To investigate the relationship between the ratio and postoperative_complications, we can perform logistic regression adjust for gender


ratio_Model <- glm(postOperative_complications ~ itmToMuscle + `sex (MALE/FEMALE)`, family = binomial, data = merged_data)
summary(ratio_Model)

"
Coefficients:
                        Estimate Std. Error z value Pr(>|z|)
(Intercept)                0.083      0.381    0.22     0.83
itmToMuscle                0.996      1.117    0.89     0.37
`sex (MALE/FEMALE)`MALE    0.524      0.300    1.75     0.08
"

# Results of the logistic regression says, there is not enough evidence in the data to justify that the ratio is associated with postoperative complications.
# However, the gender variable is significantly associated.




# Load required packages
library(survival)
library(survminer)
library(dplyr)

# To assess the influence of neoadjuvant therapy and adjuvant therapy on overall survival we first plot the Kaplan-Meier survival curve.

# Checking the data type and transform them in suitable format if necessary

typeof(merged_data$`Death during follow-up`)
merged_data <- merged_data %>%
  mutate(survivalStatus = ifelse(`Death during follow-up` == "yes", 1, 0))

# Rename some large variables for convenience

merged_data$survivalTime <- as.integer(merged_data$`Overall survival in months from diagnosis`)
merged_data$adjuvantTherapy <- merged_data$`adjuvant therapy (yes/no)`
merged_data$neoAdjuvantTherapy <- merged_data$`neoadjuvant therapy (yes/no)`


fit1 <- survfit(Surv(survivalTime, survivalStatus) ~ adjuvantTherapy, data = merged_data)
fit2 <- survfit(Surv(survivalTime, survivalStatus) ~ neoAdjuvantTherapy, data = merged_data)


ggsurvplot(fit1, data = merged_data, pval = TRUE, conf.int = TRUE,
           title = "Kaplan-Meier curve for adjuvant therapy", risk.table = TRUE, legend.title = "adjuvant therapy")

# The image saved as KM_adjuvant.pdf
# The Kaplan-Meier curve depicts significant difference on overall survival between patients who undergoes adjuvant therapy or not.

ggsurvplot(fit2, data = merged_data, pval = TRUE, conf.int = TRUE,
           title = "Kaplan-Meier curve for neoadjuvant therapy", risk.table = TRUE, legend.title = "neoadjuvant therapy")

# The image saved as KM_neoadjuvant.pdf
# According to the Kaplan-Meier plot the effect of neoadjuvant therapy is not significant on patients overall survival


## To determine if the therapies are independent predictors of survival, we can fit a multivariable Cox model with an interaction term.
## The interaction term will define whether the effect of one variable on survival depends on the level of another variable.

cox_Model <- coxph(Surv(survivalTime, survivalStatus) ~ adjuvantTherapy + neoAdjuvantTherapy + adjuvantTherapy*neoAdjuvantTherapy, data = merged_data)

summary(cox_Model)
"
                                           coef exp(coef) se(coef)     z Pr(>|z|)
adjuvantTherapyyes                       -0.717     0.488    0.196 -3.65  0.00026 ***
neoAdjuvantTherapyyes                    -0.420     0.657    0.232 -1.81  0.07022 .
adjuvantTherapyyes:neoAdjuvantTherapyyes  0.380     1.462    0.366  1.04  0.29976

Concordance= 0.662  (se = 0.023 )
Likelihood ratio test= 15.5  on 3 df,   p=0.001
Wald test            = 16  on 3 df,   p=0.001
Score (logrank) test = 16.6  on 3 df,   p=8e-04
"

## The Cox proportional hazards model is telling that only adjuvant therapy has significant influence on patient survival.
## According to the model patient who undergoes adjuvant therapy has a factor of 0.49 less hazard than who does not and the effect is independent.


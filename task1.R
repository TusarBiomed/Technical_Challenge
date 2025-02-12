
## Read all the datasets
library(readxl)

clinicalData <- read_excel("PDAC Patient clinical data.xlsx")

## Load all the datasets from BCA data and rename the variables according to their body composition parameter
# Bone
bone_Data <- read_excel("PDAC Patient BCA data.xlsx")
colnames(bone_Data) <- c(bone_Data[1, 1], paste0("bone_", bone_Data[1, 2]), paste0("bone_", bone_Data[1, 3]))
bone_Data <- bone_Data[-1, ]

# Total muscle volume
muscle_Data <- read_excel("PDAC Patient BCA data.xlsx", sheet = 2)
colnames(muscle_Data) <- c(muscle_Data[1, 1], paste0("muscle_", muscle_Data[1, 2]), paste0("muscle_", muscle_Data[1, 3]))
muscle_Data <- muscle_Data[-1, ]

# Total adipose tissue volume
totalAdiTissue_Data <- read_excel("PDAC Patient BCA data.xlsx", sheet = 3)
colnames(totalAdiTissue_Data) <- c(totalAdiTissue_Data[1, 1], paste0("toAdiTissue_", totalAdiTissue_Data[1, 2]), paste0("toAdiTissue_", totalAdiTissue_Data[1, 3]))
totalAdiTissue_Data <- totalAdiTissue_Data[-1, ]

# Total intramuscular adipose tissue volume
itmAdiTissue_Data <- read_excel("PDAC Patient BCA data.xlsx", sheet = 4)
colnames(itmAdiTissue_Data) <- c(itmAdiTissue_Data[1, 1], paste0("itmAdiTissue_", itmAdiTissue_Data[1, 2]), paste0("itmAdiTissue_", itmAdiTissue_Data[1, 3]))
itmAdiTissue_Data <- itmAdiTissue_Data[-1, ]

# Subcutaneous adipose tissue volume
subAdiTissueData <- read_excel("PDAC Patient BCA data.xlsx", sheet = 5)
colnames(subAdiTissueData) <- c(subAdiTissueData[1, 1], paste0("subAdiTissue_", subAdiTissueData[1, 2]), paste0("subAdiTissue_", subAdiTissueData[1, 3]))
subAdiTissueData <- subAdiTissueData[-1, ]

# Visceral adipose tissue volume
visAdiTissueData <- read_excel("PDAC Patient BCA data.xlsx", sheet = 6)
colnames(visAdiTissueData) <- c(visAdiTissueData[1, 1], paste0("visAdiTissue_", visAdiTissueData[1, 2]), paste0("visAdiTissue_", visAdiTissueData[1, 3]))
visAdiTissueData <- visAdiTissueData[-1, ]


# Merge all datasets by patient identifier
dataFiles <- list(bone_Data, muscle_Data, totalAdiTissue_Data, itmAdiTissue_Data, subAdiTissueData, visAdiTissueData, clinicalData)
merged_data <- reduce(dataFiles, inner_join, by = "ID")

length(unique(merged_data$ID))

# Export the merged data as an excel file
library(writexl)

write_xlsx(merged_data, "mergedData.xlsx")


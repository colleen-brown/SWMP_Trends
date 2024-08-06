
#   PRINCIPAL COMPONENT ANALYSIS -  PCA

#-------------------------------------------------------------------------------
# REQUIRED PACKAGES:
# use 'install.packages()' function if packages listed below are not already installed
library(readxl) # need only if SWMP data was saved as .XLSX file
library(stats) # for PCA
library(devtools) # for making PCA plots
library(factoextra) # for eigenvalues

#-------------------------------------------------------------------------------
# IMPORT COMPOSITE DATA SET: (WQ, MET, NUT) for stations LC - RC - CMS -> 'ICW'

# Example if CSV file:
ICW <- read.csv("Input_Files/ICW.csv") # function available in base R
View(ICW)

# Example if Excel file:
ICW <- read_excel("Input_Files/ICW.xlsx") # need 'readxl' package 
View(ICW)


#-------------------------------------------------------------------------------
# (1) DATA PREP FOR PCA: 
# getting data only for the NUMERICAL variables (principle components) 

# SWMP Variables Selected from the 'ICW' df:
# temp, sal, do_mgl, pH, turb, chl, precip, PAR, wind, po4, nh3, no2_no3


# (1.1) SWMP Stations LC & RC 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Data for PCA with just LC & RC (separated from CMS df bc CMS does not have nutrient data)
# Selecting only columns of variables outlined above + 'station' column for labeling
LC_RC <- ICW[1:475,c(1,3,5,7:17)]    
View(LC_RC)

# REMOVE NAs (data set with 'station' column for labeling)
LC_RC_names <- na.omit(LC_RC) # na.omit removes any NAs in data, needed for PCA
View(LC_RC_names)

# df without 'site' column for PCA processing
LC_RC.pc <- LC_RC_names[,c(2:14)]
View(LC_RC.pc)


# (1.2)  LC - RC - CMS 
#~~~~~~~~~~~~~~~~~~~~~~
# REMOVE nutrient columns (4:6) from LC_RC df b/c CMS does not have nutrients
# Data for PCA with just LC & RC & CMS
ICW_2 <- ICW[,c(1,3,5,7,9:14)]
View(ICW_2)

# dataset with 'site' column for labeling
ICW_names_2 <- na.omit(ICW_2)
View(ICW_names_2)

# dataset without 'station' column for PCA
ICW_2.pc <- ICW_names_2[,c(2:10)]

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
# (2) COMPUTE PCA 
# use the 'prcomp' function to compute PCA 
# RDocumentation for 'prcomp': 
# https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/prcomp

#-------------------------------------------------------------------------------
# (2.1) PCA 1:  LC + RC ALL PARAMETERS (NUT, WQ, MET)

#compute PCA 
LC_RC.pca <- prcomp(LC_RC.pc, center = TRUE, scale. = TRUE)

# Quick summary reference
summary(LC_RC.pca)

# shows the detailed list of PCA object components 
str(LC_RC.pca)

# get eigenvalues
get_eig(LC_RC.pca)

# Scree plot of (PC) eigenvalues - listed as 'dimensions' on the X axis
fviz_eig(LC_RC.pca)

# Vector plot for PC1 & PC2
ggbiplot(LC_RC.pca)

# Vector plot for PC3 & PC4
ggbiplot(LC_RC.pca, choices=c(3,4))

# Group data by SWMP station
LC_RC_site_groups <- as.factor(LC_RC_names$station)

gg <- ggbiplot(LC_RC.pca, ellipse=TRUE, groups = LC_RC_site_groups)
gg + coord_fixed(ratio = 3/5)


#-------------------------------------------------------------------------------
# (2.2) PCA 2: LC + RC + CMS JUST WQ + MET DATA 

#compute PCA 
ICW.pca <- prcomp(ICW.pc, center = TRUE, scale. = TRUE)

# Quick summary reference
summary(ICW.pca)

# shows the detailed list of PCA object components 
str(ICW.pca)

# get eigenvalues
get_eig(ICW.pca)

# Scree plot of (PC) eigenvalues - listed as 'dimensions' on the X axis
fviz_eig(ICW.pca)

# Vector plot for PC1 & PC2
ggbiplot(ICW.pca)

# Vector plot for PC3 & PC4
ggbiplot(ICW.pca, choices=c(3,4))

# Group data by SWMP station
ICW_site_groups <- as.factor(ICW_names$station)

gg2 <- ggbiplot(ICW.pca, ellipse=TRUE, groups = ICW_site_groups)
gg2 + coord_fixed(ratio = 3/5)



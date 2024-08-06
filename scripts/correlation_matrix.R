
# ------------------------------------------------------------------------------
#                       CORRELATION MATRICES 
# ------------------------------------------------------------------------------
# REQUIRED PACKAGES:
library(readxl) # need only if SWMP data was saved as .XLSX file
library(corrplot) # for cor.mtest function

# use install.packages() if packages above are not yet installed

# For more information on 'corrplot' see RDocumentation link below:
# https://rdocumentation.org/packages/corrplot/versions/0.92/topics/cor.mtest

#-------------------------------------------------------------------------------
# IMPORT COMPOSITE DATA SET: (WQ, MET, NUT) for stations LC - RC - CMS -> 'ICW'
#-------------------------------------------------------------------------------
# ICW df has monthly mean values of each parameter
# Example if CSV file:
ICW <- read.csv("Input_Files/ICW.csv") # function available in base R
View(ICW)

# Example if Excel file:
ICW <- read_excel("Input_Files/ICW.xlsx") # need 'readxl' package 
View(ICW)


# ------------------------------------------------------------------------------
#  CMS - CORRELATION MATRIX
# ------------------------------------------------------------------------------

# select only rows of data for CMS from the composite SWMP df 'ICW' and columns
# of parameters to test correlations: (temp, sal, spcond, do_mgl, do_pct, pH, 
# turb, chl, precip, PAR, wind)
CMS <- ICW[476:521,c(3:7,9:14)]
View(CMS) # view df

CMS_correl <- na.omit(CMS) # remove NA values from df 
View(CMS_correl) #view df

# Create a correlation matrix
CMS.cor <- cor(CMS_correl) # cor() function available in base R
View(CMS.cor) 

# Significance test for each pair of input features
# Shows only the correlation coeff. that have an alpha threshold = 0.05 (p < 0.05), conf.level = 0.95
CMS_test = cor.mtest(CMS_correl, conf.level = 0.95) # conf.level can be adjusted
View(CMS_test) 

# Create a correlation matrix plot
corrplot(CMS.cor, p.mat = CMS_test$p, method = 'circle', type = 'lower', insig='blank',
         addCoef.col ='black', tl.col = "black", number.cex = 0.6, order = 'AOE', diag=FALSE)


# ------------------------------------------------------------------------------
#  LC - CORRELATION MATRIX
# ------------------------------------------------------------------------------
# Same methodology repeated for LC & RC

# select only rows of data for LC from the composite SWMP df 'ICW'
LC <- ICW[239:475,c(3:5,7:17)]
View(LC) # view df

LC_correl <- na.omit(LC) # remove NAs from df
View(LC_correl)

# Create a correlation matrix
LC.cor <- cor(LC_correl) # cor() function available in base R

# Significance test for each pair of input features
# Shows only the correlation coeff. that have an alpha threshold = 0.05 (p < 0.05), conf.level = 0.95
LC_test = cor.mtest(LC_correl, conf.level = 0.95) # conf.level can be adjusted

# Create a correlation matrix plot
corrplot(LC.cor, p.mat = LC_test$p, method = 'circle', type = 'lower', insig='blank',
         addCoef.col ='black', tl.col = "black", number.cex = 0.6, order = 'AOE', diag=FALSE)



# ------------------------------------------------------------------------------
#  RC - CORRELATION MATRIX
# ------------------------------------------------------------------------------
# select only rows of data for LC from the composite SWMP df 'ICW'
RC <- ICW[1:238,c(3:5,7:17)]
View(RC)  #view df

RC_correl <- na.omit(RC) # remove NAs from df
View(RC_correl)

# Create a correlation matrix
RC.cor <- cor(RC_correl)

# Significance test for each pair of input features
# Shows only the correlation coeff. that have an alpha threshold = 0.05 (p < 0.05), conf.level = 0.95
RC_test = cor.mtest(RC_correl, conf.level = 0.95) # conf.level can be adjusted

# Create a correlation matrix plot
corrplot(RC.cor, p.mat = RC_test$p, method = 'circle', type = 'lower', insig='blank',
         addCoef.col ='black', tl.col = "black", number.cex = 0.6, order = 'AOE', diag=FALSE)




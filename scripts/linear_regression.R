#-------------------------------------------------------------------------------
# LINEAR REGRESSION: used to determine significance and direction of trends

# The examples shown below are for SWMP nutrient parameters ('po4', 'nh3', 'no2_3', 'DIN_DIP')
# The same process was repeated for each SWMP parameter and station

#-------------------------------------------------------------------------------
# REQUIRED PACKAGES:
library(stats) # for 'lm()' function

#RDocumentation: https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/lm 

#-------------------------------------------------------------------------------
# IMPORTING NUTRIENT DATA FROM FILE: 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# df = 'NUT_df', SWMP nutrient data for SWMP stations 'LC' and 'RC'
# Import your df from file and replace 'NUT_df' with your df name
# see 'data_preprocessing.R' script for examples on how to prepare data

RC_NUT <- NUT_df[1:239,c(1:6)] # selecting rows for station 'RC' only
View(RC_NUT)

LC_NUT <- NUT_df[240:478,c(1:6)] # selecting rows for station 'LC' only
View(LC_NUT)

#-------------------------------------------------------------------------------
#~~~~~
# PO4 
#~~~~~
#isolate po4 data and remove NAs for LC
LC_po4 <- na.omit(LC_NUT[,c(1:3)])
View(LC_po4)

#isolate po4 data and remove NAs for RC
RC_po4 <- na.omit(RC_NUT[,c(1:3)])
View(RC_po4)

# Run linear regression model on LC po4 data
LC.po4.lm <- lm(po4 ~ date, data = LC_po4)
summary(LC.po4.lm)

# Run linear regression model on RC po4 data
RC.po4.lm <- lm(po4 ~ date, data = RC_po4)
summary(RC.po4.lm)


#~~~~~
# NH3 
#~~~~~
#isolate nh3 data and remove NAs for LC
LC_nh3 <- na.omit(LC_NUT[,c(1:2,4)])
View(LC_nh3)

#isolate nh3 data and remove NAs for RC
RC_nh3 <- na.omit(RC_NUT[,c(1:2,4)])
View(RC_nh3)

# Run linear regression model on LC nh3 data
LC.nh3.lm <- lm(nh3 ~ date, data = LC_nh3)
summary(LC.nh3.lm)

# Run linear regression model on RC nh3 data
RC.nh3.lm <- lm(nh3 ~ date, data = RC_nh3)
summary(RC.nh3.lm)


#~~~~~~~~~
# no2_no3 
#~~~~~~~~
#isolate no3 data and remove NAs for LC
LC_no3 <- na.omit(LC_NUT[,c(1:2,5)])
View(LC_no3)

#isolate no3 data and remove NAs for RC
RC_no3 <- na.omit(RC_NUT[,c(1:2,5)])
View(RC_no3)

# Run linear regression model on LC no3 data 
LC.no2_no3.lm <- lm(no2_no3 ~ date, data = LC_no3)
summary(LC.no2_no3.lm)

# Run linear regression model on RC no3 data
RC.no2_no3.lm <- lm(no2_no3 ~ date, data = RC_no3)
summary(RC.no2_no3.lm)


#~~~~~~~~
# DIN/DIP
#~~~~~~~~
#isolate DIN/DIP data and remove NAs for LC
LC_DIN_DIP <- na.omit(LC_NUT[,c(1:2,6)])
View(LC_DIN_DIP)

#isolate DIN/DIP data and remove NAs for RC
RC_DIN_DIP <- na.omit(RC_NUT[,c(1:2,6)])
View(RC_DIN_DIP)

#Change column name from DIN/DIP to DIN_DIP (R doesn't like '/')
colnames(LC_DIN_DIP)[colnames(LC_DIN_DIP) == 'DIN/DIP'] <- 'DIN_DIP'
colnames(RC_DIN_DIP)[colnames(RC_DIN_DIP) == 'DIN/DIP'] <- 'DIN_DIP'

# Run linear regression model on LC DIN_DIP data 
LC_DIN_DIP.lm <- lm(DIN_DIP ~ date, data = LC_DIN_DIP)
summary(LC_DIN_DIP.lm)

# Run linear regression model on RC DIN_DIP data 
RC_DIN_DIP.lm <- lm(DIN_DIP ~ date, data = RC_DIN_DIP)
summary(RC_DIN_DIP.lm)


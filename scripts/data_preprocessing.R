# NOTE: Code below was run with R Studio 2020. 

#-------------------------------------------------------------------------------
# INSTALL PACKAGES:
# use the 'install.packages()' function to download each of the packages listed 
# in the 'library()' function below 

library(readxl) # to read Excel files into R
library(lubridate) # work with date data 

#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# SET WORKING DIRECTORY: this is where files will be accessed and stored 
setwd("/SWMP_R_Project")
getwd()
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# IMPORT SWMP DATA FILES: 

#  Data were downloaded from http://nerrscdmo.org/ > 'View/Download Data' > 
# 'Advanced Query System' > 'ZIP Download' > 'From 2002 to 2022' > 'Get Files'

# Note, in this study we downloaded Meteorological (MET), Water Quality (WQ), & 
# Nutrient (NUT) data for 2 stations, Loosin Creek (LC) and Research Creek (RC),
# from January 2002 to December 2021. A limited (5-yr) WQ dataset from a 3rd 
# station, Center for Marine Science (CMS), was used in this study but accessed 
# via personal communication from a NERRS staff member and not the website. 

# NERRS Raw Data File Names for the 2 stations (LC & RC):
# WQ - 'NOCLCWQ.csv', 'NOCRCWQ.csv'
# MET - 'NOCRCMET.csv'
# NUT - 'NOCLCNUT.csv', 'NOCRCWQ.csv'
# In this study the .CSV files downloaded from the website were saved as .XLSX 
# files on a local computer, but you can work directly with the .CSV files.

# WQ and MET data files are reported in 15-minute/30-minute intervals resulting 
# in hundreds of thousands to millions of data points for stations over the 
# 20-yr period that need to be processed prior to statistical analyses. NUT data
# are collected monthly. 


# IMPORT LC - WQ 
# need to install 'readxl' package to use 'read_excel' function
LC_WQ <- read_excel("Input_Files/NOCLCWQ.xlsx") # reads file from folder 'Input_Files' into R 
View(LC_WQ) # View data in R

# IMPORT RC - WQ
RC_WQ <- read_excel("Input_Files/NOCRCWQ.xlsx")
View(RC_WQ) 

# IMPORTRC - MET 
RC_MET <- read_excel("Input_Files/NOCRCMET.xlsx") 
View(RC_MET) 
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# PROCESS DATA: Remove suspect data flagged by NERRS SWMP team

# QAQC Flag Codes 'F_'
# (defined in downloaded .csv files and metadata on nerrscdmo.org)
#  1 = suspect data
# -2 = missing data
# -3 = data rejected due to QAQC
# -4 = outside low sensor range
# -5 = outside high sensor range

# DATA FILES FOR CLEANING = 'LC_WQ' , 'RC_WQ' , 'RC_MET'
 

# ~~~~~~~~~~~~
#   LC - WQ
# ~~~~~~~~~~~~
# Remove rows where value in F_ columns are equal to 1, -2, -3, -4, -5, for each
# of the water quality parameters (Temp, SpCond, Sal, DO, pH, Turb, ChlFlour).

# The subset() function removes these rows for each column (i.e. 'F_Temp',..) 
# "Clean" columns, excluding rows without those flags are saved as a new df

LC_noflag1 <- subset(LC_WQ, !(F_Temp %in% c("1","-2", "-3", "-4", "-5")))
LC_noflag2 <- subset(LC_noflag1, !(F_SpCond %in% c("1","-2", "-3", "-4", "-5")))
LC_noflag3 <- subset(LC_noflag2, !(F_Sal %in% c("1","-2", "-3", "-4", "-5")))
LC_noflag4 <- subset(LC_noflag3, !(F_DO_pct %in% c("1","-2", "-3", "-4", "-5")))
LC_noflag5 <- subset(LC_noflag4, !(F_DO_mgl %in% c("1","-2", "-3", "-4", "-5")))
LC_noflag6 <- subset(LC_noflag5, !(F_pH %in% c("1","-2", "-3", "-4", "-5")))
LC_noflag7 <- subset(LC_noflag6, !(F_Turb %in% c("1","-2", "-3", "-4", "-5")))
LC_noflag8 <- subset(LC_noflag7, !(F_ChlFluor %in% c("1","-2", "-3", "-4", "-5")))

View(LC_noflag8) # view df in R


#Clean up and remove F_ code columns
LC_WQ_clean <- LC_noflag8 %>% select(-one_of('F_Temp', 'F_SpCond', 'F_Sal', 
                                             'F_DO_pct','F_DO_mgl', 'F_pH', 
                                             'F_Turb', 'F_ChlFluor', 'F_Depth', 
                                             'cDepth', 'F_cDepth'))
View(LC_WQ_clean)

# Export "clean" LC water quality data as a .CSV file to work with 
write.csv(LC_clean, "/SWMP_R_Project/Output_Files/LC_WQ_Clean.csv")


# ~~~~~~~~~~~~
#   RC - WQ
# ~~~~~~~~~~~~
# Same process for LC was repeated for RC WQ parameters 

# remove rows where value in F_ columns are equal to 1, -2, -3, -4, -5
RC_noflag1 <- subset(RC_WQ, !(F_Temp %in% c("1","-2", "-3", "-4", "-5")))
RC_noflag2 <- subset(RC_noflag1, !(F_SpCond %in% c("1","-2", "-3", "-4", "-5")))
RC_noflag3 <- subset(RC_noflag2, !(F_Sal %in% c("1","-2", "-3", "-4", "-5")))
RC_noflag4 <- subset(RC_noflag3, !(F_DO_pct %in% c("1","-2", "-3", "-4", "-5")))
RC_noflag5 <- subset(RC_noflag4, !(F_DO_mgl %in% c("1","-2", "-3", "-4", "-5")))
RC_noflag6 <- subset(RC_noflag5, !(F_pH %in% c("1","-2", "-3", "-4", "-5")))
RC_noflag7 <- subset(RC_noflag6, !(F_Turb %in% c("1","-2", "-3", "-4", "-5")))
RC_noflag8 <- subset(RC_noflag7, !(F_ChlFluor %in% c("1","-2", "-3", "-4", "-5")))

View(RC_noflag8) 

#Clean up and remove F_ code columns
RC_WQ_clean <- RC_noflag8 %>% select(-one_of('F_Temp', 'F_SpCond', 'F_Sal', 
                                             'F_DO_pct','F_DO_mgl', 'F_pH', 
                                             'F_Turb', 'F_ChlFluor', 'F_Depth', 
                                             'cDepth', 'F_cDepth'))
View(RC_WQ_clean) # View new df in R

# Export "clean" LC water quality data as a .CSV file to work with 
write.csv(RC_WQ_clean, "/SWMP_R_Project/Output_Files/RC_WQ_Clean.csv")


# ~~~~~~~~~~~~
#   RC - MET
# ~~~~~~~~~~~~
# Same process was repeated for the MET parameters (WSpd, PAR, TotPrcp)

RC_MET_noflag1 <- subset(RC_MET, !(F_WSpd %in% c("1","-2", "-3", "-4", "-5")))
RC_MET_noflag2 <- subset(RC_MET_noflag1, !(F_TotPAR %in% c("1","-2", "-3", "-4", "-5")))
RC_MET_noflag3 <- subset(RC_MET_noflag2, !(F_TotPrcp %in% c("1","-2", "-3", "-4", "-5")))

RC_MET_clean <- RC_MET_noflag3 %>% select(-one_of('F_WSpd', 'F_TotPAR', 'F_TotPrcp'))

# Export "clean" LC water quality data as a .CSV file to work with 
write.csv(RC_MET_clean, "/SWMP_R_Project/Output_Files/RC_MET_Clean.csv")
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# COMPUTE DAILY, MONTHLY, YEARLY AVERAGE VALUES: 

# 'LC_WQ_Clean.csv' and 'RC_WQ_Clean.csv' data are in 15-min intervals.
# Need to compute the daily averages/means from the 15-min data.
# Because we are working with dates, need to install 'lubridate' package

# IMPORT DATA: 
#~~~~~~~~~~~~
# need to install 'readr' package to import and read CSV files in R
LC_WQ_Clean <- read_csv("Output_Files/LC_WQ_Clean.csv") #import file from folder
View(LC_WQ_Clean) # view df in R

RC_WQ_Clean <- read_csv("Output_Files/RC_WQ_Clean.csv") #import file from folder
View(RC_WQ_Clean) # view df in R


# Note, a new column was created from the 'DateTimeStamp' called 'Short_Date'
# where the 'DateTimeStamp' (MM/DD/YYYY HH:MM) was tab delineated and separated
# by spaces to create the 'Short_Date' column (MM/DD/YYYY)


#Selecting only parameters of interest and date/time, redefining df as '_15min'
LC_WQ_15min = subset(LC_WQ_Clean, 
                  select = c(DateTimeStamp,Short_Date,Temp, SpCond, Sal, DO_pct, 
                             DO_mgl, Depth, pH, Turb, ChlFluor))
View(LC_WQ_15min)

RC_WQ_15min = subset(RC_WQ_Clean, 
                  select = c(DateTimeStamp,Short_Date,Temp, SpCond, Sal, DO_pct,
                             DO_mgl, Depth, pH, Turb, ChlFluor))
View(RC_WQ_15min)

# Working Data --> LC_WQ_15min & RC_WQ_15min

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CALCULATE DAILY MEAN VALUES:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# template code below for average daily values:
# df %>% group_by(date) %>% summarize(mean_X = mean(X), na.rm =TRUE)

# LC WQ
daily_mean_WQ_LC <- LC_WQ_15min %>% group_by(Short_Date) %>% summarise(across(everything(), list(mean = mean), na.rm=TRUE))
View(daily_mean_LC)

# RC WQ
daily_mean_WQ_RC <- RC_WQ_15min %>% group_by(Short_Date) %>% summarise(across(everything(), list(mean = mean), na.rm=TRUE))
View(daily_mean_RC)

# RC MET 
as.Date(RC_MET_clean$Short_Date, "%m/%d/%Y") # make sure that date is in 'date' format

# MET data is handled slightly different from WQ because precipitation needs to
# be calculated as the sum of daily values not the 'mean' to get total daily precipitation. 
RC_MET_daily_prep <- RC_MET_clean %>% group_by(Short_Date) %>% summarize(across(c(WSpd, TotPAR, TotPrcp), 
                                                                                list(mean=mean, sum=sum), 
                                                                                na.rm=TRUE)) 
View(RC_MET_daily_prep) #View df in R

daily_mean_RC_MET <- RC_MET_daily_prep[, c('Short_Date', 'WSpd_mean', 'TotPAR_mean', 'TotPrcp_sum')]
View(daily_mean_RC_MET)

# option to export data frame to Excel
write.xlsx(daily_mean_RC_MET, "Output Files/RC_MET_daily.xlsx", sheetName = 'RC MET Daily Mean')


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CALCULATE MONTHLY & ANNUAL AVERAGES:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# You can calculate these easily from the daily averages in Excel using Pivot Tables
# if that is easier for you. If you would like to use R, below is example code
# adapted from materials developed by Earth Lab that will easily allow you to 
# achieve these calculations this as well.

# Link to the Earth Lab Lesson & Code:
# https://www.earthdatascience.org/courses/earth-analytics/time-series-data/summarize-time-series-by-month-in-r/
# All rights belong to Earth Lab Lesson for the code adapted below. 


#~~~~~~~~~~~
#  LC - WQ
#~~~~~~~~~~~
 
# extract just the month and year 
head(month(daily_mean_WQ_LC$Short_Date))
head(year(daily_mean_WQ_LC$Short_Date))

# add a “month” column to df
monthly_mean_WQ_LC <- daily_mean_WQ_LC %>% mutate(month = month(Short_Date), year = year(Short_Date))
View(monthly_mean_WQ_LC)

# calculate mean monthly values
LC_WQ_mean_monthly <- monthly_mean_LC %>% group_by(month, year) %>% summarise(across(everything(), list(mean = mean), na.rm=TRUE)) 
View(LC_WQ_mean_monthly)

# yearly mean
LC_WQ_mean_annual <- monthly_mean_WQ_LC %>% group_by(year) %>% summarize(across(everything(), list(mean = mean), na.rm=TRUE)) 
View(LC_WQ_mean_annual)

# EXPORT FILES TO EXCEL 
write.xlsx(LC_WQ_mean_monthly, "Output Files/LC_WQ_monthly.xlsx", sheetName = 'LC Monthly Mean')
write.xlsx(LC_WQ_mean_annual, "Output Files/LC_WQ_annual.xlsx", sheetName = 'LC Annual Mean')


#~~~~~~~~~~
#  RC - WQ
#~~~~~~~~~~

# extract just the month and year 
head(month(daily_mean_WQ_RC$Short_Date))
head(year(daily_mean_WQ_RC$Short_Date))

# add a “month” column to df
monthly_mean_WQ_RC <- daily_mean_WQ_RC %>% mutate(month = month(Short_Date), year = year(Short_Date))
View(monthly_mean_WQ_RC)

# calculate average monthly values
RC_WQ_mean_monthly <- monthly_mean_WQ_RC %>% group_by(month, year) %>% summarize(across(everything(), list(mean = mean), na.rm=TRUE)) 
View(RC_WQ_mean_monthly)

# yearly average
RC_WQ_mean_annual <- monthly_mean_WQ_RC %>% group_by(year) %>% summarize(across(everything(), list(mean = mean), na.rm=TRUE)) 
View(RC_WQ_mean_annual)


# EXPORT FILES TO EXCEL 
write.xlsx(as.data.frame(RC_WQ_mean_monthly), "Output Files/RC_WQ_monthly.xlsx", sheetName = 'RC Monthly Mean')
write.xlsx(RC_mean_annual, "Output Files/RC_WQ_annual", sheetName = 'RC Annual Mean')


#~~~~~~~~~~~~~~~~
#   RC - MET
#~~~~~~~~~~~~~~~~

# extract just the month and year 
head(month(daily_mean_RC_MET$Short_Date))
head(year(daily_mean_RC_MET$Short_Date))

# add a “month” column to df
monthly_mean_RC_MET <- daily_mean_RC_MET %>% mutate(month = month(Short_Date), year = year(Short_Date))
View(monthly_mean_RC_MET)

# calculate mean monthly values
RC_MET_mean_monthly <- monthly_mean_RC_MET %>% group_by(month, year) %>% summarize(across(everything(), list(mean = mean), na.rm=TRUE)) 
View(RC_MET_mean_monthly)

# yearly mean
RC_MET_mean_annual <- monthly_mean_RC_MET %>% group_by(year) %>% summarize(across(everything(), list(mean = mean), na.rm=TRUE)) 
View(RC_MET_mean_annual)


# EXPORT FILES TO EXCEL SHEETS
write.xlsx(as.data.frame(RC_MET_mean_monthly), "Output Files/RC_MET_monthly.xlsx", sheetName = 'RC MET Monthly Mean')
write.xlsx(RC_mean_annual, "Output Files/RC_MET_annual.xlsx", sheetName = 'RC MET Annual Mean')



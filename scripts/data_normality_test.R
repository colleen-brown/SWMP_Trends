# Linear regressions assume normality of the data. 
# The Shapiro Wilk test is applied to the processed SWMP data. If data were 
# non-normal they were log-transformed and tested again for normality. 

# Note, sample size must be between 3 and 5,000 to use 'shapiro.test()' function

#-------------------------------------------------------------------------------
# REQUIRED PACKAGES:
library(stats) # for shapiro.test()

#-------------------------------------------------------------------------------
# SHAPIRO-WILK NORMALITY TEST: 
# Examples shown below for SWMP nutrient parameters ('po4', 'nh3', 'no3')
# The same process was repeated for each 
# df = 'NUT_df', SWMP nutrient data (replace this with your df name)
# import your df from file

#~~~~~~
# PO4
#~~~~~~
#Normality test --> (result = NON-NORMAL)
shapiro.test(NUT_df$po4) # format, shapiro.test(df$parameter)

#LOG TRANSFORMATION --> (result = NORMAL)
# because data was non-normal, need to log transform po4 data. 

NUT_df$LOG_po4 = log(NUT_df$po4) # Created new column called 'LOG_po4'

View(NUT_df) # check df for new 'LOG_po4' column

shapiro.test(NUT_df$LOG_po4) # result = normal 

#~~~~~~
# NH3
#~~~~~~
# Same process repeated for NH3
# Select ID column and 'nh3' from df

#Normality test --> (result) NON-NORMAL
shapiro.test(NUT_df$nh3)

#LOG TRANSFORMATION --> (result) NORMAL
NUT_df$LOG_nh3 = log(NUT_df$nh3)
View(NUT_df)

shapiro.test(NUT_df$LOG_nh3)

#~~~~~~
# NO3
#~~~~~~
#Normality test --> (result) NON-NORMAL
shapiro.test(NUT_df$no2_no3)

#LOG TRANSFORMATION --> (result) NON-NORMAL
NUT_df$LOG_no3 = log(NUT_df$no2_no3)
View(NUT_df)

# Because NO3 data were non-normal after log transformation, need to use 
# non-parametric test.
#-------------------------------------------------------------------------------
# T-TESTS: tested the spatial heterogeneity of a SWMP parameter between 2 stations. 

# Shown below are examples on performing two t-tests:
# Student's t-test (normally distributed data) & Welch's t-test (non-normal data)
# RDocumentation: https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/t.test 

#-------------------------------------------------------------------------------
# REQUIRED PACKAGES:

library(stats) # for t.test()

#-------------------------------------------------------------------------------
# STUDENT'S T-TEST (NORMAL DATA): determined in 'data_normality_test.R'

# Example - PO4 
#~~~~~~~~~~~~~~~~
# df = NUT_df (SWMP nutrient df, you can replace this with your df of choice)
# 'LOG_po4' = normalized po4 data 
# 'station' = SWMP station (should be a column in your df)
t.test(LOG_po4 ~ station, NUT_df, var.equal= TRUE) # set to 'TRUE' for normal data (variances equal)


#-------------------------------------------------------------------------------
# WELCH'S T-TEST (NON-NORMAL DATA): determined in 'data_normality_test.R'

# Example - NO3 
#~~~~~~~~~~~~~~
# NO3 data were non-normal after log-transformation, so Welch's t-test is used
t.test(LOG_no3 ~ station, NUT_df, var.equal= FALSE) # set to 'FALSE' for non-normal data (variances not equal)

#-------------------------------------------------------------------------------


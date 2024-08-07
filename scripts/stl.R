#-------------------------------------------------------------------------------
# SEASONAL DECOMPOSITION OF TIME SERIES BY LOESS:
# run time series analysis for each SWMP parameter and station, as well as use 
# 'loess' to decompose the time series into seasonal, trend, and irregular components 

#-------------------------------------------------------------------------------
# REQUIRED PACKAGES:
# install.packages("stlplus")
library(stlplus)
library(readxl) # only needed if importing data from Excel

# RDocumentation: https://www.rdocumentation.org/packages/stlplus/versions/0.5.1
# Code modified from examples in document below:
# chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://cran.r-project.org/web/packages/stlplus/stlplus.pdf 

#-------------------------------------------------------------------------------
# IMPORTING NUTRIENT DATA FROM FILES:
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Note, df is monthly means
NUT_df <- read_excel("Input_Files/Nutrients_SWMP.xlsx", 
                                col_types = c("text", "date", "numeric", 
                                              "numeric", "numeric", "numeric"))
View(NUT_df) # View df 

# Separate data by station (RC)
RC_NUT <- NUT_df[1:240,c(1:6)]
View(RC_NUT)

# Separate data by station (LC)
LC_NUT <- NUT_df[241:480,c(1:6)]
View(LC_NUT)

#-------------------------------------------------------------------------------
#  EXAMPLE: PO4 
# ~~~~~~~~~~~~~~~~~
# Note, the process shown below was repeated for each SWMP parameter of interest
# Replace 'RC' and 'LC' with your SWMP stations IDs

# ///------///
#      RC
# ///------///

# WORKING DATA
RC_PO4_TS <- RC_NUT[,c(3)]
view(RC_PO4_TS)

# TIME SERIES TRENDS
#--------------------
# Run time series on RC PO4 data and analyze the attributes
RC_PO4.ts <- ts(RC_PO4_TS, start = 2002, frequency = 12) # 12 b/c data is monthly 
str(RC_PO4.ts)

# Plot time series monthly averages
plot(RC_PO4.ts, ylab="Monthly Average PO4 (mg/L)",main="Research Creek PO4 Trend")
plot(RC_PO4.ts,type="o",pch=20,cex=0.6,col="blue", ylab="Monthly Average PO4 (mg/L)",main="Research Creek PO4 Trend")
plot(RC_PO4.ts,type="h",col="blue",ylab="Monthly Average PO4 (mg/L)", main="Research Creek PO4 Trend")

#Summarize PO4 for each year separately for RC
RC_PO4.ts.f <- data.frame(RC_PO4.ts, year=as.numeric(floor(time(RC_PO4.ts))), 
                          cycle=as.numeric(cycle(RC_PO4.ts)), time=time(RC_PO4.ts))
str(RC_PO4.ts.f)

# Boxplot of [P04] values grouped by year at RC
boxplot(RC_PO4.ts.f$po4 ~RC_PO4.ts.f$year, main="Research Creek PO4 Annual Variation", ylab = "PO4 Concentration (mg/L)", xlab = "Year")

# Boxplot of [P04] values grouped by month at RC
boxplot(RC_PO4.ts.f$po4 ~ RC_PO4.ts.f$cycle, main="Research Creek PO4 Monthly Variation", xlab = "Month", ylab = "PO4 Concentration (mg/L)")


# SEASONAL DECOMPOSITION (STL)
#------------------------------
RC_PO4.stl <- stlplus(RC_PO4.ts[,1], n.p = 12, l.window = 13, s.window="periodic", 
                      t.window = 19, sub.labels=substr(month.name,1,3))

#Display decomposed series as a graph
plot(RC_PO4.stl, main="Research Creek PO4 Time Series Seasonal Decompostion", ylab="PO4 Concentration (mg/L)", xlab="Time (years)")
plot_seasonal(RC_PO4.stl) 
plot_trend(RC_PO4.stl) 
plot_cycle(RC_PO4.stl) 
plot_rembycycle(RC_PO4.stl)

# Post-trend smoothing 
RC_PO4.stl_smoothtest <- stlplus(RC_PO4.ts[,1], s.window = 25, t.window=85)
plot(RC_PO4.stl_smoothtest)


# ///------///
#      LC
# ///------///

# WORKING DATA
LC_PO4_TS <- LC_NUT[,c(3)]
view(LC_PO4_TS)

# TIME SERIES TRENDS
#--------------------
# Run time series on LC PO4 data and analyze the attributes
LC_PO4.ts <- ts(LC_PO4_TS, start = 2002, frequency = 12)
str(LC_PO4.ts)

# Plot time series monthly averages
plot(LC_PO4.ts, ylab="Monthly Average PO4 (mg/L)",main="Loosin Creek PO4 Trend")
plot(LC_PO4.ts,type="o",pch=20,cex=0.6,col="blue", ylab="Monthly Average PO4 (mg/L)",main="Loosin Creek PO4 Trend")
plot(LC_PO4.ts,type="h",col="blue",ylab="Monthly Average PO4 (mg/L)", main="Loosin Creek PO4 Trend")

#Summarize PO4 for each year separately for LC
LC_PO4.ts.f <- data.frame(LC_PO4.ts, year=as.numeric(floor(time(LC_PO4.ts))), 
                          cycle=as.numeric(cycle(LC_PO4.ts)), time=time(LC_PO4.ts))
str(LC_PO4.ts.f)

# Boxplot of [P04] values grouped by year at LC
boxplot(LC_PO4.ts.f$po4 ~LC_PO4.ts.f$year, main="Loosin Creek PO4 Annual Variation", ylab = "PO4 Concentration (mg/L)", xlab = "Year")

# Boxplot of [P04] values grouped by month at LC
boxplot(LC_PO4.ts.f$po4 ~ LC_PO4.ts.f$cycle, main="Loosin Creek PO4 Monthly Variation", xlab = "Month", ylab = "PO4 Concentration (mg/L)")


# SEASONAL DECOMPOSITION (STL)
#------------------------------
LC_PO4.stl <- stlplus(LC_PO4.ts[,1], n.p = 12, l.window = 13, s.window="periodic", 
                      t.window = 19, sub.labels=substr(month.name,1,3))

#Display decomposed series as a graph
plot(LC_PO4.stl, main="Loosin Creek PO4 Time Series Seasonal Decompostion", ylab="PO4 Concentration (mg/L)", xlab="Time (years)")
plot_seasonal(LC_PO4.stl) 
plot_trend(LC_PO4.stl) 
plot_cycle(LC_PO4.stl) 
plot_rembycycle(LC_PO4.stl)

# Post-trend smoothing 
LC_PO4.stl_smoothtest <- stlplus(LC_PO4.ts[,1], s.window = 25, t.window=85)
plot(LC_PO4.stl_smoothtest)

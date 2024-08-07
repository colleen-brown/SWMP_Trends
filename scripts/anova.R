#-------------------------------------------------------------------------------
# ANOVA TEST: tested the spatial heterogeneity between 3 or more stations

# In this example, significance of SWMP parameters (chl, temp, pH, turb, do_mgl, 
# sal, sp_cond) between the three SWMP stations (LC, RC, CMS) were tested individually

# Import composite df of SWMP data --> 'ICW' = df used in this example

#-------------------------------------------------------------------------------
# REQUIRED PACKAGES:
library(stats) # for 'aov()' and 'TukeyHSD()' functions

# RDocumentation:
# https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/aov 
# https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/TukeyHSD

#-------------------------------------------------------------------------------

# CHL
#~~~~~~
chl.anova <- aov(chl ~ station, data = ICW)
summary(chl.anova)

#significant so needed to run a post hoc test - Tukey 
TukeyHSD(chl.anova)

# TEMP
#~~~~~~
temp.anova <- aov(temp ~ station, data = ICW)
summary(temp.anova)

# pH
#~~~~~~
pH.anova <- aov(pH ~ station, data = ICW)
summary(pH.anova)
TukeyHSD(pH.anova)

# TURB
#~~~~~~
turb.anova <- aov(turb ~ station, data = ICW)
summary(turb.anova)
TukeyHSD(turb.anova)

# DO (mg/L)
#~~~~~~~~~~~
do_mgl.anova <- aov(do_mgl ~ station, data = ICW)
summary(do_mgl.anova)

# SALINITY
#~~~~~~~~~~~
salinity.anova <- aov(sal ~ station, data = ICW)
summary(salinity.anova)
TukeyHSD(salinity.anova)


# SP_COND
#~~~~~~~~~~~
sp_cond.anova <- aov(spcond ~ station, data = ICW)
summary(sp_cond.anova)
TukeyHSD(sp_cond.anova)

# SWMP_Trends
Data and code to reproduce the statistical analyses in "20-year water quality analysis reveals spatial variability and long-term changes at North Carolina’s Masonboro Island National Estuarine Research Reserve". 


## Overview
This repository includes the R code scripts used for preprocessing data and performing the statistical analyses in the study mentioned above. Brief descriptions of the R Scripts are outlined in the 'Script' section below. For more detailed information on the datasets and methodologies used, please see the study mentioned above.  


## Prerequisites
Before running the scripts in this repository, R Studio and the necessary R packages need to be installed. 

**Software**: R Studio (code was executed on R Studio Desktop 2020)

**R Packages**: see scripts below

**NERRS SWMP Data**: http://nerrscdmo.org/


## Scripts
Below are the R script names and the corresponding descriptions that can be used to replicate the data preprocessing and statistical analyses. Scripts can be found in the 'scripts' folder. 

**data_preprocessing.R**: Preprocessing SWMP data for statistical analyses. 

**data_normality_test.R**: Test normality (Shapiro Wilk test) and log-transform SWMP data prior to statistical analyses. 

**linear_regression.R**: Linear regression analysis to determine statistical significance and direction of trends over time. 

**anova.R**: Analysis of Variance (ANOVA) test and Tukey test. Tested spatial differences between three or more SWMP stations. 

**t_tests.R**: Student's t-test (normal data) and Welch's t-test (non-normal data). Tested spatial differences between two SWMP stations. 

**pca.R**: Principal component analysis (PCA) used to visualize relationships of all datasets.

**correlation_matrix.R**: Correlation matrix and significance test between variables for each SWMP station. 

**stl.R**: Seasonal-trend Decomposition of Time Series by Loess. 



## Attribution
If you use this methodology, be sure to properly cite the journal article above and the specific statistical methodologies and references therein. 

Note, the datasets used in this study and available here are collected by the National Estuarine Researach Reserve's System-wide Monitoring Program and can be freely and publicly accessed via http://nerrscdmo.org/. If you would like to reproduce these statistical analyses for a different National Estuarine Research Reserve, you can use that link to specify a particular station and date range. 

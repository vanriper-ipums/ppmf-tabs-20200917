# 00_load_ppmf_hu.r
# Author: David Van Riper
# Created: 2020-09-17
# 
# This script loads the ppmf housing unit microdata file into a data.table. The initial version of this script was 
# written to support the data released on 2020-09-17. 
# 


require(data.table)

#### Define constants #### 
# ppmf column types
ppmf_col_classes <- c("character", "character", "character", "character", "character", "character", "integer", "integer")

#### Load ppmf to a dt #### 
dt_u <- fread("data/ppmf_20200917u.csv.gz", sep = ",", colClasses = ppmf_col_classes)

# 00_load_ppmf_person.r
# Author: David Van Riper
# Created: 2020-09-17
# 
# This script loads the ppmf person microdata file into a data.table. The initial version of this script was 
# written to support the microdata released on 2020-09-17. 
# 
# This file has fewer attributes than the May 2020 version.

require(data.table)

#### Define constants #### 
# ppmf column types
ppmf_col_classes <- c("character", "character", "character", "character", "character", "character", "character", "character", "character", "character", "character")

#### Load ppmf to a dt #### 
dt <- fread("data/ppmf_20200917p.csv.gz", sep = ",", colClasses = ppmf_col_classes)

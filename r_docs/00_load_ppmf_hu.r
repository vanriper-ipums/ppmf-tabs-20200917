# 00_load_and_prepare_ppmf_hu.r
# Author: David Van Riper
# Created: 2020-09-17
# 
# This script loads the ppmf housing unit microdata file into a data.table. It changes the column headers to match the 2010 NHGIS values. 
# It also sums the occupied and vacant counts to generate the total HU count. The initial version of this script was 
# written to support the data released on 2020-09-17. 
# 
# The new column headers will be:
# 
# IFE001 - total housing units
# IFE002 - occupied units
# IFE003 - vacant units

require(data.table)

#### Define constants #### 
# ppmf column types
ppmf_col_classes <- c("character", "character", "character", "character", "character", "character", "integer", "integer")

cols_h3 <- c("TABBLKST", "TABBLKCOU", "TABTRACTCE", "TABBLK", "IFE001_dp", "IFE002_dp", "IFE003_dp")

#### Load ppmf to a dt #### 
dt_u <- fread("data/ppmf_20200917u.csv.gz", sep = ",", colClasses = ppmf_col_classes)

#### Rename columns to correct values #### 
setnames(dt_u, old = c("OCCUPIED_COUNT", "VACANT_COUNT"), new = c("IFE002_dp", "IFE003_dp"))

#### Compute total housing units #### 
dt_u[, IFE001_dp := IFE002_dp + IFE003_dp]

#### Drop extra columns and then set column order #### 
dt_u[, `:=` (VINTAGE = NULL, TABBLKGRPCE = NULL)]

#### Set correct column order #### 
setcolorder(dt_u, cols_h3)

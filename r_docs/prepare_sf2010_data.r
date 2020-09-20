# prepare_sf2010_data.r
# Author: David Van Riper
# Created: 2020-09-17
# 
# This script reads in NHGIS extracts, adds the _sf suffix to each variable, keeps required columns, and write out
# results to a new CSV (prepended with sf_). These sf_* files will be merged with the DP files and then written 
# out to a final dataset.
# 
# You must extract the ZIP files first to the /nhgis1364_csv/ folder before running 
# this script. 
# 
# This script is for the PL94 data, so it is only for 6 tables total.

require(data.table)

# file path
file_path <- "data/sf1/nhgis1364_csv/"

# gisjoin and name vectors 
constant_vars_from <- c("GISJOIN", "NAME")
constant_vars_to <- c("gisjoin", "name")

# generate list of CSVs in directory 
files <- list.files(file_path, pattern = "?csv")

for(i in files){
  dt <- fread(paste0(file_path, i))
  
  # set constant vars to new names
  setnames(dt, constant_vars_from, constant_vars_to)
  
  # Generate from and to variable names (starting with either H or I)
  temp_from <- grep("^[HI]", names(dt), value = TRUE)
  temp_to <- paste0(temp_from, "_sf")
  
  # setnames with vectors
  setnames(dt, temp_from, temp_to)
  
  # convert GISJOIN and NAME to lowercase 
  dt <- dt[, ]
  # create keep_cols vector
  keep_cols <- c("gisjoin", "name", temp_to)
  
  # Keep required fields in dt 
  dt <- dt[, ..keep_cols]
  
  fwrite(dt, paste0(file_path, "sf_", i))
  
}

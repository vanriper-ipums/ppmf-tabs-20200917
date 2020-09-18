# 06_compute_dummy_vars.r
# Author: David Van Riper
# Created: 2020-09-17
# 
# This script uses the header tibbles to compute values for the dummy variables in dt.

require(data.table)

#### Source the correct_column_order.r script #### 
source("r_docs/correct_column_order.r")

# #### P1. Total population #### 
# # This dummy is easiast to fill in - all records get a 1
# dt[, H7V001_dp := 1]
# 
# #### P3. Race7 #### 
# # Create vector with dummy var names 
# vars <- header_race7$header
# 
# # Add dummies to dt
# dt[, (vars) := 0]
# 
# # For each value in header_race7, set appropriate P var to 1 
# for(row in 1:nrow(header_race7)){
#   dt[, header_race7$header[row] := fifelse(race7 == header_race7$recode[row], 1, 0)]
# }
# 
# # Create block-level total pops
# block <- dt[, lapply(.SD, sum),
#             by = .(TABBLKST, TABBLKCOU, TABTRACTCE, TABBLK),
#             .SDcols = H7V001_dp:H7X008_dp]
# 
# # Add H7X001_dp, setting it equal to H7V001_dp
# block[, H7X001_dp := H7V001_dp]
# 
# # Re-order columns
# setcolorder(block, cols_p1_p3)
# 
# # Write out to CSV for further processing
# fwrite(block, file = "data/output/block_p1_p3.csv")
# 
# # Set H7V001_dp and vars to null to remove from dt
# dt[, H7V001_dp := NULL]
# dt[, (vars) := NULL]
# 
#### P4. Hispanic/Not Hispanic ####
# Create vector with dummy var names
vars <- header_hisp$header

# Add dummies to dt
dt[, (vars) := 0]

# For each value in header_hisp, set appropriate P var to 1
for(row in 1:nrow(header_hisp)){
  dt[, header_hisp$header[row] := fifelse(hisp == header_hisp$recode[row], 1, 0)]
}

# Create block-level total pops
block <- dt[, lapply(.SD, sum),
            by = .(TABBLKST, TABBLKCOU, TABTRACTCE, TABBLK),
            .SDcols = H7Y002_dp:H7Y003_dp]

# Create H7Y001_dp as sum of 2 and 3
block[, H7Y001_dp := H7Y002_dp + H7Y003_dp]

# Re-order columns
setcolorder(block, cols_p4)

# Write out to CSV for further processing
fwrite(block, file = "data/output/block_p4.csv")

# Set vars to null to remove from dt
dt[, (vars) := NULL]
# 
# #### P5. Hispanic by Race7 ####
# # Create vector with dummy var names 
# vars <- header_hisp_race7$header
# 
# # Add dummies to dt
# dt[, (vars) := 0]
# 
# # For each value in header_hisp_race7, set appropriate P var to 1
# for(row in 1:nrow(header_hisp_race7)){
#   dt[, header_hisp_race7$header[row] := fifelse((hisp == header_hisp_race7$hisp[row] & race7 == header_hisp_race7$race7[row]), 1, 0)]
# }
# 
# # Create block-level total pops
# block <- dt[, lapply(.SD, sum),
#             by = .(TABBLKST, TABBLKCOU, TABTRACTCE, TABBLK),
#             .SDcols = H7Z003_dp:H7Z017_dp]
# 
# # Create H71001_dp, and the non-hisp/hisp races tallied subtotals 
# block[, H7Z002_dp := H7Z003_dp + H7Z004_dp + H7Z005_dp + H7Z006_dp + H7Z007_dp + H7Z008_dp + H7Z009_dp]
# block[, H7Z010_dp := H7Z011_dp + H7Z012_dp + H7Z013_dp + H7Z014_dp + H7Z015_dp + H7Z016_dp + H7Z017_dp]
# block[, H7Z001_dp := H7Z002_dp + H7Z010_dp]
# 
# # Re-order columns
# setcolorder(block, cols_p5)
# 
# # Write out to CSV for further processing
# fwrite(block, file = "data/output/block_p5.csv")
# 
# # Set vars to null to remove from dt
# dt[, (vars) := NULL]
# 
# #### P6. Total races tallies by race ####
# # The recode file for this table essentially serves as the dummy vars for this table. Thus, 
# # we don't need to add and compute dummy vars. All we need to do is sum by block ID. 
# 
# # Create block-level counts
# block <- dt[, lapply(.SD, sum),
#             by = .(TABBLKST, TABBLKCOU, TABTRACTCE, TABBLK),
#             .SDcols = H70001_dp:H70007_dp]
# 
# # Re-order columns 
# setcolorder(block, cols_p6)
# 
# # Write out to CSV for further processing
# fwrite(block, file = "data/output/block_p6.csv")
# 
# #### P7. Total races tallies by race by Hispanic/Not Hispanic ####
# vars <- header_hisp_races_tallied$header
# 
# # Add dummies to dt
# dt[, (vars) := 0]
# 
# # # For each value in header_hisp_races_tallied, set appropriate header var to 1
# # use the get() function to convert values in header_hisp_races_tallied to variable names
# for(row in 1:nrow(header_hisp_races_tallied)){
#   dt[, header_hisp_races_tallied$header[row] := fifelse((get(header_hisp_races_tallied$raceTally_alone_combo[row]) == 1 & hisp == header_hisp_races_tallied$hisp[row]), 1, 0)]
# }
# 
# 
# # Create block-level counts
# block <- dt[, lapply(.SD, sum),
#             by = .(TABBLKST, TABBLKCOU, TABTRACTCE, TABBLK),
#             .SDcols = H71003_dp:H71015_dp]
# 
# # Create H71001_dp total races tallied, and the non-hisp/hisp races tallied subtotals 
# block[, H71002_dp := rowSums(.SD), .SDcols = H71003_dp:H71008_dp]
# block[, H71009_dp := rowSums(.SD), .SDcols = H71010_dp:H71015_dp]
# block[, H71001_dp := rowSums(.SD), .SDcols = H71002_dp:H71009_dp]
# 
# # Re-order columns 
# setcolorder(block, cols_p7)
# 
# # Write out to CSV for further processing
# fwrite(block, file = "data/output/block_p7.csv")
# 
# # Set vars to null to remove from dt
# dt[, (vars) := NULL]

#### P42. Major GQ type #### 
# Create vector with dummy var names 
vars <- header_major_gqtype$header

# Add dummies to dt
dt[, (vars) := 0]

# For each value in header_major_gqtype, set appropriate P var to 1
for(row in 1:nrow(header_major_gqtype)){
  dt[, header_major_gqtype$header[row] := fifelse(gqtypen == header_major_gqtype$recode[row], 1, 0)]
}

# Create block-level counts
block <- dt[, lapply(.SD, sum),
            by = .(TABBLKST, TABBLKCOU, TABTRACTCE, TABBLK),
            .SDcols = H80003_dp:H80010_dp]

# Generate correct subtotals and total pop in group quarters 
block[, H80002_dp := H80003_dp + H80004_dp + H80005_dp + H80006_dp]
block[, H80007_dp := H80008_dp + H80009_dp + H80010_dp]
block[, H80001_dp := H80002_dp + H80007_dp]

# Re-order columns 
setcolorder(block, cols_p42)

# Write out to CSV for further processing
fwrite(block, file = "data/output/block_p42.csv")

# Set vars to null to remove from dt
dt[, (vars) := NULL]

#### P8. Race63 ####
# Create vector with dummy var names 
vars <- header_race63$header

# Add dummies to dt
dt[, (vars) := 0] 

# For each value in header_race63, set appropriate P var to 1
for(row in 1:nrow(header_race63)){
  dt[, header_race63$header[row] := fifelse(race63 == header_race63$recode[row], 1, 0)]
}

# Create block-level total pops
block <- dt[, lapply(.SD, sum),
            by = .(TABBLKST, TABBLKCOU, TABTRACTCE, TABBLK),
            .SDcols = H72003_dp:H72071_dp]

# Calculate subtotals/totals
# Pop of one race
block[, H72002_dp := H72003_dp + H72004_dp + H72005_dp + H72006_dp + H72007_dp + H72008_dp]
# Pop of 6 races 
block[, H72070_dp := H72071_dp]
# Pop of 5 races
block[, H72063_dp := H72064_dp + H72065_dp + H72066_dp + H72067_dp + H72068_dp + H72069_dp]
# Pop of 4 races
block[, H72047_dp := H72048_dp + H72049_dp + H72050_dp + H72051_dp + H72052_dp + H72053_dp + H72054_dp +  H72055_dp + H72056_dp + H72057_dp + H72058_dp + H72059_dp + H72060_dp + H72061_dp + H72062_dp]
# Pop of 3 races 
block[, H72026_dp := H72027_dp + H72028_dp + H72029_dp + H72030_dp + H72031_dp + H72032_dp + H72033_dp +  H72034_dp + H72035_dp + H72036_dp + H72037_dp + H72038_dp + H72039_dp + H72040_dp + H72041_dp + H72042_dp + H72043_dp + H72044_dp + H72045_dp + H72046_dp]
# Pop of 2 races
block[, H72010_dp := H72011_dp + H72012_dp + H72013_dp + H72014_dp + H72015_dp + H72016_dp + H72017_dp +  H72018_dp + H72019_dp + H72020_dp + H72021_dp + H72022_dp + H72023_dp + H72024_dp + H72025_dp]
# Pop of 2 or more races
block[, H72009_dp := H72010_dp + H72026_dp + H72047_dp + H72063_dp + H72070_dp]
# Total popualtion 
block[, H72001_dp := H72002_dp + H72009_dp]

# Re-order columns 
setcolorder(block, cols_p8)

# Write out to CSV for further processing
fwrite(block, file = "data/output/block_p8.csv")

# Set vars to null to remove from dt
dt[, (vars) := NULL]

#### P9. Hispanic or Not Hispanic by Race63 #### 
# Create vector with dummy var names 
vars <- header_hisp_race63$header

# Add dummies to dt
dt[, (vars) := 0] 

# For each value in header_hisp_race63, set appropriate P var to 1
for(row in 1:nrow(header_hisp_race63)){
  dt[, header_hisp_race63$header[row] := fifelse((hisp == header_hisp_race63$hisp[row] & race63 == header_hisp_race63$race63[row]), 1, 0)]
}

# Create block-level total pops
block <- dt[, lapply(.SD, sum),
            by = .(TABBLKST, TABBLKCOU, TABTRACTCE, TABBLK),
            .SDcols = H73005_dp:H73073_dp]

# Subtotals and totals 
# Pop of 6 or more races 
block[, H73072_dp := H73073_dp]
# Pop of 5 races
block[, H73065_dp := H73066_dp + H73067_dp + H73068_dp + H73069_dp + H73070_dp + H73071_dp]
# Pop of 4 races
block[, H73049_dp := H73050_dp + H73051_dp + H73052_dp + H73053_dp + H73054_dp + H73055_dp + H73056_dp + H73057_dp + H73058_dp + H73059_dp + H73060_dp + H73061_dp + H73062_dp + H73063_dp + H73064_dp]
# Pop of 3 races
block[, H73028_dp := H73029_dp + H73030_dp + H73031_dp + H73032_dp + H73033_dp + H73034_dp + H73035_dp + H73036_dp + H73037_dp + H73038_dp + H73039_dp + H73040_dp + H73041_dp + H73042_dp + H73043_dp + H73044_dp + H73045_dp + H73046_dp + H73047_dp + H73048_dp]
# Pop of 2 races
block[, H73012_dp := H73013_dp + H73014_dp + H73015_dp + H73016_dp + H73017_dp + H73018_dp + H73019_dp + H73020_dp + H73021_dp + H73022_dp + H73023_dp + H73024_dp + H73025_dp + H73026_dp + H73027_dp]
# Pop of 2 or more races
block[, H73011_dp := H73012_dp + H73028_dp + H73049_dp + H73065_dp + H73072_dp]
# Pop of 1 race
block[, H73004_dp := H73005_dp + H73006_dp + H73007_dp + H73008_dp + H73009_dp + H73010_dp]
# Non-Hispanic total 
block[, H73003_dp := H73004_dp + H73011_dp]

# Re-order columns 
# setcolorder(block, cols_p9)

# Write out to CSV for further processing
fwrite(block, file = "data/output/block_p9.csv")

# Set vars to null to remove from dt
dt[, (vars) := NULL]

#### P10. Race63 by Voting age #### 
# Create vector with dummy var names 
vars <- header_race63_voting_age$header

# Add dummies to dt
dt[, (vars) := 0]

# For each value in header_race63_voting_age, set appropriate P var to 1
for(row in 1:nrow(header_race63_voting_age)){
  dt[, header_race63_voting_age$header[row] := fifelse((voting_age == header_race63_voting_age$voting_age[row] & race63 == header_hisp_race63_voting_age$race63[row]), 1, 0)]
}

# Create block-level total pops
block <- dt[, lapply(.SD, sum),
            by = .(TABBLKST, TABBLKCOU, TABTRACTCE, TABBLK),
            .SDcols = H74003_dp:H74071_dp]

# Calculate subtotals/totals
# Pop of one race
block[, H74002_dp := H74003_dp + H74004_dp + H74005_dp + H74006_dp + H74007_dp + H74008_dp]
# Pop of 6 races 
block[, H74070_dp := H74071_dp]
# Pop of 5 races
block[, H74063_dp := H74064_dp + H74065_dp + H74066_dp + H74067_dp + H74068_dp + H74069_dp]
# Pop of 4 races
block[, H74047_dp := H74048_dp + H74049_dp + H74050_dp + H74051_dp + H74052_dp + H74053_dp + H74054_dp +  H74055_dp + H74056_dp + H74057_dp + H74058_dp + H74059_dp + H74060_dp + H74061_dp + H74062_dp]
# Pop of 3 races 
block[, H74026_dp := H74027_dp + H74028_dp + H74029_dp + H74030_dp + H74031_dp + H74032_dp + H74033_dp +  H74034_dp + H74035_dp + H74036_dp + H74037_dp + H74038_dp + H74039_dp + H74040_dp + H74041_dp + H74042_dp + H74043_dp + H74044_dp + H74045_dp + H74046_dp]
# Pop of 2 races
block[, H74010_dp := H74011_dp + H74012_dp + H74013_dp + H74014_dp + H74015_dp + H74016_dp + H74017_dp +  H74018_dp + H74019_dp + H74020_dp + H74021_dp + H74022_dp + H74023_dp + H74024_dp + H74025_dp]
# Pop of 2 or more races
block[, H74009_dp := H74010_dp + H74026_dp + H74047_dp + H74063_dp + H74070_dp]
# Total population 18 years and older 
block[, H74001_dp := H74002_dp + H74009_dp]

# Re-order columns 
setcolorder(block, cols_p10)

# Write out to CSV for further processing
fwrite(block, file = "data/output/block_p10.csv")

# Set vars to null to remove from dt
dt[, (vars) := NULL]

#### P11. Hispanic or Not Hispanic by Race63 by Voting age #### 
# Create vector with dummy var names 
vars <- header_hisp_race63_voting_age$header

# Add dummies to dt
dt[, (vars) := 0]

# For each value in header_hisp_race63_voting_age, set appropriate P var to 1
for(row in 1:nrow(header_hisp_race63_voting_age)){
  dt[, header_hisp_race63_voting_age$header[row] := fifelse((voting_age == header_hisp_race63_voting_age$voting_age[row] & hisp == header_hisp_race63_voting_age$hisp[row] & race63 == header_hisp_race63_voting_age$race63[row]), 1, 0)]
}

# Create block-level total pops
block <- dt[, lapply(.SD, sum),
            by = .(TABBLKST, TABBLKCOU, TABTRACTCE, TABBLK),
            .SDcols = H75005_dp:H75073_dp]

# Subtotals and totals 
# Pop of 6 or more races 
block[, H75072_dp := H75073_dp]
# Pop of 5 races
block[, H75065_dp := H75066_dp + H75067_dp + H75068_dp + H75069_dp + H75070_dp + H75071_dp]
# Pop of 4 races
block[, H75049_dp := H75050_dp + H75051_dp + H75052_dp + H75053_dp + H75054_dp + H75055_dp + H75056_dp + H75057_dp + H75058_dp + H75059_dp + H75060_dp + H75061_dp + H75062_dp + H75063_dp + H75064_dp]
# Pop of 3 races
block[, H75028_dp := H75029_dp + H75030_dp + H75031_dp + H75032_dp + H75033_dp + H75034_dp + H75035_dp + H75036_dp + H75037_dp + H75038_dp + H75039_dp + H75040_dp + H75041_dp + H75042_dp + H75043_dp + H75044_dp + H75045_dp + H75046_dp + H75047_dp + H75048_dp]
# Pop of 2 races
block[, H75012_dp := H75013_dp + H75014_dp + H75015_dp + H75016_dp + H75017_dp + H75018_dp + H75019_dp + H75020_dp + H75021_dp + H75022_dp + H75023_dp + H75024_dp + H75025_dp + H75026_dp + H75027_dp]
# Pop of 2 or more races
block[, H75011_dp := H75012_dp + H75028_dp + H75049_dp + H75065_dp + H75072_dp]
# Pop of 1 race
block[, H75004_dp := H75005_dp + H75006_dp + H75007_dp + H75008_dp + H75009_dp + H75010_dp]
# Non-Hispanic total 
block[, H75003_dp := H75004_dp + H75011_dp]

# Write out to CSV for further processing
fwrite(block, file = "data/output/block_p11.csv")

# Set vars to null to remove from dt
dt[, (vars) := NULL]
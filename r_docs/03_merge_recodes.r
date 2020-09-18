# 03_merge_recodes.r 
# Author: David Van Riper
# Created: 2020-09-17
# 
# This script merges the recodes onto dt for the 2020-09-17 PPMF release.

require(data.table)

#### Set keys in dt and recodes ####
setkeyv(dt, c("CENHISP", "CENRACE", "VOTINGAGE", "GQTYPE"))
setkey(cenhisp, "CENHISP")
setkey(race63, "CENRACE")
setkey(voting_age, "VOTINGAGE")
setkey(gqtype, "GQTYPE")

#### Hispanic ####
dt <- cenhisp[dt, on = "CENHISP"]

#### Race63 ####
dt <- race63[dt, on = "CENRACE"]

#### Voting age #### 
dt <- voting_age[dt, on = "VOTINGAGE"]

#### Gqtype #### 
dt <- gqtype[dt, on = "GQTYPE"]

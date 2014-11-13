## See http://nicercode.github.io/blog/2013-07-09-modifying-data-with-lookup-tables/ for an explanation of the way this works.

library(devtools, quietly=TRUE)
source_gist("https://gist.github.com/dfalster/5589956")

allowedVars <- c("SiteName")
AllOtoDataSites<-addNewData("data/dataNew.csv", AllOtoData, allowedVars)

#Remove NAS
AllOtoDataSites<-na.omit(AllOtoDataSites)

# Tidy up
rm(allowedVars)
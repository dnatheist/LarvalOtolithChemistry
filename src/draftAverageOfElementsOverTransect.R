# Average Elemental Levels across Murray cod Larval Otoliths from  Murrumbidgee River

#This is an analysis of elements from Otoliths of Larvae from various sites in the Murrumbidgee River. It uses data from laser ablation mass spectrometry of otoliths extracted from drifting Murray cod larvae in the upper Murrumbidgee River in ACT Australia.

#It generates an average elemental transect for all otoliths combined.

#The following 2

library('ProjectTemplate') #All projectTemplates need this up front
load.project() #All projectTemplates need this up front


## Firstly Set a few options
options(width=200)
opts_chunk$set(echo=FALSE, warning=FALSE, message=FALSE)

## Load libraries that will be used.
require(psych)
require(ggplot2)
require(corrgram)
require(plyr)
require(lubridate)
require(mvoutlier)


unique(AllOtoData$LarvalID)


# so this is no sense at the moment as it fails..
# need to convert time to 0-100
# average each element level at that time
# plot

for (l in (unique(AllOtoData[,66]))){ # for each larval otolith
  within(AllOtoData,x<-which.min(AllOtoData[,1])
  if (AllOtoData$LarvalID==l) { AllOtoData$Time2<-AllOtoData$Time-AllOtoData[x,1]
  }
print(x)
print(l)
print(head(AllOtoData$Time2))  
}


for (k in 3:65){# For each element
  plot(AllOtoData[,1],AllOtoData[,k],xlab= "Time (seconds)",ylab=colnames(AllOtoData)[k])
  fit<- aov((AllOtoData[,k]) ~ OtoPart, data=AllOtoData)
  print(colnames(AllOtoData)[k])
  print(TukeyHSD(fit))
}




#The following 2 and 4 lines are needed if knitr is to work with ProjectTemplate.
#require(knitr)
#if (basename(getwd()) == "src") setwd("..") #needed to get knitr to work with project template
#library('ProjectTemplate') #All projectTemplates need this up front
#load.project() #All projectTemplates need this up front

#Set the path to data
fp<-file.path("C:\\Users\\s428825\\Google Drive\\PhD Analyses\\LarvalOtolithChemistry\\data\\")

#Get all the metadata .csv files in this directory.
metafiList<-dir("data", recursive = FALSE, pattern="^[m]",full.names = TRUE)
metafiDF<- lapply(metafiList, read.csv) #load all those files.
names(metafiDF) <- gsub(".*/(.*)\\..*", "\\1", metafiList)

#Get all the data .csv files in this directory.
datafiList<-dir("data", recursive = FALSE, pattern="^[A-H]",full.names = TRUE)
datafiDF<- lapply(datafiList, read.csv) #load all those files.
names(datafiDF) <- gsub(".*/(.*)\\..*", "\\1", datafiList)


AllOtoMetaData<-data.frame()

AllOtoData<-data.frame()

for (i in 1:length(datafiList)){
  x<-names(datafiDF[i])
  OtoMetaData<-read.csv(paste("C:\\Users\\s428825\\Google Drive\\PhD Analyses\\LarvalOtolithChemistry\\data\\",(paste("m",x,".csv",sep="")),sep="")) # find corresponding metafile (begins with m) and load it.
  OtoMetaData$note<-NULL #remove note field if there
  
  #```{r, "Calculate Edges and Centre portions to be used"}
  # Calculate Percentage of Otolith portion used for core and edge subsampling.
  #OtoMetaData$core<-30/(OtoMetaData$End-OtoMetaData$Start)*100
  #OtoMetaData$Edge1<-20/(OtoMetaData$End-OtoMetaData$Start)*100
  #OtoMetaData$Edge2<-20/(OtoMetaData$End-OtoMetaData$Start)*100
  # Need to decide what is best here.
  #was
  OtoMetaData$width<-OtoMetaData$End-OtoMetaData$Start
  OtoMetaData$coreStart<-OtoMetaData$CentreCore-15
  OtoMetaData$coreEnd<-OtoMetaData$CentreCore+15
  #OtoMetaData$coreWidth<-OtoMetaData$coreEnd-OtoMetaData$coreStart
  OtoMetaData$EndEdge1<-OtoMetaData$Start+20
  OtoMetaData$StartEdge2<-OtoMetaData$End-20
  #
  
  AllOtoMetaData<-rbind(AllOtoMetaData,OtoMetaData)
  
  #```
  OtoData<-read.csv(paste("C:\\Users\\s428825\\Google Drive\\PhD Analyses\\LarvalOtolithChemistry\\data\\",(paste(x,".csv",sep="")),sep="")) # load datafile.
  
##Remove some erroneous data

#Otolith 130 had errors because fluorine low warning during ablation. As a result erroneously high reading in middle of otolith. So delete those observations (from 1096 - 1120 milliseconds or so)
B3<-B3[!(B3$Time>=1096 & B3$Time<=1120.5),]

  #```{r, "For Each Otolith Assign Larval ID to Times in Otolith Chemistry Data table and Core, Edge1 or Edge2"}
  
  #Assign Larval ID to Times in Otolith Chemistry Data table
  OtoData$LarvalID      <- 0 #create a empty variable to store Larval ID in table
  OtoData$OtoPart      <- 0 #create a empty variable to store OtoPart in table 
  
  for (i in 1:nrow(OtoMetaData)){#For each Otolith range
    for(j in 1:nrow(OtoData)){#For each time slice
      if(OtoData[j,1]>OtoMetaData[i,2] & OtoData[j,1]<OtoMetaData[i,4]){#Lookup which Larval ID based on the time slice 
        OtoData[j,110]<-OtoMetaData[i,1] #Number that time slice with LarvaID
      }
      if(OtoData[j,1]>OtoMetaData[i,6] & OtoData[j,1]<OtoMetaData[i,7]){#Name that time slice with Core (Core)
        OtoData[j,111]<-"Core"  
      }
      if(OtoData[j,1]>OtoMetaData[i,2] & OtoData[j,1]<OtoMetaData[i,8]){#Name that time slice with Edge1 (E1)
        OtoData[j,111]<-"E1"
      }
      if(OtoData[j,1]>OtoMetaData[i,9] & OtoData[j,1]<OtoMetaData[i,4]){#Name that time slice with Edge2 (E2)
        OtoData[j,111]<-"E2"
      }
    }
  }
  AllOtoData<-rbind(AllOtoData,OtoData)
}

#Tidy up global environment

rm(OtoData)
rm(OtoMetaData)

metafiList2<-gsub(".*/(.*)\\..*", "\\1", metafiList)
rm(list=metafiList2)
datafiList2 <- gsub(".*/(.*)\\..*", "\\1", datafiList)
rm(list=datafiList2)

rm(metafiDF,metafiList,metafiList2)
rm(datafiDF,datafiList, datafiList2)
rm(fp)
rm(i)
rm(j)
rm(x)
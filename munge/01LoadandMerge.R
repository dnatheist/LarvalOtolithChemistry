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
  OtoMetaData$width<-OtoMetaData$End-OtoMetaData$Start
  OtoMetaData$coreStart<-OtoMetaData$CentreCore-15
  OtoMetaData$coreEnd<-OtoMetaData$CentreCore+15
  #OtoMetaData$coreWidth<-OtoMetaData$coreEnd-OtoMetaData$coreStart
  OtoMetaData$EndEdge1<-OtoMetaData$Start+20
  OtoMetaData$StartEdge2<-OtoMetaData$End-20
  
  AllOtoMetaData<-rbind(AllOtoMetaData,OtoMetaData)
  
  #```
  OtoData<-read.csv(paste("C:\\Users\\s428825\\Google Drive\\PhD Analyses\\LarvalOtolithChemistry\\data\\",(paste(x,".csv",sep="")),sep="")) # load datafile.
  
  
  #```{r, "For Each Otolith Assign Larval ID to Times in Otolith Chemistry Data table and Core, Edge1 or Edge2"}
  
  #Assign Larval ID to Times in Otolith Chemistry Data table
  OtoData$LarvalID      <- 0 #create a 0 variable to store Larval ID in table
  OtoData$OtoPart      <- 0 #create a 0 variable to store Larval ID in table 
  
  for (i in 1:nrow(OtoMetaData)){#For each Otolith range
    for(j in 1:nrow(OtoData)){#For each time slice
      if(OtoData[j,1]>OtoMetaData[i,2] & OtoData[j,1]<OtoMetaData[i,6]){#Lookup which Larval ID based on the time slice 
        OtoData[j,110]<-OtoMetaData[i,1] #Number that time slice with LarvaID
      }
      if(OtoData[j,1]>OtoMetaData[i,8] & OtoData[j,1]<OtoMetaData[i,9]){#Name that time slice with Core (Core)
        OtoData[j,111]<-"Core"  
      }
      if(OtoData[j,1]>OtoMetaData[i,2] & OtoData[j,1]<OtoMetaData[i,3]){#Name that time slice with Edge1 (E1)
        OtoData[j,111]<-"E1"
      }
      if(OtoData[j,1]>OtoMetaData[i,5] & OtoData[j,1]<OtoMetaData[i,6]){#Name that time slice with Edge2 (E2)
        OtoData[j,111]<-"E2"
      }
    }
  }
  AllOtoData<-rbind(AllOtoData,OtoData)
}


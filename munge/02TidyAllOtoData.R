#library('ProjectTemplate') #All projectTemplates need this up front
#load.project() #All projectTemplates need this up front

# This file tidies the AllOtoData file.

##Replace all entries less than 0 with 0 (ie: no negative data)
AllOtoData[AllOtoData < 0] <- 0

#Delete Rows with 0 in Larval Id variable as that is background from Mass spec or at least outside each otolith start and end times.

AllOtoData <-AllOtoData[!(AllOtoData[,110]==0),]

#Remove the Smoothed Data Block in middle of DF
AllOtoData<-AllOtoData[,c(-34:-77)]

#Make LarvalID a factor as we are not using it as a number
AllOtoData$LarvalID<-as.factor(AllOtoData$LarvalID)

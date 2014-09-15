#Draft code for extracting elemental averages and sd for each otolith core and shoving it in a datafram for export to database, for subsequent analysis with delta C delta N etc.

# Needs more checking but seems to be working.
# tested using:
#  df<-subset(AllOtoData, LarvalID =="71" & OtoPart == "Core")
#  length(df$Ba)
#  mean(df$Ba)


#Create empty dataframe for the use of, with element headings.
EachOtoData<-AllOtoData
EachOtoData<- EachOtoData[which(is.na(EachOtoData$text)), ]

for (l in (unique(AllOtoData[,66]))){ # for each larval otolith
  df<-subset(AllOtoData, LarvalID == l & OtoPart == "Core")
  EachOtoData[l,66] <- l
  for (e in 2:65){ # for each element
    mean<-mean(df[,e])
    #sd<-sd(df[,e])
    #n<-length(unique(AllOtoData[,66]))
    EachOtoData[l,e]<- mean 
    EachOtoData$OtoPart<-"Core"
    print(l)
    print(e)
    print(nrow(df))
    print(mean)
    print(sd)
    #  print(df)
  } 
}

print(EachOtoData)

write.csv(EachOtoData,file= ".\\reports\\ElemForEachOtolith.csv") # NB One "." and back slashes.

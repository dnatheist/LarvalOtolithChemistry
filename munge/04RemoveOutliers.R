## This is an arbitrary allocation of 'outliers
## It will need a method/reference

AllOtoDataSites<-subset(AllOtoDataSites,B<40)
AllOtoDataSites<-subset(AllOtoDataSites,Sr<5000)
AllOtoDataSites<-subset(AllOtoDataSites,Ba<300)
AllOtoDataSites<-subset(AllOtoDataSites,Ca<1000000)
AllOtoDataSites<-subset(AllOtoDataSites,Mg<1000)

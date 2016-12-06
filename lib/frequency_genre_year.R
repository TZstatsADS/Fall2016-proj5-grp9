s_genre_frequency<-matrix(ncol=5,nrow=20)
for (i in 2011:2015){
  s_genre_frequency[,i-2010]<-rbind(nrow(subset(Action,year==i)),nrow(subset(Adventure,year==i)),
                                    nrow(subset(Animation,year==i)),nrow(subset(Biography,year==i)),
                                    nrow(subset(Comedy,year==i)),nrow(subset(Crime,year==i)),
                                    nrow(subset(Documentary,year==i)),nrow(subset(Drama,year==i)),
                                    nrow(subset(Family,year==i)),nrow(subset(Fantasy,year==i)),
                                    nrow(subset(History,year==i)),nrow(subset(Horror,year==i)),
                                    nrow(subset(Music,year==i)),nrow(subset(Mystery,year==i)),
                                    nrow(subset(Romance,year==i)),nrow(subset(Sci_Fi,year==i)),
                                    nrow(subset(Sport,year==i)),nrow(subset(Thriller,year==i)),
                                    nrow(subset(War,year==i)),nrow(subset(Western,year==i)))
  
}

s_genre_frequency<-as.data.frame(s_genre_frequency)
rownames(s_genre_frequency)<-c("Action","Adventure","Animation","Biography","Comedy",
                               "Crime","Documentary","Drama","Family","Fantacy",
                               "History","Horror","Music","Mystery","Romance",
                               "Sci_Fi","Sport","Thriller","War","Western")
colnames(s_genre_frequency)<-c("2011","2012","2013","2014","2015")
write.csv(s_genre_frequency,file="/Users/Cristina/Desktop/16 Fall/5243 ADS/Project 5/data/s_genre_frequency.csv")

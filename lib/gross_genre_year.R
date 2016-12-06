# The gross in each genre from 2011~2015 #
# Action
Action<-vector()
for(i in 1:878){
  if(grepl("Action",all_info[i,4])){
    Action<-rbind(Action,all_info[i,])
  }
}
# Adventure
Adventure<-vector()
for(i in 1:878){
  if(grepl("Adventure",all_info[i,4])){
    Adventure<-rbind(Adventure,all_info[i,])
  }
}
# Animation
Animation<-vector()
for(i in 1:878){
  if(grepl("Animation",all_info[i,4])){
    Animation<-rbind(Animation,all_info[i,])
  }
}
# Biography
Biography<-vector()
for(i in 1:878){
  if(grepl("Biography",all_info[i,4])){
    Biography<-rbind(Biography,all_info[i,])
  }
}
# Comedy
Comedy<-vector()
for(i in 1:878){
  if(grepl("Comedy",all_info[i,4])){
    Comedy<-rbind(Comedy,all_info[i,])
  }
}
# Crime
Crime<-vector()
for(i in 1:878){
  if(grepl("Crime",all_info[i,4])){
    Crime<-rbind(Crime,all_info[i,])
  }
}
# Documentary
Documentary<-vector()
for(i in 1:878){
  if(grepl("Documentary",all_info[i,4])){
    Documentary<-rbind(Documentary,all_info[i,])
  }
}
# Drama
Drama<-vector()
for(i in 1:878){
  if(grepl("Drama",all_info[i,4])){
    Drama<-rbind(Drama,all_info[i,])
  }
}
# Family
Family<-vector()
for(i in 1:878){
  if(grepl("Family",all_info[i,4])){
    Family<-rbind(Family,all_info[i,])
  }
}
# Fantasy
Fantasy<-vector()
for(i in 1:878){
  if(grepl("Fantasy",all_info[i,4])){
    Fantasy<-rbind(Fantasy,all_info[i,])
  }
}
# Fil-Noir
Fil_Noir<-vector()
for(i in 1:878){
  if(grepl("Fil-Noir",all_info[i,4])){
    Fil_Noir<-rbind(Fil_Noir,all_info[i,])
  }
}
# History
History<-vector()
for(i in 1:878){
  if(grepl("History",all_info[i,4])){
    History<-rbind(History,all_info[i,])
  }
}
# Horror
Horror<-vector()
for(i in 1:878){
  if(grepl("Horror",all_info[i,4])){
    Horror<-rbind(Horror,all_info[i,])
  }
}
# Music
Music<-vector()
for(i in 1:878){
  if(grepl("Music",all_info[i,4])){
    Music<-rbind(Music,all_info[i,])
  }
}
# Musical
Musical<-vector()
for(i in 1:878){
  if(grepl("Musical",all_info[i,4])){
    Musical<-rbind(Musical,all_info[i,])
  }
}
Music<-rbind(Music,Musical)
# Mystery
Mystery<-vector()
for(i in 1:878){
  if(grepl("Mystery",all_info[i,4])){
    Mystery<-rbind(Mystery,all_info[i,])
  }
}
# Romance
Romance<-vector()
for(i in 1:878){
  if(grepl("Romance",all_info[i,4])){
    Romance<-rbind(Romance,all_info[i,])
  }
}
# Sci-Fi
Sci_Fi<-vector()
for(i in 1:878){
  if(grepl("Sci-Fi",all_info[i,4])){
    Sci_Fi<-rbind(Sci_Fi,all_info[i,])
  }
}
# Sport
Sport<-vector()
for(i in 1:878){
  if(grepl("Sport",all_info[i,4])){
    Sport<-rbind(Sport,all_info[i,])
  }
}
# Thriller
Thriller<-vector()
for(i in 1:878){
  if(grepl("Thriller",all_info[i,4])){
    Thriller<-rbind(Thriller,all_info[i,])
  }
}
# War
War<-vector()
for(i in 1:878){
  if(grepl("War",all_info[i,4])){
    War<-rbind(War,all_info[i,])
  }
}
# Western
Western<-vector()
for(i in 1:878){
  if(grepl("Western",all_info[i,4])){
    Western<-rbind(Western,all_info[i,])
  }
}

library(plotly)

s_genre_2011<-rbind(mean(subset(Action,year==2011)$gross),mean(subset(Adventure,year==2011)$gross),
                    mean(subset(Animation,year==2011)$gross),mean(subset(Biography,year==2011)$gross),
                    mean(subset(Comedy,year==2011)$gross),mean(subset(Crime,year==2011)$gross),
                    mean(subset(Documentary,year==2011)$gross),mean(subset(Drama,year==2011)$gross),
                    mean(subset(Family,year==2011)$gross),mean(subset(Fantasy,year==2011)$gross),
                    mean(subset(History,year==2011)$gross),mean(subset(Horror,year==2011)$gross),
                    mean(subset(Music,year==2011)$gross),mean(subset(Mystery,year==2011)$gross),
                    mean(subset(Romance,year==2011)$gross),mean(subset(Sci_Fi,year==2011)$gross),
                    mean(subset(Sport,year==2011)$gross),mean(subset(Thriller,year==2011)$gross),
                    mean(subset(War,year==2011)$gross),mean(subset(Western,year==2011)$gross))

s_genre_2012<-rbind(mean(subset(Action,year==2012)$gross),mean(subset(Adventure,year==2012)$gross),
                    mean(subset(Animation,year==2012)$gross),mean(subset(Biography,year==2012)$gross),
                    mean(subset(Comedy,year==2012)$gross),mean(subset(Crime,year==2012)$gross),
                    mean(subset(Documentary,year==2012)$gross),mean(subset(Drama,year==2012)$gross),
                    mean(subset(Family,year==2012)$gross),mean(subset(Fantasy,year==2012)$gross),
                    mean(subset(History,year==2012)$gross),mean(subset(Horror,year==2012)$gross),
                    mean(subset(Music,year==2012)$gross),mean(subset(Mystery,year==2012)$gross),
                    mean(subset(Romance,year==2012)$gross),mean(subset(Sci_Fi,year==2012)$gross),
                    mean(subset(Sport,year==2012)$gross),mean(subset(Thriller,year==2012)$gross),
                    mean(subset(War,year==2012)$gross),mean(subset(Western,year==2012)$gross))

s_genre_2013<-rbind(mean(subset(Action,year==2013)$gross),mean(subset(Adventure,year==2013)$gross),
                    mean(subset(Animation,year==2013)$gross),mean(subset(Biography,year==2013)$gross),
                    mean(subset(Comedy,year==2013)$gross),mean(subset(Crime,year==2013)$gross),
                    mean(subset(Documentary,year==2013)$gross),mean(subset(Drama,year==2013)$gross),
                    mean(subset(Family,year==2013)$gross),mean(subset(Fantasy,year==2013)$gross),
                    mean(subset(History,year==2013)$gross),mean(subset(Horror,year==2013)$gross),
                    mean(subset(Music,year==2013)$gross),mean(subset(Mystery,year==2013)$gross),
                    mean(subset(Romance,year==2013)$gross),mean(subset(Sci_Fi,year==2013)$gross),
                    mean(subset(Sport,year==2013)$gross),mean(subset(Thriller,year==2013)$gross),
                    mean(subset(War,year==2013)$gross),mean(subset(Western,year==2013)$gross))

s_genre_2014<-rbind(mean(subset(Action,year==2014)$gross),mean(subset(Adventure,year==2014)$gross),
                    mean(subset(Animation,year==2014)$gross),mean(subset(Biography,year==2014)$gross),
                    mean(subset(Comedy,year==2014)$gross),mean(subset(Crime,year==2014)$gross),
                    mean(subset(Documentary,year==2014)$gross),mean(subset(Drama,year==2014)$gross),
                    mean(subset(Family,year==2014)$gross),mean(subset(Fantasy,year==2014)$gross),
                    mean(subset(History,year==2014)$gross),mean(subset(Horror,year==2014)$gross),
                    mean(subset(Music,year==2014)$gross),mean(subset(Mystery,year==2014)$gross),
                    mean(subset(Romance,year==2014)$gross),mean(subset(Sci_Fi,year==2014)$gross),
                    mean(subset(Sport,year==2014)$gross),mean(subset(Thriller,year==2014)$gross),
                    mean(subset(War,year==2014)$gross),mean(subset(Western,year==2014)$gross))

s_genre_2015<-rbind(mean(subset(Action,year==2015)$gross),mean(subset(Adventure,year==2015)$gross),
                    mean(subset(Animation,year==2015)$gross),mean(subset(Biography,year==2015)$gross),
                    mean(subset(Comedy,year==2015)$gross),mean(subset(Crime,year==2015)$gross),
                    mean(subset(Documentary,year==2015)$gross),mean(subset(Drama,year==2015)$gross),
                    mean(subset(Family,year==2015)$gross),mean(subset(Fantasy,year==2015)$gross),
                    mean(subset(History,year==2015)$gross),mean(subset(Horror,year==2015)$gross),
                    mean(subset(Music,year==2015)$gross),mean(subset(Mystery,year==2015)$gross),
                    mean(subset(Romance,year==2015)$gross),mean(subset(Sci_Fi,year==2015)$gross),
                    mean(subset(Sport,year==2015)$gross),mean(subset(Thriller,year==2015)$gross),
                    mean(subset(War,year==2015)$gross),mean(subset(Western,year==2015)$gross))

s_gross_genre<-cbind(s_genre_2011,s_genre_2012,s_genre_2013,s_genre_2014,s_genre_2015)
s_gross_genre<-as.data.frame(s_gross_genre)
rownames(s_gross_genre)<-c("Action","Adventure","Animation","Biography","Comedy",
                           "Crime","Documentary","Drama","Family","Fantacy",
                           "History","Horror","Music","Mystery","Romance",
                           "Sci_Fi","Sport","Thriller","War","Western")
colnames(s_gross_genre)<-c("2011","2012","2013","2014","2015")
write.csv(s_gross_genre,file="/Users/Cristina/Desktop/16 Fall/5243 ADS/Project 5/data/s_gross_genre.csv")
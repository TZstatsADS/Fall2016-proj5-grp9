library(xlsx)
setwd("G:/Columbia/STAT GR5243/project05")
info_11<-read.csv("movie_2011_info.csv")
info_12<-read.xlsx("movie_2012_info.xlsx",1)
info_13<-read.csv("movie_2013_info.csv")
info_14<-read.csv("movie_2014_info.csv")
info_15<-read.xlsx("movie_2015_info.xlsx",1)
colnames(info_11)<-c("id","header","genre","director","star","gross")
colnames(info_12)<-c("id","header","genre","director","star","gross")
colnames(info_13)<-c("id","header","genre","director","star","gross")
colnames(info_14)<-c("id","header","genre","director","star","gross")
colnames(info_15)<-c("id","header","genre","director","star","gross")
info_11$gross<-gsub("M","",info_11$gross)
info_11$gross<-substring(info_11$gross,2)
info_11$gross<-as.numeric(info_11$gross)
info_11$gross<-info_11$gross*1000000
info_13$gross<-gsub("M","",info_13$gross)
info_13$gross<-substring(info_13$gross,2)
info_13$gross<-as.numeric(info_13$gross)
info_13$gross<-info_13$gross*1000000
info_14$gross<-gsub("M","",info_14$gross)
info_14$gross<-substring(info_14$gross,2)
info_14$gross<-as.numeric(info_14$gross)
info_14$gross<-info_14$gross*1000000
info_15$gross<-gsub("M","",info_15$gross)
info_15$gross<-substring(info_15$gross,2)
info_15$gross<-as.numeric(info_15$gross)
info_15$gross<-info_15$gross*1000000
info_11[,3]<-as.character(info_11[,3])
info_12[,3]<-as.character(info_12[,3])
info_13[,3]<-as.character(info_13[,3])
info_14[,3]<-as.character(info_14[,3])
info_15[,3]<-as.character(info_15[,3])
all_info<-rbind(info_11,info_12,info_13,info_14,info_15)

# Action
Action<-vector()
for(i in 1:878){
  if(grepl("Action",all_info[i,3])){
    Action<-rbind(Action,all_info[i,])
  }
}
# Adventure
Adventure<-vector()
for(i in 1:878){
  if(grepl("Adventure",all_info[i,3])){
    Adventure<-rbind(Adventure,all_info[i,])
  }
}
# Animation
Animation<-vector()
for(i in 1:878){
  if(grepl("Animation",all_info[i,3])){
    Animation<-rbind(Animation,all_info[i,])
  }
}
# Biography
Biography<-vector()
for(i in 1:878){
  if(grepl("Biography",all_info[i,3])){
    Biography<-rbind(Biography,all_info[i,])
  }
}
# Comedy
Comedy<-vector()
for(i in 1:878){
  if(grepl("Comedy",all_info[i,3])){
    Comedy<-rbind(Comedy,all_info[i,])
  }
}
# Crime
Crime<-vector()
for(i in 1:878){
  if(grepl("Crime",all_info[i,3])){
    Crime<-rbind(Crime,all_info[i,])
  }
}
# Documentary
Documentary<-vector()
for(i in 1:878){
  if(grepl("Documentary",all_info[i,3])){
    Documentary<-rbind(Documentary,all_info[i,])
  }
}
# Drama
Drama<-vector()
for(i in 1:878){
  if(grepl("Drama",all_info[i,3])){
    Drama<-rbind(Drama,all_info[i,])
  }
}
# Family
Family<-vector()
for(i in 1:878){
  if(grepl("Family",all_info[i,3])){
    Family<-rbind(Family,all_info[i,])
  }
}
# Fantasy
Fantasy<-vector()
for(i in 1:878){
  if(grepl("Fantasy",all_info[i,3])){
    Fantasy<-rbind(Fantasy,all_info[i,])
  }
}
# Fil-Noir
Fil_Noir<-vector()
for(i in 1:878){
  if(grepl("Fil-Noir",all_info[i,3])){
    Fil_Noir<-rbind(Fil_Noir,all_info[i,])
  }
}
# History
History<-vector()
for(i in 1:878){
  if(grepl("History",all_info[i,3])){
    History<-rbind(History,all_info[i,])
  }
}
# Horror
Horror<-vector()
for(i in 1:878){
  if(grepl("Horror",all_info[i,3])){
    Horror<-rbind(Horror,all_info[i,])
  }
}
# Music
Music<-vector()
for(i in 1:878){
  if(grepl("Music",all_info[i,3])){
    Music<-rbind(Music,all_info[i,])
  }
}
# Musical
Musical<-vector()
for(i in 1:878){
  if(grepl("Musical",all_info[i,3])){
    Musical<-rbind(Musical,all_info[i,])
  }
}
# Mystery
Mystery<-vector()
for(i in 1:878){
  if(grepl("Mystery",all_info[i,3])){
    Mystery<-rbind(Mystery,all_info[i,])
  }
}
# Romance
Romance<-vector()
for(i in 1:878){
  if(grepl("Romance",all_info[i,3])){
    Romance<-rbind(Romance,all_info[i,])
  }
}
# Sci-Fi
Sci_Fi<-vector()
for(i in 1:878){
  if(grepl("Sci-Fi",all_info[i,3])){
    Sci_Fi<-rbind(Sci_Fi,all_info[i,])
  }
}
# Sport
Sport<-vector()
for(i in 1:878){
  if(grepl("Sport",all_info[i,3])){
    Sport<-rbind(Sport,all_info[i,])
  }
}
# Thriller
Thriller<-vector()
for(i in 1:878){
  if(grepl("Thriller",all_info[i,3])){
    Thriller<-rbind(Thriller,all_info[i,])
  }
}
# War
War<-vector()
for(i in 1:878){
  if(grepl("War",all_info[i,3])){
    War<-rbind(War,all_info[i,])
  }
}
# Western
Western<-vector()
for(i in 1:878){
  if(grepl("Western",all_info[i,3])){
    Western<-rbind(Western,all_info[i,])
  }
}
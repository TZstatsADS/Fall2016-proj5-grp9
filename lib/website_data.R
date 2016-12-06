setwd("G:/Columbia/STAT GR5243/project05")
library(rvest)
rawdata_p1<-html("http://www.imdb.com/search/title?year=2011,2011&title_type=feature&sort=boxoffice_gross_us,desc&page=1&ref_=adv_prv")
info_p1<-rawdata_p1%>%html_nodes("p")%>%html_text()
info_p1<-info_p1[11:210]
header_p1<-rawdata_p1%>%html_nodes(".lister-item-header")%>%html_text()
header_p1_list<-list()
for(i in 1:50){
  header_p1_list[[i]]<-unlist(strsplit(header_p1[i],'\n'))
}
info_p1_list<-list()
for(i in 1:50){
  info_p1_list[[i]]<-c(unlist(strsplit(info_p1[4*i-3],'\n')),
                       unlist(strsplit(info_p1[4*i-2],'\n')),
                       unlist(strsplit(info_p1[4*i-1],'\n')),
                       unlist(strsplit(info_p1[4*i-0],'\n')))
}
header_p1_new<-vector()
for(i in 1:50){
  header_p1_new[i]<-substr(header_p1_list[[i]][4],5,nchar(header_p1_list[[i]][4]))
}
genre_p1_new<-vector()
for(i in 1:50){
  genre_p1_new[i]<-gsub(" ","",info_p1_list[[i]][7])
  genre_p1_new[i]<-gsub(",",", ",genre_p1_new[i])
}
info_p1_length<-vector()
for(i in 1:50){
  info_p1_length[i]<-length(info_p1_list[[i]])
}
director_p1_new<-vector()
for(i in 1:50){
  if(info_p1_list[[i]][14]!="             | "){
    director_p1_new[i]<-paste0(info_p1_list[[i]][13],info_p1_list[[i]][14])
  }
  else{
    director_p1_new[i]<-info_p1_list[[i]][13]
  }
}
star_p1_new<-vector()
for(i in 1:50){
  if(info_p1_list[[i]][16]=="    Stars:"){
    star_p1_new[i]<-paste0(info_p1_list[[i]][17],info_p1_list[[i]][18],info_p1_list[[i]][19],info_p1_list[[i]][20])
  }
  else{
    star_p1_new[i]<-paste0(info_p1_list[[i]][16],info_p1_list[[i]][17],info_p1_list[[i]][18],info_p1_list[[i]][19])
  }
}
gross_p1_new<-vector()
for(i in 1:50){
  if(info_p1_list[[i]][25]=="|                Gross:"){
    gross_p1_new[i]<-gsub(" ","",info_p1_list[[i]][26])
  }
  else{
    gross_p1_new[i]<-gsub(" ","",info_p1_list[[i]][25])
  }
}
all_p1<-cbind(header=header_p1_new,genre=genre_p1_new,director=director_p1_new,star=star_p1_new,gross=gross_p1_new)
rawdata_p2<-html("http://www.imdb.com/search/title?year=2011,2011&title_type=feature&sort=boxoffice_gross_us,desc&page=2&ref_=adv_nxt")
info_p2<-rawdata_p2%>%html_nodes("p")%>%html_text()
info_p2<-info_p2[11:210]
header_p2<-rawdata_p2%>%html_nodes(".lister-item-header")%>%html_text()
header_p2_list<-list()
for(i in 1:50){
  header_p2_list[[i]]<-unlist(strsplit(header_p2[i],'\n'))
}
info_p2_list<-list()
for(i in 1:50){
  info_p2_list[[i]]<-c(unlist(strsplit(info_p2[4*i-3],'\n')),
                       unlist(strsplit(info_p2[4*i-2],'\n')),
                       unlist(strsplit(info_p2[4*i-1],'\n')),
                       unlist(strsplit(info_p2[4*i-0],'\n')))
}
header_p2_new<-vector()
for(i in 1:50){
  header_p2_new[i]<-substr(header_p2_list[[i]][4],5,nchar(header_p2_list[[i]][4]))
}
genre_p2_new<-vector()
for(i in 1:50){
  genre_p2_new[i]<-gsub(" ","",info_p2_list[[i]][7])
  genre_p2_new[i]<-gsub(",",", ",genre_p2_new[i])
}
info_p2_length<-vector()
for(i in 1:50){
  info_p2_length[i]<-length(info_p2_list[[i]])
}
director_p2_new<-vector()
for(i in 1:50){
  if(info_p2_list[[i]][14]!="             | "&info_p2_list[[i]][15]!="             | "){
    director_p2_new[i]<-paste0(info_p2_list[[i]][13],info_p2_list[[i]][14],info_p2_list[[i]][15])
  }
  else{
    if(info_p2_list[[i]][14]!="             | "){
      director_p2_new[i]<-paste0(info_p2_list[[i]][13],info_p2_list[[i]][14])
    }
    else{
      director_p2_new[i]<-info_p2_list[[i]][13]
    }
  }
  
}
star_p2_new<-vector()
for(i in 1:50){
  if(info_p2_list[[i]][16]=="    Stars:"){
    star_p2_new[i]<-paste0(info_p2_list[[i]][17],info_p2_list[[i]][18],info_p2_list[[i]][19],info_p2_list[[i]][20])
  }
  else{
    if(info_p2_list[[i]][17]=="    Stars:"){
      star_p2_new[i]<-paste0(info_p2_list[[i]][18],info_p2_list[[i]][19],info_p2_list[[i]][20],info_p2_list[[i]][21])
    }
    else{
      star_p2_new[i]<-paste0(info_p2_list[[i]][16],info_p2_list[[i]][17],info_p2_list[[i]][18],info_p2_list[[i]][19])
    }
  }
}
gross_p2_new<-vector()
for(i in 1:50){
  if(info_p2_list[[i]][25]=="|                Gross:"){
    gross_p2_new[i]<-gsub(" ","",info_p2_list[[i]][26])
  }
  else{
    if(info_p2_list[[i]][26]=="|                Gross:"){
      gross_p2_new[i]<-gsub(" ","",info_p2_list[[i]][27])
    }
    else{
      gross_p2_new[i]<-gsub(" ","",info_p2_list[[i]][25])
    }
  }
}
all_p2<-cbind(header=header_p2_new,genre=genre_p2_new,director=director_p2_new,star=star_p2_new,gross=gross_p2_new)
rawdata_p3<-html("http://www.imdb.com/search/title?year=2011,2011&title_type=feature&sort=boxoffice_gross_us,desc&page=3&ref_=adv_nxt")
info_p3<-rawdata_p3%>%html_nodes("p")%>%html_text()
info_p3<-info_p3[11:210]
header_p3<-rawdata_p3%>%html_nodes(".lister-item-header")%>%html_text()
header_p3_list<-list()
for(i in 1:50){
  header_p3_list[[i]]<-unlist(strsplit(header_p3[i],'\n'))
}
info_p3_list<-list()
for(i in 1:50){
  info_p3_list[[i]]<-c(unlist(strsplit(info_p3[4*i-3],'\n')),
                       unlist(strsplit(info_p3[4*i-2],'\n')),
                       unlist(strsplit(info_p3[4*i-1],'\n')),
                       unlist(strsplit(info_p3[4*i-0],'\n')))
}
header_p3_new<-vector()
for(i in 1:50){
  header_p3_new[i]<-substr(header_p3_list[[i]][4],5,nchar(header_p3_list[[i]][4]))
}
genre_p3_new<-vector()
for(i in 1:50){
  if(info_p3_list[[i]][5]!="             | "){
    genre_p3_new[i]<-gsub(" ","",info_p3_list[[i]][4])
    genre_p3_new[i]<-gsub(",",", ",genre_p3_new[i])
  }
  else{
    genre_p3_new[i]<-gsub(" ","",info_p3_list[[i]][7])
    genre_p3_new[i]<-gsub(",",", ",genre_p3_new[i])
  }
}
info_p3_length<-vector()
for(i in 1:50){
  info_p3_length[i]<-length(info_p3_list[[i]])
}
director_p3_new<-vector()
for(i in 1:50){
  if(info_p3_list[[i]][14]!="             | "){
    if(info_p3_list[[i]][14]=="                8" ){
      director_p3_new[i]<-paste0(info_p3_list[[i]][10])
    }
    else{
      director_p3_new[i]<-paste0(info_p3_list[[i]][13],info_p3_list[[i]][14])
    }
  }
  else{
    director_p3_new[i]<-info_p3_list[[i]][13]
  }
}
star_p3_new<-vector()
for(i in 1:50){
  if(info_p3_list[[i]][16]=="    Stars:"){
    star_p3_new[i]<-paste0(info_p3_list[[i]][17],info_p3_list[[i]][18],info_p3_list[[i]][19],info_p3_list[[i]][20])
  }
  else{
    if(info_p3_list[[i]][16]=="                $5.74M"){
      star_p3_new[i]<-"NULL"
    }
    else{
      star_p3_new[i]<-paste0(info_p3_list[[i]][16],info_p3_list[[i]][17],info_p3_list[[i]][18],info_p3_list[[i]][19])
    }
  }
}
gross_p3_new<-vector()
for(i in 1:50){
  if(is.na(info_p3_list[[i]][25])){
    gross_p3_new[i]<-gsub(" ","",info_p3_list[[i]][16])
  }
  else{
    if(info_p3_list[[i]][25]=="|                Gross:"){
      gross_p3_new[i]<-gsub(" ","",info_p3_list[[i]][26])
    }
    else{
      gross_p3_new[i]<-gsub(" ","",info_p3_list[[i]][25])
    }
  }
}
all_p3<-cbind(header=header_p3_new,genre=genre_p3_new,director=director_p3_new,star=star_p3_new,gross=gross_p3_new)
rawdata_p4<-html("http://www.imdb.com/search/title?year=2011,2011&title_type=feature&sort=boxoffice_gross_us,desc&page=4&ref_=adv_nxt")
info_p4<-rawdata_p4%>%html_nodes("p")%>%html_text()
info_p4<-info_p4[11:210]
header_p4<-rawdata_p4%>%html_nodes(".lister-item-header")%>%html_text()
header_p4_list<-list()
for(i in 1:50){
  header_p4_list[[i]]<-unlist(strsplit(header_p4[i],'\n'))
}
info_p4_list<-list()
for(i in 1:50){
  info_p4_list[[i]]<-c(unlist(strsplit(info_p4[4*i-3],'\n')),
                       unlist(strsplit(info_p4[4*i-2],'\n')),
                       unlist(strsplit(info_p4[4*i-1],'\n')),
                       unlist(strsplit(info_p4[4*i-0],'\n')))
}
header_p4_new<-vector()
for(i in 1:50){
  header_p4_new[i]<-substr(header_p4_list[[i]][4],5,nchar(header_p4_list[[i]][4]))
}
genre_p4_new<-vector()
for(i in 1:50){
  if(info_p4_list[[i]][7]!="    "){
    genre_p4_new[i]<-gsub(" ","",info_p4_list[[i]][7])
    genre_p4_new[i]<-gsub(",",", ",genre_p4_new[i])
  }
  else{
    genre_p4_new[i]<-gsub(" ","",info_p4_list[[i]][6])
    genre_p4_new[i]<-gsub(",",", ",genre_p4_new[i])
  }
}
info_p4_length<-vector()
for(i in 1:50){
  info_p4_length[i]<-length(info_p4_list[[i]])
}
director_p4_new<-vector()
for(i in c(1:12,14:17,19:27,29:32,34:47,49:50)){
  if(info_p4_list[[i]][14]!="             | "){
    director_p4_new[i]<-paste0(info_p4_list[[i]][13],info_p4_list[[i]][14])
  }
  else{
    director_p4_new[i]<-info_p4_list[[i]][13]
  }
}
for(i in c(13,18,28,48)){
  if(info_p4_list[[i]][13]!="             | "){
    director_p4_new[i]<-paste0(info_p4_list[[i]][12],info_p4_list[[i]][13])
  }
  else{
    director_p4_new[i]<-info_p4_list[[i]][12]
  }
}
director_p4_new[33]<-"NULL"
star_p4_new<-vector()
for(i in c(1:12,14:17,19:27,29:32,34:47,49:50)){
  if(info_p4_list[[i]][16]=="    Stars:"){
    star_p4_new[i]<-paste0(info_p4_list[[i]][17],info_p4_list[[i]][18],info_p4_list[[i]][19],info_p4_list[[i]][20])
  }
  else{
    star_p4_new[i]<-paste0(info_p4_list[[i]][16],info_p4_list[[i]][17],info_p4_list[[i]][18],info_p4_list[[i]][19])
  }
}
for(i in c(13,18,28,48)){
  if(info_p4_list[[i]][15]=="    Stars:"){
    star_p4_new[i]<-paste0(info_p4_list[[i]][16],info_p4_list[[i]][17],info_p4_list[[i]][18],info_p4_list[[i]][19])
  }
  else{
    star_p4_new[i]<-paste0(info_p4_list[[i]][15],info_p4_list[[i]][16],info_p4_list[[i]][17],info_p4_list[[i]][18])
  }
}
star_p4_new[33]<-"NULL"
gross_p4_new<-vector()
for(i in c(1:12,14:17,19:27,29:32,34:47,49:50)){
  if(info_p4_list[[i]][25]=="|                Gross:"){
    gross_p4_new[i]<-gsub(" ","",info_p4_list[[i]][26])
  }
  else{
    gross_p4_new[i]<-gsub(" ","",info_p4_list[[i]][25])
  }
}
for(i in c(13,18,28,48)){
  if(info_p4_list[[i]][24]=="|                Gross:"){
    gross_p4_new[i]<-gsub(" ","",info_p4_list[[i]][25])
  }
  else{
    gross_p4_new[i]<-gsub(" ","",info_p4_list[[i]][24])
  }
}
gross_p4_new[33]<-gsub(" ","",info_p4_list[[33]][17])
all_p4<-cbind(header=header_p4_new,genre=genre_p4_new,director=director_p4_new,star=star_p4_new,gross=gross_p4_new)
all_info<-rbind(all_p1,all_p2,all_p3,all_p4)

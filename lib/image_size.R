library(imager)

setwd("G:/Columbia/STAT GR5243/project05/poster 2011 face")
file_list_11<-list.files()
img_size_11<-vector()
for(i in 1:length(file_list_11)){
  img_load_11<-load.image(file_list_11[i])
  img_size_11[i]<-dim(img_load_11)[1]*dim(img_load_11)[2]
}
img_cat_11<-substr(file_list_11,5,7)
img_num_11<-table(img_cat_11)
img_cum_11<-vector()
for(i in 1:length(img_num_11)){
  img_cum_11[i]<-sum(img_num_11[1:i])
}
img_area_11<-sum(img_size_11[1:4])
for(i in 2:length(img_cum_11)){
  img_area_11[i]<-sum(img_size_11[(img_cum_11[i-1]+1):img_cum_11[i]])
}
names(img_area_11)<-names(img_num_11)

setwd("G:/Columbia/STAT GR5243/project05/poster 2012 face")
file_list_12<-list.files()
img_size_12<-vector()
for(i in 1:length(file_list_12)){
  img_load_12<-load.image(file_list_12[i])
  img_size_12[i]<-dim(img_load_12)[1]*dim(img_load_12)[2]
}
img_cat_12<-substr(file_list_12,5,7)
img_num_12<-table(img_cat_12)
img_cum_12<-vector()
for(i in 1:length(img_num_12)){
  img_cum_12[i]<-sum(img_num_12[1:i])
}
img_area_12<-sum(img_size_12[1:4])
for(i in 2:length(img_cum_12)){
  img_area_12[i]<-sum(img_size_12[(img_cum_12[i-1]+1):img_cum_12[i]])
}
names(img_area_12)<-names(img_num_12)

setwd("G:/Columbia/STAT GR5243/project05/poster 2013 face")
file_list_13<-list.files()
img_size_13<-vector()
for(i in 1:length(file_list_13)){
  img_load_13<-load.image(file_list_13[i])
  img_size_13[i]<-dim(img_load_13)[1]*dim(img_load_13)[2]
}
img_cat_13<-substr(file_list_13,5,7)
img_num_13<-table(img_cat_13)
img_cum_13<-vector()
for(i in 1:length(img_num_13)){
  img_cum_13[i]<-sum(img_num_13[1:i])
}
img_area_13<-sum(img_size_13[1:2])
for(i in 2:length(img_cum_13)){
  img_area_13[i]<-sum(img_size_13[(img_cum_13[i-1]+1):img_cum_13[i]])
}
names(img_area_13)<-names(img_num_13)

setwd("G:/Columbia/STAT GR5243/project05/poster 2014 face")
file_list_14<-list.files()
img_size_14<-vector()
for(i in 1:length(file_list_14)){
  img_load_14<-load.image(file_list_14[i])
  img_size_14[i]<-dim(img_load_14)[1]*dim(img_load_14)[2]
}
img_cat_14<-substr(file_list_14,5,7)
img_num_14<-table(img_cat_14)
img_cum_14<-vector()
for(i in 1:length(img_num_14)){
  img_cum_14[i]<-sum(img_num_14[1:i])
}
img_area_14<-sum(img_size_14[1:1])
for(i in 2:length(img_cum_14)){
  img_area_14[i]<-sum(img_size_14[(img_cum_14[i-1]+1):img_cum_14[i]])
}
names(img_area_14)<-names(img_num_14)

setwd("G:/Columbia/STAT GR5243/project05/poster 2015 face")
file_list_15<-list.files()
img_size_15<-vector()
for(i in 1:length(file_list_15)){
  img_load_15<-load.image(file_list_15[i])
  img_size_15[i]<-dim(img_load_15)[1]*dim(img_load_15)[2]
}
img_cat_15<-substr(file_list_15,5,7)
img_num_15<-table(img_cat_15)
img_cum_15<-vector()
for(i in 1:length(img_num_15)){
  img_cum_15[i]<-sum(img_num_15[1:i])
}
img_area_15<-sum(img_size_15[1:2])
for(i in 2:length(img_cum_15)){
  img_area_15[i]<-sum(img_size_15[(img_cum_15[i-1]+1):img_cum_15[i]])
}
names(img_area_15)<-names(img_num_15)

img_area_11_df<-data.frame(cbind(img_area_11,img_num_11))
img_area_12_df<-data.frame(cbind(img_area_12,img_num_12))
img_area_13_df<-data.frame(cbind(img_area_13,img_num_13))
img_area_14_df<-data.frame(cbind(img_area_14,img_num_14))
img_area_15_df<-data.frame(cbind(img_area_15,img_num_15))

rownames(img_area_11_df)<-paste0("2011",rownames(img_area_11_df))
rownames(img_area_12_df)<-paste0("2012",rownames(img_area_12_df))
rownames(img_area_13_df)<-paste0("2013",rownames(img_area_13_df))
rownames(img_area_14_df)<-paste0("2014",rownames(img_area_14_df))
rownames(img_area_15_df)<-paste0("2015",rownames(img_area_15_df))

names_11<-c(2011001:2011195)
names_12<-c(2012001:2012130)
names_13<-c(2013001:2013166)
names_14<-c(2014001:2014200)
names_15<-c(2015001:2015188)

names_11_st<-vector()
for(i in 1:195){
  names_11_st<-c(names_11_st,toString(names_11[i]))
}
names_12_st<-vector()
for(i in 1:130){
  names_12_st<-c(names_12_st,toString(names_12[i]))
}
names_13_st<-vector()
for(i in 1:166){
  names_13_st<-c(names_13_st,toString(names_13[i]))
}
names_14_st<-vector()
for(i in 1:200){
  names_14_st<-c(names_14_st,toString(names_14[i]))
}
names_15_st<-vector()
for(i in 1:188){
  names_15_st<-c(names_15_st,toString(names_15[i]))
}

area_11<-vector()
num_11<-vector()
for(i in 1:195){
  if(is.element(names_11_st[i],rownames(img_area_11_df))){
    area_11[i]<-img_area_11_df[names_11_st[i],1]
    num_11[i]<-img_area_11_df[names_11_st[i],2]
  }
  else{
    area_11[i]<-0
    num_11[i]<-0
  }
}
area_12<-vector()
num_12<-vector()
for(i in 1:130){
  if(is.element(names_12_st[i],rownames(img_area_12_df))){
    area_12[i]<-img_area_12_df[names_12_st[i],1]
    num_12[i]<-img_area_12_df[names_12_st[i],2]
  }
  else{
    area_12[i]<-0
    num_12[i]<-0
  }
}
area_13<-vector()
num_13<-vector()
for(i in 1:166){
  if(is.element(names_13_st[i],rownames(img_area_13_df))){
    area_13[i]<-img_area_13_df[names_13_st[i],1]
    num_13[i]<-img_area_13_df[names_13_st[i],2]
  }
  else{
    area_13[i]<-0
    num_13[i]<-0
  }
}
area_14<-vector()
num_14<-vector()
for(i in 1:200){
  if(is.element(names_14_st[i],rownames(img_area_14_df))){
    area_14[i]<-img_area_14_df[names_14_st[i],1]
    num_14[i]<-img_area_14_df[names_14_st[i],2]
  }
  else{
    area_14[i]<-0
    num_14[i]<-0
  }
}
area_15<-vector()
num_15<-vector()
for(i in 1:188){
  if(is.element(names_15_st[i],rownames(img_area_15_df))){
    area_15[i]<-img_area_15_df[names_15_st[i],1]
    num_15[i]<-img_area_15_df[names_15_st[i],2]
  }
  else{
    area_15[i]<-0
    num_15[i]<-0
  }
}

names(area_11)<-names_11_st
names(area_12)<-names_12_st
names(area_13)<-names_13_st
names(area_14)<-names_14_st
names(area_15)<-names_15_st

names(num_11)<-names_11_st
names(num_12)<-names_12_st
names(num_13)<-names_13_st
names(num_14)<-names_14_st
names(num_15)<-names_15_st

area_11_df<-data.frame(cbind(area_11,num_11))
area_12_df<-data.frame(cbind(area_12,num_12))
area_13_df<-data.frame(cbind(area_13,num_13))
area_14_df<-data.frame(cbind(area_14,num_14))
area_15_df<-data.frame(cbind(area_15,num_15))

setwd("G:/Columbia/STAT GR5243/project05/poster 2011")
file_list_11_new<-list.files()
img_size_11_new<-vector()
for(i in 1:length(file_list_11_new)){
  img_load_11_new<-load.image(file_list_11_new[i])
  img_size_11_new[i]<-dim(img_load_11_new)[1]*dim(img_load_11_new)[2]
}
img_cat_11_new<-substr(file_list_11_new,5,7)
img_cat_11_new<-paste0("2011",img_cat_11_new)
names(img_size_11_new)<-img_cat_11_new
img_full_area_11_df<-data.frame(img_size_11_new)
full_area_11<-vector()
for(i in 1:195){
  if(is.element(names_11_st[i],rownames(img_full_area_11_df))){
    full_area_11[i]<-img_full_area_11_df[names_11_st[i],1]
  }
  else{
    full_area_11[i]<-0
  }
}

setwd("G:/Columbia/STAT GR5243/project05/poster 2012")
file_list_12_new<-list.files()
img_size_12_new<-vector()
for(i in 1:length(file_list_12_new)){
  img_load_12_new<-load.image(file_list_12_new[i])
  img_size_12_new[i]<-dim(img_load_12_new)[1]*dim(img_load_12_new)[2]
}
img_cat_12_new<-substr(file_list_12_new,5,7)
img_cat_12_new<-paste0("2012",img_cat_12_new)
names(img_size_12_new)<-img_cat_12_new
img_full_area_12_df<-data.frame(img_size_12_new)
full_area_12<-vector()
for(i in 1:130){
  if(is.element(names_12_st[i],rownames(img_full_area_12_df))){
    full_area_12[i]<-img_full_area_12_df[names_12_st[i],1]
  }
  else{
    full_area_12[i]<-0
  }
}

setwd("G:/Columbia/STAT GR5243/project05/poster 2013")
file_list_13_new<-list.files()
img_size_13_new<-vector()
for(i in 1:length(file_list_13_new)){
  img_load_13_new<-load.image(file_list_13_new[i])
  img_size_13_new[i]<-dim(img_load_13_new)[1]*dim(img_load_13_new)[2]
}
img_cat_13_new<-substr(file_list_13_new,5,7)
img_cat_13_new<-paste0("2013",img_cat_13_new)
names(img_size_13_new)<-img_cat_13_new
img_full_area_13_df<-data.frame(img_size_13_new)
full_area_13<-vector()
for(i in 1:166){
  if(is.element(names_13_st[i],rownames(img_full_area_13_df))){
    full_area_13[i]<-img_full_area_13_df[names_13_st[i],1]
  }
  else{
    full_area_13[i]<-0
  }
}

setwd("G:/Columbia/STAT GR5243/project05/poster 2014")
file_list_14_new<-list.files()
img_size_14_new<-vector()
for(i in 1:length(file_list_14_new)){
  img_load_14_new<-load.image(file_list_14_new[i])
  img_size_14_new[i]<-dim(img_load_14_new)[1]*dim(img_load_14_new)[2]
}
img_cat_14_new<-substr(file_list_14_new,5,7)
img_cat_14_new<-paste0("2014",img_cat_14_new)
names(img_size_14_new)<-img_cat_14_new
img_full_area_14_df<-data.frame(img_size_14_new)
full_area_14<-vector()
for(i in 1:200){
  if(is.element(names_14_st[i],rownames(img_full_area_14_df))){
    full_area_14[i]<-img_full_area_14_df[names_14_st[i],1]
  }
  else{
    full_area_14[i]<-0
  }
}

setwd("G:/Columbia/STAT GR5243/project05/poster 2015")
file_list_15_new<-list.files()
img_size_15_new<-vector()
for(i in 1:length(file_list_15_new)){
  img_load_15_new<-load.image(file_list_15_new[i])
  img_size_15_new[i]<-dim(img_load_15_new)[1]*dim(img_load_15_new)[2]
}
img_cat_15_new<-substr(file_list_15_new,5,7)
img_cat_15_new<-paste0("2015",img_cat_15_new)
names(img_size_15_new)<-img_cat_15_new
img_full_area_15_df<-data.frame(img_size_15_new)
full_area_15<-vector()
for(i in 1:188){
  if(is.element(names_15_st[i],rownames(img_full_area_15_df))){
    full_area_15[i]<-img_full_area_15_df[names_15_st[i],1]
  }
  else{
    full_area_15[i]<-0
  }
}
area_11_df<-cbind(area_11_df,full_area_11)
area_12_df<-cbind(area_12_df,full_area_12)
area_13_df<-cbind(area_13_df,full_area_13)
area_14_df<-cbind(area_14_df,full_area_14)
area_15_df<-cbind(area_15_df,full_area_15)

area_11_df$prop<-area_11_df$area_11/area_11_df$full_area_11
area_12_df$prop<-area_12_df$area_12/area_12_df$full_area_12
area_13_df$prop<-area_13_df$area_13/area_13_df$full_area_13
area_14_df$prop<-area_14_df$area_14/area_14_df$full_area_14
area_15_df$prop<-area_15_df$area_15/area_15_df$full_area_15

colnames(area_11_df)<-c("face_area","num_face","full_area","proportion")
colnames(area_12_df)<-c("face_area","num_face","full_area","proportion")
colnames(area_13_df)<-c("face_area","num_face","full_area","proportion")
colnames(area_14_df)<-c("face_area","num_face","full_area","proportion")
colnames(area_15_df)<-c("face_area","num_face","full_area","proportion")

area_df<-rbind(area_11_df,area_12_df,area_13_df,area_14_df,area_15_df)

setwd("G:/Columbia/STAT GR5243/project05")
write.csv(area_df,file="face area machine.csv")

load("./data/rgb_feature_mat.RData")
info<-read.csv("/Users/yueqizhang/Documents/w5243 ads/project5/data/movie_info_all_updated.csv")
boxoff<-info[,7]
label<-rep("1M",878)
label[which(boxoff>=100000000)]<-"100M"
label[which(boxoff>=10000000 & boxoff<100000000)]<-"10M"
label<-as.factor(label)
genre<-c("Action","Adventure","Animation","Biography","Comedy","Crime","Documentary","Drama","Family","Fantasy","History","Horror","Music","Mystery","Romance","Sci-Fi","Sport","Thriller","War","Western")
Genre<-matrix(0,nrow = 878,ncol = length(genre))
for (i in 1:length(genre)){
  order<-which(grepl(genre[i],info[,4])==1)
  Genre[order,i]<-1
}
allinfo_pre<-cbind(Genre,info[,13],info[,17],rgb_feature_mat)
library(randomForest)
accuracy<-c()
for (i in 1:5){
  order<-sample(878,100)
  boxoff_rf_cv<-randomForest(allinfo_pre[-order,],label[-order],importance=T,proximity=T)
  boxoff_rf_cv_pre<-predict(boxoff_rf_cv,allinfo_pre[order,])
  accuracy1<-sum(label[order]==boxoff_rf_cv_pre)/100
  accuracy<-c(accuracy,accuracy1)
}
accuracy<-mean(accuracy)


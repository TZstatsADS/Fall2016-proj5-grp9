setwd("G:/Columbia/STAT GR5243/project05/poster")

RGBFreq<-function(genre){
  library(EBImage)
  
  id<-paste0(genre$id,".jpg")
  
  nR<-10
  nG<-8
  nB<-10
  
  rBin<-seq(0,1,length.out=nR)
  gBin<-seq(0,1,length.out=nG)
  bBin<-seq(0,1,length.out=nB)
  
  color_data<-matrix(0,nrow(genre),nR*nG*nB)
  rgb_frq<-vector()
  
  for(i in 1:nrow(genre)){
    mat<-imageData(readImage(id[i]))
    freq_rgb<-as.data.frame(table(factor(findInterval(mat[,,1],rBin),levels=1:nR),
                                  factor(findInterval(mat[,,2],gBin),levels=1:nG),
                                  factor(findInterval(mat[,,3],bBin),levels=1:nB)))
    rgb_frq<-cbind(rgb_frq,freq_rgb$Freq)
    rgb_feature<-as.numeric(freq_rgb$Freq)/(ncol(mat)*nrow(mat))
    color_data[i,]<-rgb_feature
  }
  
  return(list(freq_mat=rgb_frq,feat_mat=color_data))
  #return(color_data)
}

action_data<-RGBFreq(Action)
adventure_data<-RGBFreq(Adventure)
animation_data<-RGBFreq(Animation)
biography_data<-RGBFreq(Biography)
comedy_data<-RGBFreq(Comedy)
crime_data<-RGBFreq(Crime)
documentary_data<-RGBFreq(Documentary)
drama_data<-RGBFreq(Drama)
family_data<-RGBFreq(Family)
fantasy_data<-RGBFreq(Fantasy)
history_data<-RGBFreq(History)
horror_data<-RGBFreq(Horror)
music_data<-RGBFreq(Music)
musical_data<-RGBFreq(Musical)
mystery_data<-RGBFreq(Mystery)
romance_data<-RGBFreq(Romance)
sci_fi_data<-RGBFreq(Sci_Fi)
sport_data<-RGBFreq(Sport)
thriller_data<-RGBFreq(Thriller)
war_data<-RGBFreq(War)
western_data<-RGBFreq(Western)

rgb_feature_mat<-RGBFreq(all_info)

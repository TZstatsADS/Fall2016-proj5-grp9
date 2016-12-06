### Genre prediction ###



## user input ##
setwd("/Users/YaqingXie/Desktop/3-Applied Data Science/Fall2016-proj5-grp9")
test_id <- "2011001.jpg" # name of a new poster, must end with .jpg



## extract features in caffe, save in ./data/test_features.csv ##



## read data ##
# note, in both train_image and test_image, there should be three default pictures
# so that Caffe can output the right features
train_genre <- read.csv("./data/train_genre.csv")
#train_features <- fread(".data/train_features.csv")
#train_features <- train_features[4:nrow(train_features),2:ncol(train_features)]
#save(train_id, file="train_id.rdata")
load("./data/train_id.rdata")
test_features <- fread("./data/test_features.csv")
test_features <- as.data.frame(test_features)
test_features <- test_features[test_features[1]==test_id,]
test_features <- test_features[2:ncol(test_features)]



## find columns in training data that have constant values (otherwise PCA won't work) ##
#ab_columns <- list()
#for(i in 1:64896){
#  if(sum(train_features[,i]==train_features[1,i])==878){
#    ab_columns <- c(ab_columns, i)
#  }
#}
#all_columns <- c(1:64896)
#remained_columns <- setdiff(all_columns, ab_columns)
#save(remained_columns, file = "remained_columns.rdata")
#train_features <- train_features[remained_columns]
load("./data/remained_columns.rdata")
test_features <- test_features[remained_columns]



## train PCA model using training data ##
#pca <- prcomp(train_features, center=TRUE, scale=TRUE)
#cumdev <- cumsum(pca$sdev) / sum(pca$sdev)
#cumdev_0.9 <- cumdev <= 0.9
#n <- sum(cumdev_0.9) + 1
#pca_matrix <- pca$rotation[,1:n]
#save(pca_matrix, file ="pca_matrix.rda")
#train_features_pca <- as.matrix(train_features) %*% pca_matrix
#save(train_features_pca, file="train_features_pca.rdata")
load("./data/train_features_pca.rdata")
load("./data/pca_matrix.rda")
test_features_pca <- as.matrix(test_features) %*% pca_matrix
train_features_pca <- as.data.frame(train_features_pca)
test_features_pca <- as.data.frame(test_features_pca)



## knn - train model ##
library(FNN)
knn_predict <- function(k, train, test, train_id, test_id){
  knn_model <- knn(train, test, factor(rep(0,nrow(train))), k, algorithm="cover_tree")
  indices <- attr(knn_model, "nn.index")
  n <- 0
  for(i in c(1:nrow(test))){
    id <- as.character(test_id[i])
    neighbors_k <- indices[i,]
    neighbor_genres <- vector()
    neighbors_ids <- vector()
    for(j in c(1:k)){
      neighbor <- neighbors_k[j]
      neighbor_id <- as.character(train_id[neighbor, ]) 
      neighbors_ids <- c(neighbors_ids, neighbor_id)
      temp <- as.character(train_genre$Category[which(train_genre$ID == neighbor_id)])
      temp <- strsplit(temp, ", ")[[1]]
      neighbor_genres <- c(neighbor_genres, temp)
    }
    predict_genres <- names(sort(table(neighbor_genres), decreasing = TRUE)[1:2])
    real_genres <- as.character(train_genre$Category[which(train_genre$ID == id)])
    real_genres <- strsplit(real_genres, ", ")[[1]]
    if(length(intersect(predict_genres, real_genres))>=1){
      n <- n + 1
    }
  }
  accuracy <- n/100
  return(list(accuracy, predict_genres, neighbors_ids))
}

#calculate_accuracy <- function(n){
#  set.seed(n)
#  subset <- sample(878, 100)
#  subset_train <- train_features_pca[-subset,]
#  subset_test <- train_features_pca[subset,]
#  subset_train_id <- train_id[-subset,]
#  subset_test_id <- train_id[subset,]
#  
#  accuracy_12 <- knn_predict(12, subset_train, subset_test, subset_train_id, subset_test_id)
#  accuracy_13 <- knn_predict(13, subset_train, subset_test, subset_train_id, subset_test_id)
#  accuracy_14 <- knn_predict(14, subset_train, subset_test, subset_train_id, subset_test_id)
#  accuracy_15 <- knn_predict(15, subset_train, subset_test, subset_train_id, subset_test_id)
#  accuracy_16 <- knn_predict(16, subset_train, subset_test, subset_train_id, subset_test_id)
#  accuracy_17 <- knn_predict(17, subset_train, subset_test, subset_train_id, subset_test_id)
#  accuracy_18 <- knn_predict(18, subset_train, subset_test, subset_train_id, subset_test_id)
#  accuracy_19 <- knn_predict(19, subset_train, subset_test, subset_train_id, subset_test_id)
#  accuracy_20 <- knn_predict(20, subset_train, subset_test, subset_train_id, subset_test_id)
#  
#  return(c(accuracy_12[[1]], accuracy_13[[1]], accuracy_14[[1]], accuracy_15[[1]], accuracy_16[[1]], 
#           accuracy_17[[1]], accuracy_18[[1]], accuracy_19[[1]], accuracy_20[[1]]))
#}
#
#a1 <- calculate_accuracy(0)
#a2 <- calculate_accuracy(3)
#a3 <- calculate_accuracy(6)
#a4 <- calculate_accuracy(9)
#a5 <- calculate_accuracy(12)
#
#a_k12 <- mean(c(a1[1], a2[1], a3[1], a4[1], a5[1]))
#a_k13 <- mean(c(a1[2], a2[2], a3[2], a4[2], a5[2]))
#a_k14 <- mean(c(a1[3], a2[3], a3[3], a4[3], a5[3]))
#a_k15 <- mean(c(a1[4], a2[4], a3[4], a4[4], a5[4]))
#a_k16 <- mean(c(a1[5], a2[5], a3[5], a4[5], a5[5]))
#a_k17 <- mean(c(a1[6], a2[6], a3[6], a4[6], a5[6]))
#a_k18 <- mean(c(a1[7], a2[7], a3[7], a4[7], a5[7]))
#a_k19 <- mean(c(a1[8], a2[8], a3[8], a4[8], a5[8]))
#a_k20 <- mean(c(a1[9], a2[9], a3[9], a4[9], a5[9]))
#k <- c(12, 13, 14, 15, 16, 17)[which.max(c(a_k12, a_k13, a_k14, a_k15, a_k16, a_k17,
#                                           a_k18, a_k19, a_k20))]
k <- 13
#accuracy <- max(c(a_k12, a_k13, a_k14, a_k15, a_k16, a_k17, a_k18, a_k19, a_k20))
accuracy <- 0.678
  
  

## predict and make recommendation ##
test_predict <- knn_predict(k, train_features_pca, test_features_pca, train_id, test_id)
test_genres <- test_predict[[2]]
save(test_genres, file = paste(outputpath, substring('./output/', test_id, 1, nchar(test_id)-4),"_genres.rdata", sep=""))
test_neighbors <- test_predict[[3]]
save(test_neighbors, file=paste(outputpath, substring('./output/', 1, nchar(test_id)-4),"_neighbors.rdata", sep=""))

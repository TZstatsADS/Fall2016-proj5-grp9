library(RColorBrewer)
library(shiny)
library(ggplot2)
library(plotly)
library(randomForest)
library(imager)
library(EBImage)
library(reshape2)

wd<-"/Users/YaqingXie/Desktop/3-Applied Data Science/Fall2016-proj5-grp9"
setwd(wd)

y_path<-c("C:/Users/Qing/Documents/GitHub/Fall2016-proj5-grp9")
x_path<-"/Users/YaqingXie/Desktop/3-Applied Data Science/Fall2016-proj5-grp9"
y_path = x_path
z_path= x_path
z_info<-read.csv("./data/movie_info_all.csv")
load("./data/boxoff_rf.RData")
load("./data/rgb_feature_mat.RData")
z_path<-"/Users/YaqingXie/Desktop/3-Applied Data Science/Fall2016-proj5-grp9"

s_gross_genre<-read.csv("./data/s_gross_genre.csv")
s_gross_genre<-as.data.frame(s_gross_genre)
s_genre_frequency<-read.csv("./data/s_genre_frequency.csv")
s_proportion_number<-read.csv("./data/s_proportion_number.csv")
s_face_number<-read.csv("./data/s_face_number.csv")
s_rgb<-read.csv("./data/rgb_genre.csv")

shinyServer(function(input, output) {
 
  s_dataSwitch<-reactive({
    s_year_num<-switch(input$s_movie_year,
                       "2011"=2,
                       "2012"=3,
                       "2013"=4,
                       "2014"=5,
                       "2015"=6)
    s_dat_<- data.frame(genre = factor(s_gross_genre$genre),
                        gross = s_gross_genre[,s_year_num],
                        number=c(rep(1:20)))
    return(s_dat_)
  })
  s_dataSwitch2<-reactive({
    s_year_num<-switch(input$s_movie_year2,
                       "2011"=2,
                       "2012"=3,
                       "2013"=4,
                       "2014"=5,
                       "2015"=6)
    s_<- data.frame( genre = s_genre_frequency$X,
                     frequency= s_gross_genre[,s_year_num])
    return(s_)
  })
  s_dataSwitch4<-reactive({
    s_year_num<-switch(input$s_movie_year4,
                       "2011"=2,
                       "2012"=3,
                       "2013"=4,
                       "2014"=5,
                       "2015"=6)
    s_face<- data.frame(genre=s_proportion_number$X,
                        face=s_proportion_number[,s_year_num],
                        proportion=s_face_number[,s_year_num])
    
    return(s_face)
  })
  s_dataSwitch3<-reactive({
    s_genre<-switch(input$s_movie_genre3,
                    "Action"=1,
                    "Adventure"=2,
                    "Animation"=3,
                    "Biography"=4,
                    "Comedy"=5,
                    "Crime"=6,
                    "Documentary"=7,
                    "Drama"=8,
                    "Family"=9,
                    "Fantacy"=10,
                    "History"=11,
                    "Horror"=12,
                    "Music"=13,
                    "Mystery"=14,
                    "Romance"=15,
                    "Sci-Fi"=16,
                    "Sport"=17,
                    "Thriller"=18,
                    "War"=19,
                    "Western"=20)
    s_rgb_year<-data.frame(value= s_rgb[,s_genre+1],color=s_rgb$color)
    s_color<- cbind(melt(s_rgb_year, id="color"),genre=rep(s_genre,1600))
    return(s_color)
  })
  
  output$ggBarPlotA<-renderPlotly({
    ggplot(data=s_dataSwitch(), aes(y=gross/1000000,x=number,fill=genre)) +
      geom_bar(colour="black",stat="identity")+ggtitle("Yearly Gross in Each Genre")+
      theme(axis.text=element_text(size=14),
            legend.key=element_rect(fill="black"),
            legend.background=element_rect(fill="grey40"),legend.position=c(0.14,0.80),
            panel.grid.major=element_line(colour="grey40"),panel.grid.minor=element_blank(),
            panel.background=element_rect(fill="black"),
            plot.background=element_rect(fill="black",colour="black",size=2))
    ggplotly()
  })
  
  colors<-c('rgb(211,94,96)', 'rgb(128,133,133)', 'rgb(144,103,167)', 'rgb(171,104,87)', 'rgb(114,147,203)',
            'rgb(68, 32, 109)','rgb(69, 131, 173)','rgb(119, 175, 139)','rgb(142, 103, 19)','rgb(56, 15, 26)',
            'rgb(191, 89, 21)','rgb(165, 173, 6)','rgb(86, 104, 84)','rgb(104, 82, 88)','rgb(80, 48, 130)',
            'rgb(23, 165, 165)','rgb(67, 128, 165)','rgb(96, 95, 173)','rgb(120, 130, 15)','rgb(32, 35, 1)')
  
  output$ggPiePlot<-renderPlotly({
    plot_ly(s_dataSwitch2(), labels = ~genre, values = ~frequency, type = 'pie',
            textposition = 'inside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'text',
            text = ~paste("#", frequency, 'times'),
            marker = list(colors = colors,
                          line = list(color = '#FFFFFF', width = 1)),
            #The 'pull' attribute can also be used to create space between the sectors
            showlegend = FALSE) %>%
      layout(title = 'Number of Movies (Gross > 1 million) in different genre',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             plot_bgcolor="black",paper_bgcolor="black")
  })
  colors2<-c("blue","red","yellow","green","purple","pink","orange")
  output$ggLinePlot<-renderPlotly({
    ggplot(data=s_dataSwitch3(),aes(x=color,y=value,col=input$s_movie_genre3)) +
      geom_line(col=sample(colors2,1))+ggtitle("RGB Plot")+
      theme(axis.text=element_text(size=14),legend.key=element_rect(fill="black"),
            legend.background=element_rect(fill="grey40"),legend.position=c(0.14,0.80),
            panel.grid.major=element_line(colour="grey40"),panel.grid.minor=element_blank(),
            panel.background=element_rect(fill="black"),
            plot.background=element_rect(fill="black",colour="black",size=2))
    ggplotly()
  })
  
  
  output$BubblePlot<-renderPlotly({
    plot_ly(s_dataSwitch4(),x= ~proportion,y= ~face,type = 'scatter', mode = 'markers',
            size = ~proportion, color= ~factor(genre), colors = 'Paired',
            sizes = c(10, 50),
            marker = list(symbol = 'circle', sizemode = 'diameter',
                          line = list(width = 2, color = '#FFFFFF')),
            text = ~paste('nuber', proportion, '<br>proportion:', face)) %>%
      layout(title = 'Face number v. Face proportion',
             xaxis = list(title = 'face number of poster',
                          gridcolor = 'rgb(255, 255, 255)',
                          range = c(0, 0.15),
                          type = 'log',
                          zerolinewidth = 1,
                          ticklen = 5,
                          gridwidth = 2),
             yaxis = list(title = 'face proportion in each poster',
                          gridcolor = 'rgb(255, 255, 255)',
                          range = c(1, 10),
                          zerolinewidth = 1,
                          ticklen = 5,
                          gridwith = 2),
             paper_bgcolor = "black",
             plot_bgcolor = "black")
  })
  #################################End of EDA###################################

  x_values <- reactiveValues(x_tops = NULL, x_similars = NULL, x_sim_genre = NULL,
                             x_progress = NULL, x_predict_table = NULL)
  
  output$x_image <- renderImage({
    x_fileName <- input$x_file$name
    x_fileImage <- paste0(wd , '/data/test_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=260))
  }, deleteFile = FALSE)
  
  observeEvent(input$x_start_analyze, {
    x_values$x_progress <- 'Analyzing...'
    x_values$x_predict_table <- NULL
    source('./lib/genre_prediction.R')
    library(data.table)
    genre_predict(input$x_file$name)
    x_values$x_progress <- 'Done!'
    x_fileName <- input$x_file$name
    x_fileName <- substring(x_fileName, 1, nchar(x_fileName)-4)
    x_fileName <- paste0('./output/', x_fileName, '_genres.csv')
    x_pre_genres <- read.csv(x_fileName)
    x_values$x_predict_table <- cbind(as.matrix(c('Most likely', 'Second likely')), 
                                      as.matrix(c(as.character(x_pre_genres[1,2]), 
                                                  as.character(x_pre_genres[2,2]))))
    colnames(x_values$x_predict_table) <- c('Likelyhood', 'Genre')
  })
  
  output$x_analyze_progess <- renderText({
    return(x_values$x_progress)
  })
  
  output$x_prediction <- renderTable({
    return(x_values$x_predict_table)
  })
  
  observeEvent(input$x_find_similar, {
    x_values$x_similars <- NULL
    x_fileName <- input$x_file$name
    x_fileName <- substring(x_fileName, 1, nchar(x_fileName)-4)
    x_fileName <- paste0('./output/', x_fileName, '_neighbors.csv')
    x_similars <- read.csv(x_fileName)
    if(input$x_file$name == x_similars$x[1:6]){
      x_values$x_similars <- x_similars$x[2:7]
    }
    else{
      x_values$x_similars <- x_similars$x[1:6]
    }
  })
  
  output$x_sim1_genres <- renderText({
    x_sim1_id <- as.character(x_values$x_similars[1])
    x_all_movie <- read.csv('./data/movie_info_all.csv')
    x_genres <- x_all_movie[x_all_movie$id==substring(x_sim1_id,1,nchar(x_sim1_id)-4), 4]
    return(as.character(x_genres)[1])
  })
  
  output$x_sim2_genres <- renderText({
    x_sim2_id <- as.character(x_values$x_similars[2])
    x_all_movie <- read.csv('./data/movie_info_all.csv')
    x_genres <- x_all_movie[x_all_movie$id==substring(x_sim2_id,1,nchar(x_sim2_id)-4), 4]
    return(as.character(x_genres)[1])
  })
  
  output$x_sim3_genres <- renderText({
    x_sim3_id <- as.character(x_values$x_similars[3])
    x_all_movie <- read.csv('./data/movie_info_all.csv')
    x_genres <- x_all_movie[x_all_movie$id==substring(x_sim3_id,1,nchar(x_sim3_id)-4), 4]
    return(as.character(x_genres)[1])
  })
  
  output$x_sim4_genres <- renderText({
    x_sim4_id <- as.character(x_values$x_similars[4])
    x_all_movie <- read.csv('./data/movie_info_all.csv')
    x_genres <- x_all_movie[x_all_movie$id==substring(x_sim4_id,1,nchar(x_sim4_id)-4), 4]
    return(as.character(x_genres)[1])
  })
  
  output$x_sim5_genres <- renderText({
    x_sim5_id <- as.character(x_values$x_similars[5])
    x_all_movie <- read.csv('./data/movie_info_all.csv')
    x_genres <- x_all_movie[x_all_movie$id==substring(x_sim5_id,1,nchar(x_sim5_id)-4), 4]
    return(as.character(x_genres)[1])
  })
  
  output$x_sim6_genres <- renderText({
    x_sim6_id <- as.character(x_values$x_similars[6])
    x_all_movie <- read.csv('./data/movie_info_all.csv')
    x_genres <- x_all_movie[x_all_movie$id==substring(x_sim6_id,1,nchar(x_sim6_id)-4), 4]
    return(as.character(x_genres)[1])
  })
  
  output$x_sim1 <-renderImage({
    x_fileName <- paste0(x_values$x_similars[1])
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  output$x_sim2 <-renderImage({
    x_fileName <- paste0(x_values$x_similars[2])
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  output$x_sim3 <-renderImage({
    x_fileName <- paste0(x_values$x_similars[3])
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  output$x_sim4 <-renderImage({
    x_fileName <- paste0(x_values$x_similars[4])
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  output$x_sim5 <-renderImage({
    x_fileName <- paste0(x_values$x_similars[5])
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  output$x_sim6 <-renderImage({
    x_fileName <- paste0(x_values$x_similars[6])
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  observeEvent(input$x_find_recommend, {
    x_values$x_tops < NULL
    x_all_movie <- read.csv('./data/movie_info_all.csv')
    x_genre1 <- input$x_select_genre1
    x_genre2 <- input$x_select_genre2
    x_tops <- x_all_movie[intersect(grep(x_genre1, x_all_movie$genre),
                                    grep(x_genre2, x_all_movie$genre)), ]
    x_tops <- x_tops[order(-x_tops[,6]),]
    x_values$x_tops <- x_tops$id[1:6]
  })
  
  output$x_rec1 <-renderImage({
    x_fileName <- paste0(x_values$x_tops[1], '.jpg')
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  output$x_rec2 <-renderImage({
    x_fileName <- paste0(x_values$x_tops[2], '.jpg')
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  output$x_rec3 <-renderImage({
    x_fileName <- paste0(x_values$x_tops[3], '.jpg')
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  output$x_rec4 <-renderImage({
    x_fileName <- paste0(x_values$x_tops[4], '.jpg')
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  output$x_rec5 <-renderImage({
    x_fileName <- paste0(x_values$x_tops[5], '.jpg')
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  output$x_rec6 <-renderImage({
    x_fileName <- paste0(x_values$x_tops[6], '.jpg')
    x_fileImage <- paste0(wd , '/data/train_images/', x_fileName)
    return(list(src=x_fileImage, contentType="image/jpg",alt="No Image", width=200))
  }, deleteFile = FALSE)
  
  
  
#########QING YIN AND SEN ZHUANG#########FACE AND TEXT DETECTION###################
  face_det<-reactive({
    #inFile<-input$y_files
    #python.load('Face_Rec.py')
    #python.assign("path_read",inFile$datapath)
    #python.assign("path_write","./output/image_write_test")
    #python.assign("path_write_face","./output/image_write_face_test")
    #python.assign("path_haar","./lib")
    #python.exec('face_det(path_haar,path_read,path_write,path_write_face)')
  })
  face_size<-reactive({
    inFile<-input$y_files
    file_list<-list.files(paste0(y_path,"/output/image_write_face_test"))
    img_size<-vector()
    for(i in 1:length(file_list)){
      img_load<-load.image(paste0(y_path,"/output/image_write_face_test/",file_list[i]))
      img_size[i]<-dim(img_load)[1]*dim(img_load)[2]
    }
    img_cat<-substr(file_list,1,11)
    img_num<-table(img_cat)
    img_cum<-vector()
    for(i in 1:length(img_num)){
      img_cum[i]<-sum(img_num[1:i])
    }
    img_area<-sum(img_size[1:img_cum[1]])
    for(i in 2:length(img_cum)){
      img_area[i]<-sum(img_size[(img_cum[i-1]+1):img_cum[i]])
    }
    names(img_area)<-names(img_num)
    img_area_df<-data.frame(cbind(img_area,img_num))
    file_list_new<-list.files(paste0(y_path,"/output/image_write_test"))
    img_size_new<-vector()
    for(i in 1:length(file_list_new)){
      img_load_new<-load.image(paste0(y_path,"/output/image_write_test/",file_list_new[i]))
      img_size_new[i]<-dim(img_load_new)[1]*dim(img_load_new)[2]
    }
    names(img_size_new)<-substr(file_list_new,7,17)
    img_area_df<-cbind(img_area_df,img_size_new)
    img_area_df$prop<-img_area/img_size_new
    img_area_df<-cbind(id=rownames(img_area_df),img_area_df)
    colnames(img_area_df)<-c("id","face_area","num_face","full_area","proportion")
    img_area_cur<-img_area_df[img_area_df$id==inFile$name,]
    write.csv(img_area_cur[,5],file=paste0(y_path,"/output/",substr(inFile$name,1,nchar(inFile$name)-4),"_face.csv"))
    return(img_area_cur)
  })
  
  rgb_ext<-reactive({
    inFile<-input$y_files
    
    nR<-10
    nG<-8
    nB<-10
    
    rBin<-seq(0,1,length.out=nR)
    gBin<-seq(0,1,length.out=nG)
    bBin<-seq(0,1,length.out=nB)
    
    color_data<-matrix(0,1,nR*nG*nB)
    
    for(i in 1:1){
      mat<-imageData(readImage(paste0(y_path,"/data/test_images/",inFile$name)))
      freq_rgb<-as.data.frame(table(factor(findInterval(mat[,,1],rBin),levels=1:nR),
                                    factor(findInterval(mat[,,2],gBin),levels=1:nG),
                                    factor(findInterval(mat[,,3],bBin),levels=1:nB)))
      rgb_feature<-as.numeric(freq_rgb$Freq)/(ncol(mat)*nrow(mat))
      color_data[i,]<-rgb_feature
    }
    write.csv(color_data,file=paste0(y_path,"/output/",substr(inFile$name,1,nchar(inFile$name)-4),"_rgb.csv"))
  })
  
  output$y_images<-renderImage({
    inFile<-input$y_files
    
    if(is.null(inFile)){
      return(list(src=paste0(y_path,"/figs/ask_for_image.png"),contentType="image/png",alt="No Image"))
    }
    else{
      return(list(src=inFile$datapath,contentType="image/jpg",alt="No Image"))
    }
  },deleteFile=F)
  
  output$zs_images<-renderImage({
    inFile<-input$zs_files
    
    if(is.null(inFile)){
      return(list(src=paste0(y_path,"/figs/ask_for_image.png"),contentType="image/png",alt="No Image"))
    }
    else{
      return(list(src=inFile$datapath,contentType="image/jpg",alt="No Image"))
    }
  },deleteFile=F)
  
  output$y_pro_images<-renderImage({
    inFile<-input$y_files
    #face_det()
    #return(list(src=paste0("C:/Users/Qing/Documents/GitHub/Fall2016-proj5-grp9/output/image_write_test/sample",inFile$name,".jpg"),contentType="image/jpg",alt="No Image"))
    return(list(src=paste0(y_path,"/output/image_write_test/sample",inFile$name,".jpg"),contentType="image/jpg",alt="No Image"))
  },deleteFile=F)
  
  output$zs_pro_images<-renderImage({
    inFile<-input$zs_files
    name <- inFile$name
    name <- substring(name,1,nchar(name)-4)
    #system('./lib/text_recognition.py) #please modify the wd accordingly
    return(list(src=paste0(x_path,"/output/text_detection/",name,'_contours.png'),alt="No Image"))
  },deleteFile=F)
  
  output$y_area<-renderDataTable({
    face_size()
  })
  
  output$zs_area <- renderDataTable({
    inFile<-input$zs_files
    name <- inFile$name
    name <- substring(name,1,nchar(name)-4)
    text_area <- read.csv(paste0(x_path, '/output/text_detection/', name, '_text.csv'))
    text_area[1,1] <- name
    colnames(text_area) <- c("ID","Text Area Proportion")
    return(text_area)
  })
  
  y_values <- reactiveValues(y_rgb_table = NULL, y_rgb_table_processed = NULL)
  
  #output$y_rgb<-renderDataTable({
  #rgb_ext()
  #filename <- input$y_files$name
  #filename <- substring(filename,1,nchar(filename)-4)
  #y_values$y_rgb_table <- read.csv(paste0(y_path, '/output/',filename,'_rgb.csv'))
  #return(y_values$y_rgb_table)
  #})
  
  output$y_rgb_plot <- renderPlot({
    library(reshape)
    library(ggplot2)
    library(plotly)
    #rgb_ext()
    filename <- input$y_files$name
    filename <- substring(filename,1,nchar(filename)-4)
    y_values$y_rgb_table <- read.csv(paste0(y_path, '/output/',filename,'_rgb.csv'))
    y_rgb_table_processed <- y_values$y_rgb_table
    y_rgb_table_processed <- t(y_rgb_table_processed)
    y_rgb_table_processed<-data.frame(value=y_rgb_table_processed[2:801],color=rep(1:800))
    y_color<-melt(y_rgb_table_processed, id="color")
    p = ggplot(data=y_color,aes(x=color,y=value)) +
      geom_line(col="Blue")+ggtitle("RGB Plot")+
      theme(axis.text=element_text(size=14),legend.key=element_rect(fill="black"),
            legend.background=element_rect(fill="grey40"),legend.position=c(0.14,0.80),
            panel.grid.major=element_line(colour="grey40"),panel.grid.minor=element_blank(),
            panel.background=element_rect(fill="black"),
            plot.background=element_rect(fill="black",colour="black",size=2))
    print(p)
  })
  
  
  output$y_face_map<-renderImage({
    if(input$y_year_map=="2011"&input$y_map_number=="# 1"){
      return(list(src=paste0(y_path,"/figs/face_map_2011_01.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2011"&input$y_map_number=="# 2"){
      return(list(src=paste0(y_path,"/figs/face_map_2011_02.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2011"&input$y_map_number=="# 3"){
      return(list(src=paste0(y_path,"/figs/face_map_2011_03.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2012"&input$y_map_number=="# 1"){
      return(list(src=paste0(y_path,"/figs/face_map_2012_01.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2012"&input$y_map_number=="# 2"){
      return(list(src=paste0(y_path,"/figs/face_map_2012_02.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2012"&input$y_map_number=="# 3"){
      return(list(src=paste0(y_path,"/figs/face_map_2012_03.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2013"&input$y_map_number=="# 1"){
      return(list(src=paste0(y_path,"/figs/face_map_2013_01.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2013"&input$y_map_number=="# 2"){
      return(list(src=paste0(y_path,"/figs/face_map_2013_02.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2013"&input$y_map_number=="# 3"){
      return(list(src=paste0(y_path,"/figs/face_map_2013_03.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2014"&input$y_map_number=="# 1"){
      return(list(src=paste0(y_path,"/figs/face_map_2014_01.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2014"&input$y_map_number=="# 2"){
      return(list(src=paste0(y_path,"/figs/face_map_2014_02.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2014"&input$y_map_number=="# 3"){
      return(list(src=paste0(y_path,"/figs/face_map_2014_03.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2015"&input$y_map_number=="# 1"){
      return(list(src=paste0(y_path,"/figs/face_map_2015_01.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2015"&input$y_map_number=="# 2"){
      return(list(src=paste0(y_path,"/figs/face_map_2015_02.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
    else if(input$y_year_map=="2015"&input$y_map_number=="# 3"){
      return(list(src=paste0(y_path,"/figs/face_map_2015_03.jpeg"),
                  contentType="image/jpeg",alt="No Image",height=600,width=800))
    }
  },deleteFile=F)
  
  ########### Box Prediction ##################
  z_value<-reactiveValues(z_name= NULL, z_rgb_table=NULL)
  # show the uploaded image 
  output$z_Image <- renderImage({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$z_file1
    z_value$z_name<-inFile$name
    
    if (is.null(inFile)){
      return(list(
        src=paste0(z_path,'/figs/ask_for_image.png'),
        filetype="image/png",
        alt="no image"
      )
      )
    } else {
      return(list(
        src=inFile$datapath,
        width=200,
        height=300,
        filetype="image/jpg",
        alt="no image"
      ))
    }
    
    
  },deleteFile = FALSE)
  
  
  z_face_size<-reactive({
    inFile<-input$z_file1
    file_list<-list.files(paste0(z_path,"/output/image_write_face_test"))
    img_size<-vector()
    for(i in 1:length(file_list)){
      img_load<-load.image(paste0(z_path,"/output/image_write_face_test/",file_list[i]))
      img_size[i]<-dim(img_load)[1]*dim(img_load)[2]
    }
    img_cat<-substr(file_list,1,11)
    img_num<-table(img_cat)
    img_cum<-vector()
    for(i in 1:length(img_num)){
      img_cum[i]<-sum(img_num[1:i])
    }
    img_area<-sum(img_size[1:img_cum[1]])
    for(i in 2:length(img_cum)){
      img_area[i]<-sum(img_size[(img_cum[i-1]+1):img_cum[i]])
    }
    names(img_area)<-names(img_num)
    img_area_df<-data.frame(cbind(img_area,img_num))
    file_list_new<-list.files(paste0(z_path,"/output/image_write_test"))
    img_size_new<-vector()
    for(i in 1:length(file_list_new)){
      img_load_new<-load.image(paste0(z_path,"/output/image_write_test/",file_list_new[i]))
      img_size_new[i]<-dim(img_load_new)[1]*dim(img_load_new)[2]
    }
    names(img_size_new)<-substr(file_list_new,7,17)
    img_area_df<-cbind(img_area_df,img_size_new)
    img_area_df$prop<-img_area/img_size_new
    img_area_df<-cbind(id=rownames(img_area_df),img_area_df)
    img_area_df <- img_area_df[,c(1,3,5,4)]
    colnames(img_area_df)<-c("id","face_number","face_proportion","text_proportion")
    img_area_cur<-img_area_df[img_area_df$id==inFile$name,]
    id <- input$z_file1$name
    id <- substring(id, 1, nchar(id)-4)
    text_pro <- read.csv(paste0(z_path,"/output/", id, '_text.csv'))
    print(text_pro)
    img_area_cur[1,4] <- text_pro[1,2]
    #write.csv(img_area_cur[,5],file=paste0(y_path,"/output/",substr(inFile$name,1,7),"_face.csv"))
    return(img_area_cur)
  })
  
  observeEvent(input$z_file1,{
    output$z_table1<-renderDataTable(z_face_size())
  })
  
  
  z_rgb_ext<-reactive({
    inFile<-input$z_file1
    print("1")
    nR<-10
    nG<-8
    nB<-10
    
    rBin<-seq(0,1,length.out=nR)
    gBin<-seq(0,1,length.out=nG)
    bBin<-seq(0,1,length.out=nB)
    
    color_data<-matrix(0,1,nR*nG*nB)
    
    for(i in 1:1){
      mat<-imageData(readImage(paste0(z_path,"/data/test_images/",inFile$name)))
      freq_rgb<-as.data.frame(table(factor(findInterval(mat[,,1],rBin),levels=1:nR),
                                    factor(findInterval(mat[,,2],gBin),levels=1:nG),
                                    factor(findInterval(mat[,,3],bBin),levels=1:nB)))
      rgb_feature<-as.numeric(freq_rgb$Freq)/(ncol(mat)*nrow(mat))
      color_data[i,]<-rgb_feature
    }
    write.csv(color_data,file=paste0(z_path,"/output/",sub('....$','',inFile$name),"_rgb.csv"))
    z_a<-data.frame(color_data[2:801],rep(1:800))
    z_a_color<-melt(z_a,id="color")
    return(z_a_color)
  })
  
  output$z_ggLinePlot <- renderPlot({
    #library(reshape)
    #library(ggplot2)
    #library(plotly)
    #rgb_ext()
    filename <- input$z_file1$name
    filename <- substring(filename,1,nchar(filename)-4)
    z_value$z_rgb_table <- read.csv(paste0(z_path, '/output/',filename,'_rgb.csv'))
    z_rgb_table_processed <- z_value$z_rgb_table
    z_rgb_table_processed <- t(z_rgb_table_processed)
    z_rgb_table_processed<-data.frame(value=z_rgb_table_processed[2:801],color=rep(1:800))
    z_color<-melt(z_rgb_table_processed, id="color")
    p = ggplot(data=z_color,aes(x=color,y=value)) +
      geom_line(col="Blue")+ggtitle("RGB Plot")+
      theme(axis.text=element_text(size=14),legend.key=element_rect(fill="black"),
            legend.background=element_rect(fill="grey40"),legend.position=c(0.14,0.80),
            panel.grid.major=element_line(colour="grey40"),panel.grid.minor=element_blank(),
            panel.background=element_rect(fill="black"),
            plot.background=element_rect(fill="black",colour="black",size=2))
    print(p)
  })
  
  
  
  
  observeEvent(input$z_predict, {
    
    z_boxoff<-z_info[,7]
    z_label<-rep("1M",878)
    z_label[which(z_boxoff>=100000000)]<-"100M"
    z_label[which(z_boxoff>=10000000 & z_boxoff<100000000)]<-"10M"
    z_label<-as.factor(z_label)
    z_genre<-c("Action","Adventure","Animation","Biography","Comedy","Crime","Documentary","Drama","Family","Fantasy","History","Horror","Music","Mystery","Romance","Sci-Fi","Sport","Thriller","War","Western")
    z_Genre<-matrix(0,nrow = 878,ncol = length(z_genre))
    for (i in 1:length(z_genre)){
      z_order<-which(grepl(z_genre[i],z_info[,4])==1)
      z_Genre[z_order,i]<-1
    }
    allinfo_pre<-cbind(z_Genre,z_info[,13],z_info[,17],rgb_feature_mat)
    
    z_filepath<-sub('....$','',z_value$z_name)
    #system(zs.py)
    #system(qy.yp)
    z_filepath1<-normalizePath(file.path('./output',paste(z_filepath,'_genres.csv',sep='')))
    z_filepath2<-normalizePath(file.path('./output',paste(z_filepath,'_text.csv',sep='')))
    z_filepath3<-normalizePath(file.path('./output',paste(z_filepath,'_face.csv',sep='')))
    z_filepath4<-normalizePath(file.path('./output',paste(z_filepath,'_rgb.csv',sep='')))
    z_genre_test<-read.csv(z_filepath1)
    #z_genre<-c("Action","Adventure","Animation","Biography","Comedy","Crime","Documentary","Drama","Family","Fantasy","History","Horror","Music","Mystery","Romance","Sci-Fi","Sport","Thriller","War","Western")
    z_genre_test1<-rep(0,20)
    z_genre_test1[which(z_genre==z_genre_test$x[1])]<-1
    z_genre_test1[which(z_genre==z_genre_test$x[2])]<-1
    z_text_test<-read.csv(z_filepath2)
    z_face_test<-read.csv(z_filepath3)
    z_rgb_test<-read.csv(z_filepath4)
    allinfo_test<-c(z_genre_test1,z_text_test[1,2],z_face_test[1,2],z_rgb_test[2:801])
    #allinfo_test<-c(0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0.1591985,13.5,color_data)
    #allinfo_test<-t(allinfo_test)[2,]
    #boxoff_rf<-randomForest(allinfo_pre,label,importance=T,proximity=T)
    boxoff_rf_pre<-predict(boxoff_rf,allinfo_test)
    
    
    output$z_predict<-renderText(
      if (boxoff_rf_pre=="100M"){
        print("Above 100 Millions")
      } else if (boxoff_rf_pre=="10M"){
        print("Among 10 Millions and 100 Millions")
      } else if (boxoff_rf_pre=="1M"){
        print("Among 1 Millions and 10 Millions")
      }
    )
  })
  
  observeEvent(input$z_recommendation,{
    output$z_recommendation<-renderText(
      print("Top 6 posters in this Genre!")
    )
    # select top 6 posters' name
    z_info_rank<-z_info[order(z_info[,7],decreasing=T),]
    z_order1<-which(grepl("Drama",z_info_rank[,4])==1)
    z_info_rank1<-z_info_rank[z_order1,]
    z_order2<-which(grepl("Adventure",z_info_rank[,4])==1)
    z_id_top<-z_info_rank1[z_order2[1:6],2]
    
    print("1")
    output$z_image1<-renderImage({
      filename<-normalizePath(file.path('./data/train_images',paste(z_id_top[1],'.jpg',sep='')))
      list(
        src=filename,
        width=200,
        height=300,
        filetype="image/jpg",
        alt="no image"
      )
    },deleteFile = FALSE)
    
    output$z_image2<-renderImage({
      filename<-normalizePath(file.path('./data/train_images',paste(z_id_top[2],'.jpg',sep='')))
      list(
        src=filename,
        filetype="image/jpg",
        width=200,
        height=300,
        alt="no image"
      )
    },deleteFile = FALSE)
    
    output$z_image3<-renderImage({
      filename<-normalizePath(file.path('./data/train_images',paste(z_id_top[3],'.jpg',sep='')))
      list(
        src=filename,
        width=200,
        height=300,
        filetype="image/jpg",
        alt="no image"
      )
    },deleteFile = FALSE)
    
    output$z_image4<-renderImage({
      filename<-normalizePath(file.path('./data/train_images',paste(z_id_top[4],'.jpg',sep='')))
      list(
        src=filename,
        width=200,
        height=300,
        filetype="image/jpg",
        alt="no image"
      )
    },deleteFile = FALSE)
    
    output$z_image5<-renderImage({
      filename<-normalizePath(file.path('./data/train_images',paste(z_id_top[5],'.jpg',sep='')))
      list(
        src=filename,
        width=200,
        height=300,
        filetype="image/jpg",
        alt="no image"
      )
    },deleteFile = FALSE)
    
    output$z_image6<-renderImage({
      filename<-normalizePath(file.path('./data/train_images',paste(z_id_top[6],'.jpg',sep='')))
      list(
        src=filename,
        width=200,
        height=300,
        filetype="image/jpg",
        alt="no image"
      )
    },deleteFile = FALSE)
    
    z_colname<-c("NO. of face","face proportion","text proportion")
    z_num<-c(mean(z_info_rank1[z_order2[1:6],12]),mean(z_info_rank1[z_order2[1:6],13]),mean(z_info_rank1[z_order2[1:6],17])/400) #todo
    z_table<-rbind(z_colname,z_num)
    colnames(z_table)<-c("NO. of face","face proportion","text proportion")
    z_table<-data.frame(t(as.matrix(z_table[2,])))
    
    output$z_table2<-renderDataTable(z_table)
    
  })
  
})






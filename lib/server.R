library(RColorBrewer)
library(shiny)
library(ggplot2)
library(plotly)

wd<-"/Users/Cristina/Desktop/16 Fall/5243 ADS/Project 5/Fall2016-proj5-grp9"
setwd(wd)

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
                        gross = s_gross_genre[,s_year_num])
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
    ggplot(data=s_dataSwitch(), aes(x=genre, y=gross/1000000, fill=genre)) +
      geom_bar(colour="black",stat="identity")+
      theme(axis.text=element_text(size=14),legend.key=element_rect(fill="black"),
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
      geom_line(col=sample(colors2,1))+
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
            text = ~paste('proportion', proportion, '<br>number:', face)) %>%
      layout(title = 'Face number v. Face proportion',
             xaxis = list(title = 'face proportion of poster',
                          gridcolor = 'rgb(255, 255, 255)',
                          range = c(0, 0.15),
                          type = 'log',
                          zerolinewidth = 1,
                          ticklen = 5,
                          gridwidth = 2),
             yaxis = list(title = 'face number in each poster',
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
  
})






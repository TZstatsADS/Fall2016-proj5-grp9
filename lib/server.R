library(RColorBrewer)
library(shiny)
library(ggplot2)
library(plotly)

wd <- "/Users/YaqingXie/Desktop/3-Applied Data Science/Fall2016-proj5-grp9"
setwd(wd)

s_gross_genre<-read.csv("./data/s_gross_genre.csv")
s_gross_genre<-as.data.frame(s_gross_genre)

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
  
  output$ggBarPlotA<-renderPlotly({
  ggplot(data=s_dataSwitch(), aes(x=genre, y=gross, fill=genre)) +
  geom_bar(colour="black",stat="identity")
  ggplotly()
  })

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






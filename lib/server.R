library(RColorBrewer)
library(shiny)
library(ggplot2)
library(plotly)
s_gross_genre<-read.csv("/Users/Cristina/Desktop/16 Fall/5243 ADS/Project 5/data/s_gross_genre.csv")
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
  
  })






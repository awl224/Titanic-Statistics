library(shiny)
library(shinytitle)
library(ggplot2)
library(dplyr)

library(titanic)
titanic <- titanic_train
titanic <- na.omit(titanic)
titanic$Pclass <- as.factor(titanic$Pclass)
titanic$Survived <- as.factor(titanic$Survived)
titanic$Sex <- as.factor(titanic$Sex)

server <- function(input, output, session) {
  # Data frame with all combinations of Passenger Class and Sex
  all_combinations <- expand.grid(Pclass = c("1", "2", "3"), Sex = c("female", "male"))
  
  # Join the new data frame with the original titanic dataset
  titanic_complete <- merge(all_combinations, titanic, by = c("Pclass", "Sex"), all.x = TRUE)
  
  # Convert Passenger Class and Survived to factors
  titanic_complete$Pclass <- as.factor(titanic_complete$Pclass)
  titanic_complete$Survived <- as.factor(titanic_complete$Survived)
  
  # Match user selected values with conditions for passenger class, sex, age, and survived variables
  titanic_filtered <- reactive({
    subset(titanic_complete, 
           (Pclass==input$pclass[1]| Pclass==input$pclass[2]| Pclass==input$pclass[3]) & 
             (Sex==input$sex[1]| Sex==input$sex[2]) &
             (Age >= input$age[1] & Age <= input$age[2]) & 
             (Survived==input$survival[1]| Survived==input$survival[2])
    )
  })
  
  output$densityPlot <- renderPlot({
    #creates a ggplot object using the titanic_filtered() as data input: , setting the x-axis to the Age column and the fill to the Survived column.
    #use facet_wrap(), geom_density()
    Sex.labs <- c("Male", "Female")
    names(Sex.labs) <- c("male", "female")
    Pclass.labs <- c("First Class", "Second Class", "Third Class")
    names(Pclass.labs) <- c("1", "2", "3")
    ggplot(titanic_filtered(), aes(x = Age, fill = Survived)) + 
      facet_wrap(~ Sex+Pclass, labeller = labeller(Sex = Sex.labs, Pclass = Pclass.labs)) + 
      theme(legend.background = element_rect(fill="lightgrey", 
                                             size=0.5, linetype="solid", colour="black"),
        strip.text.x = element_text(face = "bold.italic"),
        strip.text.y = element_text(face = "bold.italic"))+
      geom_density(alpha = 0.5) +
      labs(y = "Proportion of Passengers",
           title = "Passenger Proportion by Age, Class, & Sex")
    }, res = 96)
  
  output$histogramPlot <- renderPlot({
    Sex.labs <- c("Male", "Female")
    names(Sex.labs) <- c("male", "female")
    Pclass.labs <- c("First Class", "Second Class", "Third Class")
    names(Pclass.labs) <- c("1", "2", "3")
    ggplot(titanic_filtered(), aes(x = Age, fill = Survived)) + 
      facet_wrap(~ Sex + Pclass, labeller = labeller(Sex = Sex.labs, Pclass = Pclass.labs)) +
      theme(legend.background = element_rect(fill="lightgrey", 
                                             size=0.5, linetype="solid", colour="black"),
            strip.text.x = element_text(face = "bold.italic"),
            strip.text.y = element_text(face = "bold.italic")) +
      geom_histogram(binwidth = 4, position = "dodge") +
      labs(y = "Passenger Count", 
           title = "Passenger Count by Age, Class, & Sex")
  }, res = 96)
}

server
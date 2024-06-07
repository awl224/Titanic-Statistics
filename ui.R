ui <- fluidPage(
  div(
    style = "padding-left: 40px; padding-right: 40px;",
    titlePanel(h1("Titanic Survival Statistics",
                  style='text-align: center;
              padding-top: 15px;
              padding-bottom: 30px'),  windowTitle = "Titanic Survival Statistics"),
    fluidRow(
      column(width = 3,
             style = "background-color: #e6e6e6; border: 1px solid black; border-radius: 10px; padding: 20px;",
             #Selection control part
                          #Add three selection elements, one for the survival status, one for pclass and one for the gender of the passengers. Set their initial selections using the selected argument.
             #Add one slider for selecting age range.
             
             #Passenger class selection
             checkboxGroupInput("pclass", "Passenger Class:",  
                                choices = c("First class"=1, "Second class"=2, "Third class"=3), 
                                selected = c(1,2,3)),
             
             #Passenger sender selection
             checkboxGroupInput("sex", "Passenger Gender:", 
                                choices = c("Male"="male", "Female"="female"), 
                                selected = c("male", "female")),
             
             # Passenger survival selection
             checkboxGroupInput("survival", "Did the passenger survive?",  
                                choices = c("Yes" = 1, "No" = 0), 
                                selected = c(1,0)),
             
             # Slider for age range selection
             sliderInput("age", "Select Age Range:", min=0, max=max(80), value=c(0,80)),
      ),
      column(width = 9,
             # Display plot
             plotOutput("densityPlot"),
             plotOutput("histogramPlot")
      )
    )
  )
)

ui
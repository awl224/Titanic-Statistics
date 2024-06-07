


# source the UI and server files
source("titanic/ui.R")
source("titanic/server.R")

# create the Shiny app
shinyApp(ui = ui, server = server)

library(rsconnect)
rsconnect::deployApp('./titanic', appName = 'titanic-survival')

# the published app can be found at https://andrewleaventon.shinyapps.io/titanic-survival/
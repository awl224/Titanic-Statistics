


# source the UI and server files
source("Titanic-Statistics/app/ui.R")
source("Titanic-Statistics/app/server.R")

# create the Shiny app
shinyApp(ui = ui, server = server)

library(rsconnect)
rsconnect::deployApp('Titanic-Statistics/app', appName = 'titanic-survival')

# the published app can be found at https://andrewleaventon.shinyapps.io/titanic-survival/
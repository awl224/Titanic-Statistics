


# source the UI and server files
source("app/ui.R")
source("app/server.R")

# create the Shiny app
shinyApp(ui = ui, server = server)

library(rsconnect)
rsconnect::deployApp('app', appName = 'titanic-survival-statistics')

# the published app can be found at https://andrewleaventon.shinyapps.io/titanic-survival/
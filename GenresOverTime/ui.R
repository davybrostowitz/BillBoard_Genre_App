#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# INCASE selectInput(inputId = "Year",label = "Year",choices = unique(bill_board_data$Year)
# selectInput("Genre", label = "Genre", choices = unique(bill_board_data$Broad_Genre))
#

shinyUI(dashboardPage(
  dashboardHeader(title = "Comparison of Genre Billboard Performance By Year"),
  dashboardSidebar(
    sidebarUserPanel("Davy Brostowitz"),
    sidebarMenu(
      menuItem("Genre Comparison by Year",
               tabName = "Year"),
      menuItem("Genres Over Time", tabName = "OverTime"),
      menuItem("Songs Data Table", tabName = 'SongsTable')
    )
  ),
  dashboardBody(tabItems(
    tabItem(
      tabName = "Year",
      titlePanel("Genre Billboard Performance by Year"),
      fluidRow(column(
        4,
        sliderInput(
          "Year",
          label = "Year",
          min = 2000,
          max = 2017,
          value = 2000,
          sep = ""
        )
      ), column(8, plotlyOutput("Count1")))
    ),
    tabItem(tabName = "OverTime",
            fluidRow(
              column(
                4,
                selectInput(
                  'OverTime',
                  inputId = 'Genre',
                  label = 'Genre',
                  choices = unique(bill_board_data$Broad_Genre)
                )
              ), column(8, plotlyOutput("Count2"))
            )),
    tabItem(tabName = "SongsTable",
            fluidRow(column(
              8, DT::dataTableOutput('Table')
            )))
  ))
))

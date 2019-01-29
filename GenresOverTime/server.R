#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#





shinyServer(function(input, output) {
  output$Count1 <- renderPlotly({
    ggplotly(
      bill_board_data %>%
        filter(., Year == input$Year) %>%
        arrange(., (Rank_Group)) %>%
        ggplot(aes(x = Broad_Genre)) +
        geom_bar(aes(fill = Rank_Group))
    )
  })
  
  
  output$Count2 <- renderPlotly({
    ggplotly(
      bill_board_data %>%
        filter(., Broad_Genre == input$Genre) %>%
        ggplot(aes(x = Year)) +
        geom_bar(aes(fill = Rank_Group))
    )
  })
  
  output$Table <- DT::renderDataTable({
    datatable(bill_board_data)
  })
  
  
  
})

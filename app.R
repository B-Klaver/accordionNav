library(shiny)
library(bslib)

thematic::thematic_shiny()

#The plan is to set up an accordion with accordion panels with the names
# Then we will use hidden navset panels that will be flipped to reactively
#https://shiny.posit.co/py/api/core/ui.navset_hidden.html
#https://rstudio.github.io/bslib/reference/accordion.html

# UI --------------------------------------------------------------------------

ui <- page_sidebar(
  title = "Test the navigation",
  class = "bslib-page-dashboard",
  sidebar = sidebar(
    accordion(
      multiple = FALSE,
      open = FALSE,
      id = "accord",
      accordion_panel(
        title = "Domain 1",
        value = "panel1"
      ),
      accordion_panel(
        title = "Domain 2",
        value = "panel2"
      ),
      accordion_panel(
        title = "Domain 3",
        value = "panel3"
      )
    )
  ),
  navset_hidden(
    id = "hidden_tabs",
    nav_panel_hidden(
      value = "panel1",
      "Panel 1 content"
    ),
    nav_panel_hidden(
      value = "panel2",
      "Panel 2 content"
    ),
    nav_panel_hidden(
      value = "panel3",
      "Panel 3 content"
    )
  )
)

# Server ----------------------------------------------------------------------

server <- function(input, output, session) {
  
  observe(
    nav_select("hidden_tabs", input$accord)
  )
  
}

shinyApp(ui, server)


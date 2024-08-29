library(shiny)
library(bslib)

thematic::thematic_shiny()

#The plan is to set up an accordion with accordion panels with the names
# Then we will use hidden navset panels that will be flipped to reactively
#https://shiny.posit.co/py/api/core/ui.navset_hidden.html
#https://rstudio.github.io/bslib/reference/accordion.html

# UI --------------------------------------------------------------------------

ui <- page_sidebar(
  title = "Accordion Navigation Example",
  class = "bslib-page-dashboard",
  # sidebar = sidebar(
  #   accordion(
  #     multiple = FALSE,
  #     open = FALSE,
  #     id = "accord_select",
  #     accordion_panel(
  #       title = "Domain 1",
  #       value = "panel1"
  #     ),
  #     accordion_panel(
  #       title = "Domain 2",
  #       value = "panel2"
  #     ),
  #     accordion_panel(
  #       title = "Domain 3",
  #       value = "panel3"
  #     )
  #   ),
  # bslib::input_dark_mode()
  # ),
  # navset_hidden(
  #   id = "hidden_tabs",
  #   nav_panel_hidden(
  #     value = "panel1",
  #     "Panel 1 content"
  #   ),
  #   nav_panel_hidden(
  #     value = "panel2",
  #     "Panel 2 content"
  #   ),
  #   nav_panel_hidden(
  #     value = "panel3",
  #     "Panel 3 content"
  #   )
  # ),
  navset_pill_list(
    widths = c(2, 10),
    well = FALSE,
    nav_panel(
      title = "Panel 1", 
      navset_pill_list(
        widths = c(2, 10),
        well = FALSE,
        nav_panel(
          title = "Sub-panel 1.1",
          p("Sub-panel 1.1 content")
        ),
        nav_panel(
          title = "Sub-panel 1.2",
          p("Sub-panel 1.2 content")
        )
      )
    ),
    nav_panel(
      title = "Panel 2", 
      navset_pill_list(
        widths = c(2, 10),
        nav_panel(
          title = "Sub-panel 2.1",
          p("Sub-panel 2.1 content")
        ),
        nav_panel(
          title = "Sub-panel 2.2",
          p("Sub-panel 2.2 content")
        )
      )
    ),
    nav_panel(
      title = "Panel 3", 
      navset_pill_list(
        widths = c(2, 10),
        nav_panel(
          title = "Sub-panel 3.1",
          p("Sub-panel 3.1 content")
        ),
        nav_panel(
          title = "Sub-panel 3.2",
          p("Sub-panel 3.2 content")
        )
      )
    )
  )
)

# Server ----------------------------------------------------------------------

server <- function(input, output, session) {
  
  # observe(
  #   nav_select("hidden_tabs", input$accord_select)
  # )
  
}

shinyApp(ui, server)


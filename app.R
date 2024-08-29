
# SETUP -----------------------------------------------------------------------


devtools::load_all()


domain_list <- list(
  "Domain 1" = list(
    "Sub-domain 1.1",
    "Sub-domain 1.2"
  ),
  "Domain 2" = list(
    "Sub-domain 2.1"
  ),
  "Domain 3" = list()
)




# UI --------------------------------------------------------------------------

ui <- bslib::page_sidebar(
  title = "Accordion Navigation Example",
  class = "bslib-page-dashboard",
  sidebar = bslib::sidebar(
    accordionTabset(
      "accord_select", 
      domain_list
    ),
    bslib::input_dark_mode()
  ),
  bslib::navset_hidden(
    id = "hidden_tabs",
    bslib::nav_panel_hidden(
      value = names(domain_list[1]),
      "Panel 1 content"
    ),
    bslib::nav_panel_hidden(
      value = domain_list[[names(domain_list[1])]][[1]],
      "Panel 1.1 content"
    ),
    bslib::nav_panel_hidden(
      value = domain_list[[names(domain_list[1])]][[2]],
      "Panel 1.2 content"
    ),
    bslib::nav_panel_hidden(
      value = names(domain_list[2]),
      "Panel 2 content"
    ),
    bslib::nav_panel_hidden(
      value = domain_list[[names(domain_list[2])]][[1]],
      "Panel 2.1 content"
    ),
    bslib::nav_panel_hidden(
      value = names(domain_list[3]),
      "Panel 3 content"
    )
  )
)

# Server ----------------------------------------------------------------------

server <- function(input, output, session) {
  
  accordionPanelSelect(
    input, 
    session,
    panel_id = "hidden_tabs",
    accordion_id = "accord_select",
    menu_list = domain_list
  )
  
}

shiny::shinyApp(ui, server)


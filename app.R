library(shiny)
library(bslib)

thematic::thematic_shiny()

devtools::load_all()

# SETUP -----------------------------------------------------------------------



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

ui <- page_sidebar(
  title = "Accordion Navigation Example",
  class = "bslib-page-dashboard",
  sidebar = sidebar(
    accordionTabset(
      "accord_select", 
      domain_list
      ),
    bslib::input_dark_mode()
  ),
  navset_hidden(
    id = "hidden_tabs",
    nav_panel_hidden(
      value = tolower(stringr::str_replace_all(names(domain_list[1]), "[[:punct:]]|[[:blank:]]", "")),
      "Panel 1 content"
    ),
    nav_panel_hidden(
      value = tolower(stringr::str_replace_all(domain_list[[names(domain_list[1])]][[1]], "[[:punct:]]|[[:blank:]]", "")),
      "Panel 1.1 content"
    ),
    nav_panel_hidden(
      value = tolower(stringr::str_replace_all(domain_list[[names(domain_list[1])]][[2]], "[[:punct:]]|[[:blank:]]", "")),
      "Panel 1.2 content"
    ),
    nav_panel_hidden(
      value = tolower(stringr::str_replace_all(names(domain_list[2]), "[[:punct:]]|[[:blank:]]", "")),
      "Panel 2 content"
    ),
    nav_panel_hidden(
      value = tolower(stringr::str_replace_all(domain_list[[names(domain_list[2])]][[1]], "[[:punct:]]|[[:blank:]]", "")),
      "Panel 2.1 content"
    ),
    nav_panel_hidden(
      value = tolower(stringr::str_replace_all(names(domain_list[3]), "[[:punct:]]|[[:blank:]]", "")),
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

shinyApp(ui, server)


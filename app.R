library(shiny)
library(bslib)

thematic::thematic_shiny()

devtools::load_all()

#The plan is to set up an accordion with accordion panels with the names
# Then we will use hidden navset panels that will be flipped to reactively
#https://shiny.posit.co/py/api/core/ui.navset_hidden.html
#https://rstudio.github.io/bslib/reference/accordion.html



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


# accordionPanelSelect <- function(input, output, session, panel_id, accordion_id, menu_list) {
#   
#   observe(
#     nav_select(panel_id, input[[accordion_id]])
#   )
#   
#   purrr::flatten(menu_list) |> 
#     purrr::map(
#       \(id) {
#         
#         id_clean <- tolower(stringr::str_replace_all(id, "[[:punct:]]|[[:blank:]]", ""))
#         
#         shiny::observeEvent(input[[id_clean]], {
#           shiny::updateTabsetPanel(
#             session = session,
#             inputId = accordion_id,
#             selected = id_clean
#           )
#         })
#       }
#     )
#   
# }



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
  
  # accordionPanelSelect(
  #   input,
  #   output,
  #   session,
  #   panel_id = "hidden_tabs",
  #   accordion_id = "accord_select",
  #   menu_list = domain_list
  # )
  
  observe(
    nav_select("hidden_tabs", input$accord_select)
  )

  purrr::flatten(domain_list) |>
    purrr::map(
      \(id) {

        id_clean <- tolower(stringr::str_replace_all(id, "[[:punct:]]|[[:blank:]]", ""))

        shiny::observeEvent(input[[id_clean]], {
          shiny::updateTabsetPanel(
            session = session,
            inputId = "hidden_tabs",
            selected = id_clean
          )
        })
      }
    )
  
}

shinyApp(ui, server)


#' @title accordionPanelSelect
#' @author Braeden Klaver
#' @usage accordionPanelSelect(input, session, panel_id, accordion_id, menu_list)
#' @param input The server input
#' @param session The server session
#' @param panel_id The shiny app ID for the nav panels.
#' @param accordion_id The shiny app ID for the accordion menu.
#' @param menu_list The nested list with menu and sub-menu items.
#' @importFrom purrr map
#' @importFrom purrr flatten
#' @importFrom bslib nav_select
#' @importFrom shiny moduleServer
#' @importFrom shiny observe
#' @importFrom shiny observeEvent
#' @importFrom shiny updateTabsetPanel
#' @return An accordion list for domain and sub-domain


accordionPanelSelect <- function(input, session, panel_id, accordion_id, menu_list) {
  
  #This will allow for nav panels linked to the accordion drop downs
  shiny::observe(
    bslib::nav_select(panel_id, input[[accordion_id]])
  )
  
  #This will allow for nav panels linked to the action links from the drop downs
  purrr::flatten(menu_list) |>
  purrr::map(
    \(id) {
      shiny::observeEvent(
        input[[id]], {
          shiny::updateTabsetPanel(
            session = session,
            inputId = panel_id,
            selected = id
          )
        }
      )
    }
  )
  
}

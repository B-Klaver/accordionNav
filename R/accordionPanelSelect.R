#' @title accordionPanelSelect
#' @author Braeden Klaver
#' @usage accordionPanelSelect(input, session, panel_id, accordion_id, menu_list)
#' @importFrom purrr map
#' @importFrom purrr flatten
#' @importFrom bslib nav_select
#' @importFrom shiny moduleServer
#' @importFrom shiny observe
#' @importFrom shiny observeEvent
#' @importFrom shiny updateTabsetPanel
#' @return An accordion list for domain and sub-domain


accordionPanelSelect <- function(input, session, panel_id, accordion_id, menu_list) {
  
  shiny::observe(
    bslib::nav_select(panel_id, input[[accordion_id]])
  )
  
  purrr::flatten(menu_list) |>
    purrr::map(
      \(id) {
        
        shiny::observeEvent(input[[id]], {
          shiny::updateTabsetPanel(
            session = session,
            inputId = panel_id,
            selected = id
          )
        })
      }
    )
  
}

#' @title accordionPanelSelect
#' @author Braeden Klaver
#' @usage accordionPanelSelect(input, session, panel_id, accordion_id, menu_list)
#' @importFrom purrr map
#' @importFrom purrr flatten
#' @importFrom stringr str_replace_all
#' @importFrom shiny moduleServer
#' @importFrom shiny observeEvent
#' @importFrom shiny updateTabsetPanel
#' @return An accordion list for domain and sub-domain


accordionPanelSelect <- function(input, session, panel_id, accordion_id, menu_list) {
  
  observe(
    nav_select(panel_id, input[[accordion_id]])
  )
  
  purrr::flatten(menu_list) |>
    purrr::map(
      \(id) {

        id_clean <- tolower(stringr::str_replace_all(id, "[[:punct:]]|[[:blank:]]", ""))

        shiny::observeEvent(input[[id_clean]], {
          shiny::updateTabsetPanel(
            session = session,
            inputId = panel_id,
            selected = id_clean
          )
        })
      }
    )
  
  # shiny::moduleServer(
  #   accordion_id, 
  #   function(input, output, session) {
  #     
  #     observe(
  #       nav_select(panel_id, input[[accordion_id]])
  #     )
  #     
  #     
  #     purrr::flatten(menu_list) |>
  #       purrr::map(
  #         \(id) {
  #           
  #           id_clean <- tolower(stringr::str_replace_all(id, "[[:punct:]]|[[:blank:]]", ""))
  #           
  #           shiny::observeEvent(input[[id_clean]], {
  #             shiny::updateTabsetPanel(
  #               session = session,
  #               inputId = panel_id,
  #               selected = id_clean
  #             )
  #           })
  #         }
  #       )
  #   }
  # )
  
}

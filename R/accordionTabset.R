#' @title accordionTabset
#' @author Braeden Klaver
#' @usage accordionTabset(id, menu_list, class)
#' @importFrom purrr map
#' @importFrom shiny actionLink
#' @importFrom bslib accordion
#' @importFrom bslib accordion_panel
#' @return An accordion list for domain and sub-domain

accordionTabset <- function(id, menu_list, class = "") {
  
  names(menu_list) |> 
    purrr::map(
      \(item_id)
      bslib::accordion_panel(
        title = item_id,
        value = item_id,
        menu_list[[item_id]] |>
          purrr::map(
            \(subitem_id)
            shiny::actionLink(
              subitem_id,
              subitem_id,
              class = class
            )
          )
      )
    ) |> 
    bslib::accordion(
      multiple = FALSE,
      open = FALSE,
      id = {{ id }}
    )
  
}


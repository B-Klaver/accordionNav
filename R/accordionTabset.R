#' @title accordionTabset
#' @author Braeden Klaver
#' @usage accordionTabset(id, menu_list)
#' @importFrom purrr map
#' @importFrom shiny actionLink
#' @importFrom stringr str_replace_all
#' @importFrom bslib accordion
#' @importFrom bslib accordion_panel
#' @return An accordion list for domain and sub-domain

accordionTabset <- function(id, menu_list) {
  
  names(menu_list) |> 
    purrr::map(
      \(item_id)
      bslib::accordion_panel(
        title = item_id,
        value = tolower(
          stringr::str_replace_all(
            item_id, 
            "[[:punct:]]|[[:blank:]]", 
            ""
          )
        ),
        menu_list[[item_id]] |>
          purrr::map(
            \(subitem_id)
            shiny::actionLink(
              tolower(
                stringr::str_replace_all(
                  subitem_id, 
                  "[[:punct:]]|[[:blank:]]", 
                  ""
                )
              ),
              subitem_id,
              class = "link-body-emphasis d-inline-flex text-decoration-none mb-3 rounded w-100"
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


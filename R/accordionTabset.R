#' @title accordionTabset
#' @aliases accordionTabset
#' @description  accordionTabset() creates the drop down navigation menu UI.
#' @author Braeden Klaver
#' @usage accordionTabset(id, menu_list, class = NULL)
#' @param id The shiny ID
#' @param menu_list The nested list with menu items and sub-items.
#' @param class The custom CSS class for the sub-item menu items
#' @importFrom purrr map
#' @importFrom purrr pmap
#' @importFrom shiny actionLink
#' @importFrom shiny icon
#' @importFrom bslib accordion
#' @importFrom bslib accordion_panel
#' @importFrom bsicons bs_icon
#' @importFrom htmltools tags
#' @importFrom htmltools HTML
#' @export accordionTabset
#' @return An accordion list for domain and sub-domain

accordionTabset <- function(id, menu_list, class = NULL, icon_list = NULL) {
  
  if (is.null(icon_list)) {
    list(item_id = names(menu_list)) |> 
      purrr::map(
        \(item_id)
        bslib::accordion_panel(
          title = item_id,
          value = item_id,
          menu_list[[item_id]] |>
            purrr::map(
              \(subitem_id)
              shiny::actionLink(
                inputId = subitem_id,
                label   = htmltools::tags$span(
                  htmltools::HTML("&nbsp;"),
                  shiny::icon("angles-right"),
                  htmltools::HTML("&nbsp;"),
                  subitem_id),
                class   = class
              )
            )
        )
      )
  } else {
    list(item_id = names(menu_list), item_icon = icon_list) |> 
      purrr::pmap(
        \(item_id, item_icon)
        bslib::accordion_panel(
          title = item_id,
          value = item_id,
          icon  = bsicons::bs_icon(item_icon),
          menu_list[[item_id]] |>
            purrr::map(
              \(subitem_id)
              shiny::actionLink(
                inputId = subitem_id,
                label   = htmltools::tags$span(
                  htmltools::HTML("&nbsp;"),
                  shiny::icon("angles-right"),
                  htmltools::HTML("&nbsp;"),
                  subitem_id),
                class   = class
              )
            )
        )
      )
  } |> 
    bslib::accordion(
      multiple = FALSE,
      open = FALSE,
      id = {{ id }}
    )
  
}


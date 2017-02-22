#' Include Cleave Scripts
#' 
#' Adds Cleave Javascript files to Shiny App
#' 
#' @export
#' @importFrom shiny singleton includeScript tagList
#' 

includeCleave <- function() {
  shiny::singleton(
    shiny::tagList(
      shiny::includeScript(
        system.file(package = "shinyCleave",
                    "javascript", "cleave", "cleave.min.js")
      ),
      shiny::includeScript(
        system.file(package = "shinyCleave",
                    "javascript", "cleave", "addons", "cleave-phone.us.js")
      )
    )
  )
}
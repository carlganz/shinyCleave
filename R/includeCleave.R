# Copyright CannaData Solutions 2017

#' Include Cleave Scripts
#' 
#' Adds Cleave Javascript files to Shiny App
#' 
#' @param country Two-digit lower-case country code indicating source of phone number
#' @export
#' @importFrom shiny singleton includeScript tagList
#' 

includeCleave <- function(country = "us") {
  shiny::singleton(
    shiny::tagList(
      shiny::includeScript(
        system.file(package = "shinyCleave",
                    "javascript", "cleave", "cleave.min.js")
      ),
      shiny::includeScript(
        system.file(package = "shinyCleave",
                    "javascript", "cleave", "addons", 
                    paste0("cleave-phone.", country, ".js"))
      ),
      shiny::includeScript(
        system.file(package = "shinyCleave",
                    "javascript", 
                    "shinyCleave.js")
      )
    )
  )
}

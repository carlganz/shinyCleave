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

#' @rdname includeCleave
#' @export
#' @importFrom htmltools htmlDependency
#'

cleaveLib <- function(country = "us") {
  htmltools::htmlDependency(
    "cleave", "0.7.10", system.file(package = "shinyCleave",
                                    "javascript", "cleave"),
    script = c("cleave.min.js", paste0("addons/cleave-phone.", country, ".js")),
    all_files = FALSE
  )
}

#' @rdname includeCleave
#' @export
#' 

shinyCleaveLib <- function() {
  htmltools::htmlDependency(
    "shinyCleave", "0.0.1", system.file(package = "shinyCleave",
                                    "javascript"),
    script = "shinyCleave.js",
    all_files = FALSE
  )
}
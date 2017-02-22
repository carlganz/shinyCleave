# Copyright CannaData Solutions 2017

#' Phone Input
#' 
#' Input for phone numbers
#' 
#' @inheritParams shiny::textInput
#' @inheritParams includeCleave
#' @importFrom shiny textInput
#' @export
#'

phoneInput <- function(inputId, label, value = "", width = NULL, placeholder = NULL, country = "us") {
  
  shiny::tagList(
    shiny::textInput(inputId, label, value, width, placeholder),
    shiny::tags$script(
      paste0('
      var cleave = new Cleave("#', inputId, '", {
        phone: true,
        phoneRegionCode: "', country, '"
      });
    ')
  )
  )
  
}

#' @rdname phoneInput
#' @export
#'

creditCardInput <- function(inputId, label, value = "", width = NULL, placeholder = NULL) {
  
  shiny::tagList(
    shiny::textInput(inputId, label, value, width, placeholder),
    shiny::tags$script(
      paste0('
      var cleave = new Cleave("#', inputId, '", {
        creditCard: true,
        onCreditCardTypeChanged: function(type) {
          Shiny.onInputChange("',inputId,'" + 
            "_creditCard", type);
        }
      });
    ')
    )
  )
  
}


#' Server side functionality
#' 
#' Cleave inputs from the server
#' 
#' @param session The `session` object passed to function given to `shinyServer`
#' @param selector CSS Selector specifying the input/s
#' @param inputType List of options passed to Cleave as JSON; see notes
#' @export
#' @note See \url{http://nosir.github.io/cleave.js/} for options
#' @note Javascript functions passed to inputType should be wrapped in `I()`
#' @importFrom jsonlite toJSON
#' @import shiny
#' 

cleave <- function(session, selector, inputOptions) {
  
  options <- jsonlite::toJSON(
    list(
      selector = selector,
      inputOptions = inputOptions
    ),
    auto_unbox = TRUE
  )

  session$sendCustomMessage("cleave", options)
  
}

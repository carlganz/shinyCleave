# Copyright CannaData Solutions 2017

#' Phone Input
#' 
#' Input for phone numbers
#' 
#' @inheritParams shiny::textInput
#' @inheritParams includeCleave
#' @importFrom shiny textInput
#' @param ... Additional parameters passed to \code{myInput}
#' @export
#'

phoneInput <- function(inputId, label, value = "", width = NULL, placeholder = NULL, country = "us", ...) {
  
  shiny::tagList(
    shinyCleave::myInput("text", inputId, label, value, width, placeholder, ...),
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

#' @export
#' @rdname phoneInput
zipInput <- function(inputId, label, value = "", width = NULL, placeholder = NULL, ...) {
  
  myInput("text",inputId, label, value, width, placeholder, maxlength = "5",
          onkeypress='return event.charCode >= 48 && event.charCode <= 57', ...)
  
}

#' @export
#' @rdname phoneInput
moneyInput <- function(inputId, label, value = "", width = NULL, placeholder = NULL, ...) {
  shiny::tagList(
    shinyCleave::myInput("text", inputId, label, value, width, placeholder, ...),
    shiny::tags$script(
      paste0('
      var cleave = new Cleave("#', inputId, '", {
        prefix: "$"
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
#' @param inputOptions List of options passed to Cleave as JSON; see notes
#' @export
#' @note See \url{http://nosir.github.io/cleave.js/} for options
#' @note Javascript functions passed to inputType should be wrapped in `I()`
#' @importFrom jsonlite toJSON
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


#' Shiny inputs with additional parameters
#' 
#' Allow user to use standard Shiny inputs, but with ... so additional attributes can be used
#' 
#' @inheritParams shiny::textInput
#' @param type Type of Shiny input
#' @param class CSS class
#' @param ... Additional attributes passed to Shiny input
#' @importFrom shiny restoreInput
#' @importFrom htmltools div validateCssUnit tags
#' @export
#' 
myInput <- function(type, inputId, label, value = "", width = NULL, placeholder = NULL, class = "", ...) 
{
  value <- restoreInput(id = inputId, default = value)
  class <- paste0("form-control ",class)
  tagList(div(class = "form-group shiny-input-container", style = if (!is.null(width)) 
            paste0("width: ", validateCssUnit(width), ";"), label %AND% 
              tags$label(label, `for` = inputId), tags$input(id = inputId, 
                                                             type = type, class = class, 
                                                             value = value, 
                                                             placeholder = placeholder,...)))
}

# copied from shiny
`%AND%` <- function (x, y) 
{
  if (!is.null(x) && !is.na(x)) 
    if (!is.null(y) && !is.na(y)) 
      return(y)
  return(NULL)
}


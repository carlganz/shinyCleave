
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/CannaData/shinyCleave.svg?branch=master)](https://travis-ci.org/CannaData/shinyCleave)

[Shiny](https://github.com/rstudio/shiny) provides many basic inputs that map nicely to R's basic datatypes. However, there many instances where users may want a custom `textInput` that may or may not map consistent with a specific R datatype. For example, phone numbers, credit cards, and other formatted strings.

The [Cleave.js](https://github.com/nosir/cleave.js) library provides facilities for customizing text inputs.

`shinyCleave` wraps [Cleave.js](https://github.com/nosir/cleave.js) so that [Shiny](https://github.com/rstudio/shiny) `textInputs` can be customized.

Installation
============

`shinyCleave` is only available on github at the moment.

``` r
devtools::install_github("carlganz/shinyCleave")
```

Example
=======

`shinyCleave` provides several additional inputs like `phoneInput`, and `creditCardInput`, as well as server-side control of `Cleave.js`.

Below is an example which users client side `phoneInput` and `creditCardInput`, and also sets a text input to only accept numerics, and to format them in the "wan"-style. The app also prints the credit-card type to the console as it is typed.

``` r
library(shiny)
library(shinyCleave)

ui <- fluidPage(
  includeCleave(),
  textInput("money","Money input"),
  phoneInput("phone","Phone input"),
  textInput("num", "Format numbers"),
  creditCardInput("card","Credit Card")
)

server <- shinyServer(function(input, output, session) {

  cleave(session, "#money", list(
    prefix = "$"
  ))
  
  cleave(session, "#num", list(
    numeral = TRUE,
    numeralThousandsGroupStyle= 'wan'
  ))
  
  observe({
    print(input$card_creditCard)
  })
  
})

shinyApp(ui=ui,server=server)
```

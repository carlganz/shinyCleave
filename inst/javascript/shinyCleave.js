/*
  Copyright CannaData Solutions 2017
*/

Shiny.addCustomMessageHandler("cleave", function(options) {
  
  var cleave = new Cleave(options.selector, options.inputOptions);
  
});
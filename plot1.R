source("loadData.R")

#' Building plot 1
#'
#' @param data dataframe or arguments to `loadData` function 
#' @param fileName output PNG file name or NULL to plot on the default device (screen)
#' @param ... additional parameters to `hist` function
#'
#' @return
plot1 <- function(data = list(ranges = c(66638, 2880)), fileName = "plot1.png", ...){
  pngPlotWithData(data, fileName, function(data){
    hist(data$Global_active_power, 
         col = "red", 
         xlab = "Global Active Power (kilowatts)",
         main = "Global Active Power",
         ...)
  })
}
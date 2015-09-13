source("loadData.R")

#' Building plot 2 
#'
#' @param data dataframe or arguments to `loadData` function 
#' @param fileName output PNG file name or NULL to plot on the default device (screen)
#' @param ... additional parameters to `plot` function
#' @param label the Y-label for plot
#'
#' @return
plot2 <- function(data = list(ranges = c(66638, 2880)), label = "Global Active Power (kilowatts)", fileName = "plot2.png", ...){
  pngPlotWithData(data, fileName, function(data){
    with(data, 
      plot(TimeStamp, 
           Global_active_power,
           type = "l",
           ylab = label,
           xlab = "",
           ...)
    )
  })
}
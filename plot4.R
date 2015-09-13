source("loadData.R")
source("plot2.R")
source("plot3.R")

#' Building plot 4 
#'
#' @param data dataframe or arguments to `loadData` function 
#' @param fileName output PNG file name or NULL to plot on the default device (screen)
#' @param ... additional parameters to `plot` functions
#'
#' @return
plot4 <- function(data = list(ranges = c(66638, 2880)), fileName = "plot4.png", ...){
  pngPlotWithData(data, fileName, function(data){
    with(data,{ 
      oldPar <- par(mfcol = c(2,2) , mar = c(5,4,1,1) + 0.1)
      
      plot2(data, fileName = NULL , label = "Global Active Power", ...)
      plot3(data, fileName = NULL , leg.par = list(bty = "n"), ...)

      plot(TimeStamp, Voltage, xlab = "datetime", type = "l", ...)
      plot(TimeStamp, 
           Global_reactive_power,  
           xlab = "datetime", 
           ylab = "Global Reactive Power",
           type = "l", 
           ...)
      
      par(oldPar)
    })
  })
}
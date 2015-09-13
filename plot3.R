source("loadData.R")

#' Building plot 3 
#'
#' @param data dataframe or arguments to `loadData` function 
#' @param fileName output PNG file name or NULL to plot on the default device (screen)
#' @param ... additional parameters to `plot` and `points` functions
#' @param leg.par list of additional parameters to `legend` function
#'
#' @return
plot3 <- function(data = list(ranges = c(66638, 2880)), fileName = "plot3.png", leg.par = list(), ...){
  pngPlotWithData(data, fileName, function(data){
    with(data,{ 
         meterings = c(Sub_metering_1, Sub_metering_2, Sub_metering_3)
        
         plot(rep(TimeStamp,3), 
              meterings,
              type = "n",
              ylab = "Energy sub metering",
              xlab = "",
              ...)
         
         points(TimeStamp,
                Sub_metering_1,
                type = "l",
                col = "black",
                ...)
         
         points(TimeStamp,
                Sub_metering_2,
                type = "l",
                col = "red",
                ...)
         
         points(TimeStamp,
                Sub_metering_3,
                type = "l",
                col = "blue",
                ...)
         
         do.call(function (...){  
           legend("topright",
                  legend = c("Sub_metering_1",
                             "Sub_metering_2",
                             "Sub_metering_3"),
                  lty = 1,
                  col =  c("black",
                           "red",
                           "blue"),
                  ...
                    )
         }, leg.par)
    })
  })
}
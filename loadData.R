#' Finding subset lines with appropriate dates to read
#'
#' @param fileName filename
#' @param searchDates - vector of character with 10-character dates
#' @param buffsize - buffer size to read
#'
#' @return -vector of indices
dateSubset = function (fileName, searchDates, buffsize = 1000){
  result <- list()
  block <- 0
  con <- file(fileName)
  
  #crafting regex to detect all needed dates
  pasteArgs <- as.list(searchDates)
  pasteArgs$sep <- "|"
  regexVariants <- do.call(paste, pasteArgs)
  regex <- paste("^(", regexVariants, ").*", sep = "")

  open(con)
  
  repeat{
    lines <- readLines(con, n = buffsize)
    if(length(lines) == 0) break
    dates <- substr(lines, 1, 10)
    indexes <- which(grepl(regex, dates))
    result[[length(result) + 1]] = indexes + block
    block <- block + buffsize
  }
  close(con)
  
  do.call(c, result)
}

#' split number range to list of ranges of consecutive numbers
#'
#' @param data number vector 
#'
#' @return list of two-element number vectors, 
#' first element of each vector is the starting number of range
#' second element is the length of range
#' @export
#'
#' @examples
splitToRanges <- function(data = integer()){
  if(length(data) == 0) return(list())
  begin <- prev <- data[1]
  result <- list()
  len <- 1
  for(i in data[2:length(data)]){
    if(i == prev + 1) len <- len + 1
    else {
      result[[length(result) + 1]] <- c(begin, len)
      begin <- i
      len <- 1
    }
    prev <- i
  }
  result[[length(result) + 1]] <- c(begin, len)
  result
}

#' Loading dataset, choosing rows containing only needed dates
#'
#' @param dates character vector in datafile format i.e. 4/12/1995, used when `ranges = "detect"`
#' @param url url for downloading dataset zip
#' @param zipfile name for zip file
#' @param datadir directory to store 
#' @param datafile zipped filename
#' @param ranges could be: 
#' * list, then it's used as list of begin-end intervals of indexes
#' * numeric, then it's used as two-element interval of indexes
#' * "all", then whole file will be used
#' * "detect", then list of integers will be calculated from `dates` parameter
#'
#' @return loaded dataset
loadData <- function(
    dates    = c('2/2/2007',  '1/2/2007'),
    url      =  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
    zipfile  = "power_consumption.zip",
    datadir  = "data",
    datafile = "household_power_consumption.txt",
    ranges   = "detect"
  ){
  if(!file.exists(zipfile)){
    # special treat for windows systems, that could not have curl, but could download https by default
    tryCatch(
      download.file(url, method = "curl", destfile = zipfile ),
      error = function(e) download.file(url, destfile = zipfile))
  }
  
  if(!dir.exists(datadir)){
    unzip(zipfile, exdir = datadir)
  }
  
  datapath <- file.path(datadir, datafile)
  
  ranges <- switch(class(ranges),
                   list = ranges,
                   numeric = list(ranges),
                   character = switch(ranges,
                                      all = list(c(2, -1)),
                                      detect = splitToRanges(dateSubset(datapath, dates))
                                      ))
  
  col.names <- colnames(read.csv(datapath, nrows = 1, sep=";"))

  setClass("ShortDate")
  setAs("character", "ShortDate", function(from) as.Date(from, format="%d/%m/%Y"))
  
  colClasses <- c("ShortDate", "character", rep("numeric", 7))
  
  datas <- lapply(ranges, function(range){
    begin <- range[1]
    size <- range[2]
    dataset<- read.csv(datapath, 
                       header = FALSE,
                       na.strings = "?",
                       col.names = col.names, 
                       skip = begin - 1,
                       nrows = size,
                       colClasses = colClasses,
                       sep = ";")
  })

  joined <- do.call(rbind, datas)
  
  dateStrings <- format(joined$Date, "%Y-%m-%d")
  joined$TimeStamp <- strptime(paste(dateStrings, joined$Time), "%Y-%m-%d %H:%M:%S")
  joined
}


#' Small framework for building plots
#'
#' @param data dataframe or arguments to `loadData` function 
#' @param draw function to draw plot for data
#' @param fileName output PNG file name or NULL to plot on the default device (screen)
#'
#' @return
#' @export
#'
#' @examples
pngPlotWithData <- function(data, fileName, draw){
  data <- switch(class(data),
         list = do.call(loadData, data),
         data.frame  = data
  )

  if(!is.null(fileName)){
    png(fileName)
  }
  
  draw(data)
  
  if(!is.null(fileName)){
    invisible(dev.off())
  }
}
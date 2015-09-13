## Introduction

This assignment uses data from
the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>, a popular repository for machine learning
datasets. In particular, we will be using the "Individual household
electric power consumption Data Set" which I have made available on
the course web site:


* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">Electric power consumption</a> [20Mb]

* <b>Description</b>: Measurements of electric power consumption in
one household with a one-minute sampling rate over a period of almost
4 years. Different electrical quantities and some sub-metering values
are available.


The following descriptions of the 9 variables in the dataset are taken
from
the <a href="https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption">UCI
web site</a>:

<ol>
<li><b>Date</b>: Date in format dd/mm/yyyy </li>
<li><b>Time</b>: time in format hh:mm:ss </li>
<li><b>Global_active_power</b>: household global minute-averaged active power (in kilowatt) </li>
<li><b>Global_reactive_power</b>: household global minute-averaged reactive power (in kilowatt) </li>
<li><b>Voltage</b>: minute-averaged voltage (in volt) </li>
<li><b>Global_intensity</b>: household global minute-averaged current intensity (in ampere) </li>
<li><b>Sub_metering_1</b>: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). </li>
<li><b>Sub_metering_2</b>: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. </li>
<li><b>Sub_metering_3</b>: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.</li>
</ol>

## Notes by student
_`plotN` stands for any of `plot1, plot2, plot3, plot4`_

### Usage

Code consists of loading/reading/plotting utilities collected in the file `loadData.R`

for each plot you could easily
```R 
source(plotN.R)
plotN()
```
And it's should (re)build correct `plotN.png` file.

For advanced usage you could pass custom `fileName` parameter to each `plotN` function or even call 
```R
plotN(fileName = NULL)
```
So the plot will be send to current device.

You could also pass additional parameters for `plot`, `points`, `hist` functions through `plotN` functions

For example you can

```R
plotN(lty = 5)
plotN(lwd = 2)
``` 
and similar

###Loading

For any plot you could pass your own data or customize which dataset ranges will be used.
`loadData` function has few arguments, most notable are `ranges` and `dates`. You could pass them to any data plot as list passed to `data` argument.
`loadData` using special regular expression based date detecting algorithm when `"detect"` is passed to `ranges` algorighm.

So you can
```R
plotN(data = myOwnDataFrame)
plotN(data = list(ranges = c(1000, 2000))) # for using another lines range
plotN(data = list(ranges = list((c(1000,2000), c(3000, 4000))))) # for multiple ranges
plotN(data = list(ranges = "all")) # for whole dataset (very long waiting)
plotN(data = list(dates = "1/12/2008")) #for custom dates
plotN(data = list(dates = "..?/12/2008")) #for whole month
plotN(data = list(dates = c("1/12/2008", "2/12/2008", "3/12/2008")) #for some specific days
plotN(data = list(dates = "(1|2|3)/12/2008") #same as above
```

### Reusing
`plot4` is using `plot2` and `plot3` functions, so you can easily embed customized calls of plots inside your own plots.

## Loading the data

When loading the dataset into R, please consider the following:

* The dataset has 2,075,259 rows and 9 columns. First
calculate a rough estimate of how much memory the dataset will require
in memory before reading into R. Make sure your computer has enough
memory (most modern computers should be fine).

* We will only be using data from the dates 2007-02-01 and
2007-02-02. One alternative is to read the data from just those dates
rather than reading in the entire dataset and subsetting to those
dates.

* You may find it useful to convert the Date and Time variables to
Date/Time classes in R using the `strptime()` and `as.Date()`
functions.

* Note that in this dataset missing values are coded as `?`.


## Making Plots

Our overall goal here is simply to examine how household energy usage
varies over a 2-day period in February, 2007. Your task is to
reconstruct the following plots below, all of which were constructed
using the base plotting system.

First you will need to fork and clone the following GitHub repository:
[https://github.com/rdpeng/ExData_Plotting1](https://github.com/rdpeng/ExData_Plotting1)


For each plot you should

* Construct the plot and save it to a PNG file with a width of 480
pixels and a height of 480 pixels.

* Name each of the plot files as `plot1.png`, `plot2.png`, etc.

* Create a separate R code file (`plot1.R`, `plot2.R`, etc.) that
constructs the corresponding plot, i.e. code in `plot1.R` constructs
the `plot1.png` plot. Your code file **should include code for reading
the data** so that the plot can be fully reproduced. You should also
include the code that creates the PNG file.

* Add the PNG file and R code file to your git repository

When you are finished with the assignment, push your git repository to
GitHub so that the GitHub version of your repository is up to
date. There should be four PNG files and four R code files.


The four plots that you will need to construct are shown below. 


### Plot 1


![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


### Plot 2

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


### Plot 3

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


### Plot 4

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


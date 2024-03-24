#quantmod Demonstration 
library(quantmod)

getSymbols(c("AMZN")) #c() is optional

barChart(AMZN,theme='white.mono',bar.type='hlc')

getSymbols("AAPL",src="yahoo", from="2017-01-01")

barChart(AAPL,theme='white.mono',bar.type='hlc')

head(AAPL) #Apple Stock Price

head(AAPL) 

chartSeries(AAPL, TA=NULL)

#X axis shows Time period, y axis shows Price range 
#TA NUll- Technical Analysis Parameter 

barChart(AAPL)    #barchart
hist(AAPL[,4])	  #Histogram

class(AAPL)       #the object type holding apple data is xts and zoo.

is.OHLC(AAPL)     # Checks whether the xts data object has the open,high, low and close price?

seriesHi(AAPL)    # To check the highest point of price.

dailyReturn(AAPL) # Returns by day  and also weeklyReturn() monthlyReturn()

op <- OpCl(AAPL)  # daily percent change open to close 
head(op)

op <- HiCl(AAPL) #the percent change from high to close
head(op)

AAPL['2019']		#Only for Particular Year
AAPL['2019-01']		#Only for Particular Month
AAPL['2017-01-01::2018-01-01']  # Between Specific Period

#FRED

macrodata <- getSymbols(c('UNRATE','CPIAUCSL','GDPC1'), src="FRED")

macrodata <- merge(UNRATE, CPIAUCSL, GDPC1)

head(macrodata) 

  
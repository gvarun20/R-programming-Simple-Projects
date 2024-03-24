#lubridate package Demo for manipulation of Date

library(lubridate)

ymd("2017-01-31") 		#ymd- Year,Month and Day
#> [1] "2017-01-31"

mdy("January 31st, 2017")	#mdy- Month, Day and Year
#> [1] "2017-01-31"

dmy("31-Jan-2017")		#dmy- Day, Month and Year
#> [1] "2017-01-31"

ymd(20170131)
#> [1] "2017-01-31"

ymd_hms("2017-01-31 20:11:59")
#> [1] "2017-01-31 20:11:59 UTC"

mdy_hm("01/31/2017 08:01")
#> [1] "2017-01-31 08:01:00 UTC"

datetime <- ymd_hms("2016-07-08 12:34:56")

year(datetime)		#year() returns only year from date
#> [1] 2016

month(datetime)		#month() returns only month in number
#> [1] 7

mday(datetime)		#mday() return day in month
#> [1] 8

yday(datetime)		#yday() return day in Year
#> [1] 190

wday(datetime)		#wday() return day in Week
#> [1] 6

month(datetime, label = TRUE)	#month() returns month in words
#> [1] Jul
#> 12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < Sep < ... < Dec

wday(datetime, label = TRUE, abbr = FALSE) 
#> [1] Friday
#> 7 Levels: Sunday < Monday < Tuesday < Wednesday < Thursday < ... < Saturday

begin <- c("May 11, 1996", "September 12, 2001", "July 1, 1988")
end <- c("7/8/97","10/23/02","1/4/91")
class(begin)
## [1] "character"
class(end)
## [1] "character"
(begin <- mdy(begin))
## [1] "1996-05-11" "2001-09-12" "1988-07-01"
(end <- mdy(end))
## [1] "1997-07-08" "2002-10-23" "1991-01-04"
class(begin)
## [1] "Date"
class(end)
## [1] "Date"
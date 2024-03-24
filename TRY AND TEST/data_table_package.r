#The data.table package (Install data.table)

library(data.table)

#read data from csv to r
data = read.csv("flights_2014.csv",header=TRUE)

D_T = as.data.table(data)#convert data into data.table 

print(dim(D_T))   #Prints dimension of Table as rows and column

print(names(D_T)) #Prints Column Names

head(D_T)         #prints first 6 Records from data

# pritn Total arrival delay Time Monthly
res = D_T[ ,sum(arr_delay) , by=month]

print(res)

class(res)  #returns class as data.table and data.frame

#GraphPlot 
plot(res$month,res$V1,type="b",lwd=3,col="blue",
       xlab="Month " , ylab=" Arrival Delay " )


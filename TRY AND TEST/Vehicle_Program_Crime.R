library(data.table)
data = read.csv("Documents/Auto_theft.csv",header=TRUE)
D_T = as.data.table(data) #convert data into data.table 
print(dim(D_T))   #Prints dimension of Table as rows and column
head(D_T)

auto_theft = setkey(D_T[, sum(Auto_Theft_Stolen), by=Sub_Group_Name])
print(auto_theft)
auto_theft= head(auto_theft,5)

auto_recovered = D_T[, sum(Auto_Theft_Recovered),by=Sub_Group_Name]
print(auto_recovered)
auto_recovered=head(auto_recovered,5)
#Vehical Recovered
count <- c(auto_recovered$V1)
barplot(count, main="Vehical Recovered", col=c("darkblue"), legend= rownames(count), names.arg=c("Scooters","Car","Buses","Trucks"," Other"), beside=TRUE )

#Vehical Theft
count <- c(auto_theft$V1)
barplot(count, main="Vehical Theft", col=c("darkblue"), legend= rownames(count), names.arg=c("Scooters","Car","Buses","Trucks"," Other"), beside=TRUE )

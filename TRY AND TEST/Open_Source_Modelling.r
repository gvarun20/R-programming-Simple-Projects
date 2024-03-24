library(quantmod) 

getSymbols(c("AMD","AAPL","CSCO","IBM"))
write.zoo(AAPL,"aapl1.csv",sep=",")
write.zoo(AMD,"amd1.csv",sep=",")
write.zoo(CSCO,"csco1.csv",sep=",")
write.zoo(IBM,"ibm1.csv",sep=",")
#Concatenate Columns of data into one stock dataset.
amd = as.numeric(AMD[,6])
aapl = as.numeric(AAPL[,6])
csco = as.numeric(CSCO[,6])
ibm = as.numeric(IBM[,6])
stkdata = cbind(amd,aapl,csco,ibm)
dim(stkdata)

#Compute Daily Returns This time, we do log returns in continuous-time.
#mean returns are:
n = dim(stkdata)[1]
rets = log(stkdata[2:n,]/stkdata[1:(n-1),])

View(rets)

colMeans(rets)
#Computer covariance matrix 
cv = cov(rets)
print(cv,2)
#computer correlation matrix
cr= cor(rets)
print(cr,2)

#Create 4x3 Matrix with random numbers as follow
x=matrix(rnorm(12),4,3)
x
#Transposing the matrix
print(t(x),3)
#matrix Multiplication
print(t(x) %*% x,3)
print(x %*% t(x),3)
#taking the Inverse of the covariance matrix
cv_inv = solve(cv)
print(cv_inv,3)
#checking inverse
print(cv_inv %*% cv,3)  #Results in Identity Matrix
library(corpcor)
#Covariance matrix should be Positive definite
is.positive.definite(cv)      #True
is.positive.definite(x)       #error
is.positive.definite(x %*% t(x))  #False

#Descriptive Statistics

data = read.csv("amd1.csv", header=TRUE)  #Read in the data
n = dim(data)[1]
n
data = data[n:1,]
dim(data)
s = data[,7]
View(s)
#Compute daily returns, and then convert those returns into annualized returns
rets =log(s[2:n]/s[1:(n-1)])
rets[1]

rets_annual = rets * 252     #252 No. of working days of share market
print(c(mean(rets), mean(rets_annual)))

#Compute daily and annualized standard deviation of returns.

r_sd =sd(rets)
r_sd_annual = r_sd * sqrt(252)
print(c(r_sd, r_sd_annual))

print(sd(rets*252))   #stdev of annualized returns

print(sd(rets*252))/252

print(sd(rets*252))/sqrt(252)

#variance
r_var = var(rets)
r_var_annual = var(rets)*252
print(c(r_var, r_var_annual))


#Higher_order Moments

library(moments)

skewness(rets)

kurtosis(rets)

#For the Normal Distribution, skewness is zero & Kurtosis is 3.

skewness(rnorm(1000000))

kurtosis(rnorm(1000000))
  
# Brownian Motions with R

#Computes the annualized  volatility sigma
h= 1/252
sigma = sd(rets)/sqrt(h)
sigma

# Parameter mu

mu = mean(rets)/h+0.5*sigma^2
mu

#Estimation using maximum-likelihood

#First create log-likehood function
LL = function(params, rets){
  alpha = params[1]; sigsq = params[2]
  logf = -log(sqrt(2*pi*sigsq))-(rets-alpha)^2/(2*sigsq) 
  LL = -sum(logf)}

#MLE using nlm(non-linear minimization)
#create starting guess for parameters

params = c(0.001,0.001)
res = nlm(LL,params,rets)
res

# manipulate reults to get annualized parameters  mu and sigma

alpha = res$estimate[1]
sigsq = res$estimate[2]
sigma = sqrt(sigsq/h)
sigma

mu = alpha/h + 0.5*sigma^2
mu


#Monte Carlo

n=252
so=100
mu=0.10
sig=0.20
s=matrix(0,1,n+1)
h=1/n
s[1] = so

for(j in 2:(n+1)){
  s[j]=s[j-1]*exp((mu-sig^2/2)*h+sig*rnorm(1)*sqrt(h))
}
s[1:5]

s[(n-4):n]

plot(t(s),type="l")  #type l indicates lines

#Regression
#Example: AMD, AAPL, CSCO, IBM

dim(rets)   #dimesnsion as 3151 4
Y= as.matrix(rets[,1])
X= as.matrix(rets[,2:4])

n=length(Y)
X=cbind(matrix(1,n,1),X)
b=solve(t(X) %*% X) %*% (t(X) %*% Y)
b


X=as.matrix(rets[,2:4])
res=lm(Y~X)   #Simple linear regression as lm as linear Model.
summary(res)



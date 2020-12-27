#Below is what I actualy used in our report to the carrots

library(prophet)
library(quantmod)
library(forecast)
library("xlsx")
library(tseries)
library(timeSeries)
library(dplyr)
library(fGarch)

#daily value data
dji.daily<-read.csv("C:\\Users\\Josh\\Documents\\Grad School\\Statistics\\Final Project\\dji_d.csv")
dji.daily.ts <-ts(dji.daily$Open, start=1896, end=2020, frequency=253)
plot(dji.daily.ts)

#weekly value data
dji.weekly<-read.csv("C:\\Users\\Josh\\Documents\\Grad School\\Statistics\\Final Project\\dji_WEEKLY.csv")
dji.weekly.ts <-ts(dji.weekly$Average, start=1896, end=2020, frequency=52)
plot(dji.weekly.ts)

dji.daily.ts <- window(dji.daily.ts, start=2015, end=2020)
plot(dji.daily.ts)
dji.weekly.ts <- window(dji.weekly.ts, start=2015, end=2020)
plot(dji.weekly.ts)

print(adf.test(dji.daily.ts))
print(adf.test(dji.weekly.ts))

acf(dji.daily.ts)
pacf(dji.daily.ts)
acf(dji.weekly.ts)
pacf(dji.weekly.ts)

daily.arima.model <- auto.arima(dji.daily.ts, lambda = "auto")
weekly.arima.model <- auto.arima(dji.weekly.ts, lambda = "auto")

daily.arima.model
weekly.arima.model

plot(daily.arima.model$residuals)
plot(weekly.arima.model$residuals)

mean(daily.arima.model$residuals)
mean(weekly.arima.model$residuals)

hist(daily.arima.model$residuals)
hist(weekly.arima.model$residuals)

tsdiag(daily.arima.model)
tsdiag(weekly.arima.model)

Box.test(daily.arima.model$residuals, lag= 10, type="Ljung-Box")
Box.test(weekly.arima.model$residuals, lag= 6, type="Ljung-Box")

Box.test(daily.arima.model$residuals, type="Ljung-Box")
Box.test(weekly.arima.model$residuals, type="Ljung-Box")

daily.forecast <- forecast(daily.arima.model, h=30)
weekly.forecast <- forecast(weekly.arima.model, h=4)

plot(daily.forecast, include=250)
plot(weekly.forecast, include=75)

head(daily.forecast$mean)
head(weekly.forecast$mean)

head(daily.forecast$upper)
head(weekly.forecast$upper)

head(daily.forecast$lower)
head(weekly.forecast$lower)














#^^^^^^^^^^^^^^^^^^^^^^^^What I actually used in the report


#Create test and training data
dji_d.train <- window(dji_d.ts, start=2018, end=2019)
dji_d.test <-  window(dji_d.ts, start=2019, end=c(2020,1))

plot(dji_d.train)
lines(ma(dji_d.train,order=3),col="red")

#creating all the models
mean_model <- meanf(dji_d.train, h=10)
naive_model <- naive(dji_d.train, h=10)#h= horizon or the number of forecasts we want to make in the future. in our case 1 cause we want to forecast one day
drift_model <- rwf(dji_d.train, h=10, drift = T)
seasonal_naive_model <- snaive(dji_d.train, h=10)

#plotting the models
plot(mean_model, plot.conf = F, main ="")
lines(naive_model$mean, col=3, lty=1)
lines(drift_model$mean, col=2, lty=1)
lines(seasonal_naive_model$mean, col=6, lty=1)
legend("topleft", lty=1, col=c(1,3,2,6), legend=c("Mean Method", "Naive Method", "Drift Method", "Seasonal Naive Method"))

plot(seasonal_naive_model, plot.conf=F,main="")
lines(dji_d.test, col=7,lty=1,lwd=3)

#checking the accuracy of the models
accuracy(mean_model, dji_d.test)
accuracy(naive_model, dji_d.test)
accuracy(drift_model, dji_d.test)
accuracy(seasonal_naive_model, dji_d.test)


plot(decompose(dji_d.ts))


#^^^^^^^^^^^^^^^^^^^^^Time Series^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^





#====================ARIMA=========================================
dji_d.ts <-ts(dji_d$Open, start=2000, end=2019, frequency=250)
plot(adf.test(dji_d$Open))
adf.test(dji_d.ts)
plot(dji_d.ts)

#Uses the auto.arima function to get the auto arima model
autoarima1 <- auto.arima(dji_d.ts)
autoarima1
#Get the forecasted data for the time series
forecast1 <- forecast(autoarima1, h=5)#what would I set h equal to?
forecast1
plot(forecast1)

#plot the residuals over time to see congruence or variance
plot(forecast1$residuals)#Seems we have a lot of variance

#plot the residuals
qqnorm(forecast1$residuals)

acf(forecast1$residuals)
pacf(forecast1$residuals)

summary(autoarima1)
accuracy(autoarima1)























# KNN model can be used for both classification and regression problems. The most popular application is to use it for classification problems.
# Here we use the tsfknn package with h = 30 and get a forecast 30 days in the future of DJI. The accuracy is shown and plots show the forecast.
if(!require(tsfknn)) install.packages("tsfknn")
library(tsfknn)
library(ggplot2)


# Reading the data
dji_d<-read.csv("C:\\Users\\ashah\\Documents\\dji_d.csv")

# creating time series of opening price for DJ1
dji_d.ts <-ts(dji_d$Open, start=2010, end= 2019, frequency= 250)

# KNN forecast - 
predknn <- knn_forecasting(dji_d.ts, lags = 1 : 30, h = 30, k = 40, msas = "MIMO")
ro <- rolling_origin(predknn)

# showing the accuracy
print(ro$global_accu)


#plotting the  graph
autoplot(predknn, highlight = "neighbors", faceting = FALSE)

#Create a second time series with a small time gap for a better visualization 
timeS <- window(dji_d.ts, start = 2018, end = 2019)
pred <- knn_forecasting(timeS, lags = 1 : 30, h = 30, k = 40, msas = "MIMO")
ro2 <- rolling_origin(pred)

# showing accuracy for 1 year time period and forecast of 30 days 
print(ro2$global_accu)

# Plot second graph
autoplot(pred, highlight = "neighbors", faceting = FALSE)

pt.data <- data.frame(
  id = c (1:6), 
  name = c("Jack","Lane","Terry","Claire","Jessica", "Ted"),
  Age = c(35,21,31,26,24,12)
, stringsAsFactors = FALSE)
pt.data[1:2,]
pt.data[c(3,5),c(1,3)]
pt.data <- cbind(pt.data,Salary=c(10.11,23.11,33.11,41.23,9.23,50.11))
pt.data <- rbind(pt.data,list(7,"Tom",40,0.01))

//============================================================

usedcars.data <-read.csv("usedcars.csv")
str(usedcars.data)
summary(usedcars.data$price)
maxprice <-max(usedcars.data$price)
minyear <-min(usedcars.data$year)
autocars <- usedcars.data[usedcars.data$transmission == 'AUTO', ]
manualcars <- usedcars.data[usedcars.data$transmission == 'MANUAL', ]
averageautocardprice <- ave(autocars$price)
averagemanualcardprice <- ave(manualcars$price)
cheaper <-c()
yearssince <-c()
lessthanaverageprice <-c()
for (i in 1:length(usedcars.data$price)) {
  cheaper[i] <- maxprice - usedcars.data$price[i]
  yearssince[i] <- usedcars.data$year[i] - minyear
  if(usedcars.data$transmission[i] == "AUTO")
  {
    if(usedcars.data$price[i] <= averageautocardprice)
    {
      lessthanaverageprice[i] <- TRUE
    }
    else
    {
      lessthanaverageprice[i] <- FALSE
    }
  }
  else
  {
    if(usedcars.data$price[i] <= averagemanualcardprice)
    {
      lessthanaverageprice[i] <- TRUE
    }
    else
    {
      lessthanaverageprice[i] <- FALSE
    }
  }
}
usedcars.data[,"cheaper"] <- cheaper
usedcars.data[,"yearssince"] <- yearssince
usedcars.data[,"lessthanaverageprice"] <-lessthanaverageprice
# plots
library(gmodels)
hist(usedcars.data$price,main = "Histogram of Price", xlab = "Price", breaks = 20)
boxplot(usedcars.data$price, main="Boxplot of Price", ylab = "Price")
a <-"Year since"
b <- toString(minyear)
c <-"vs Amount cheaper"
title <- paste(a,b,c)
plot(x=usedcars.data$yearssince,y=usedcars.data$cheaper,main=title, xlab="Year(mile)", ylab = "Amount Cheaper($)")
CrossTable(usedcars.data$lessthanaverageprice, y=usedcars.data$transmission)
CrossTable(usedcars.data$color, y=usedcars.data$transmission)
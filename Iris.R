iris <- read.csv("iris.csv")
str(iris)
table(iris$sepal.length)
table(iris$sepal.width)
table(iris$petal.length)
table(iris$petal.width)
table(iris$variety)
summary(iris$sepal.length)
summary(iris$sepal.width)
summary(iris$petal.length)
summary(iris$petal.width)
set.seed(231)
#51231,140
#51231,100
#51231
train_sample <- sample(150, 135)
str(train_sample)
iris_train <- iris[train_sample,]
iris_test <- iris[-train_sample,]
prop.table(table(iris_train$variety))

library(C50)
iris_model <- C5.0(iris_train[-5],iris_train$variety)
iris_model
summary(iris_model)
iris_predict <- predict(iris_model, iris_test)
iris_predict
library(gmodels)
CrossTable(iris_test$variety, iris_predict, prop.chisq =  FALSE, prop.c = FALSE, prop.r = FALSE, dnn= c('actual variety','predicted variety'))
summary(iris_predict)
iris_boost10 <- C5.0(iris_train[-5],iris_train$variety, trials = 100)
iris_boost10
summary(iris_boost10)
iris_boost_predict10 <- predict(iris_boost10, iris_test)
CrossTable(iris_test$variety, iris_boost_predict10, prop.chisq =  FALSE, prop.c = FALSE, prop.r = FALSE, dnn= c('actual variety','predicted default'))
Versicolor <- subset(iris, variety == "Versicolor")
summary(Versicolor$sepal.length)
summary(Versicolor$sepal.width)
summary(Versicolor$petal.length)
summary(Versicolor$petal.width)
Virginica  <- subset(iris, variety == "Virginica")
summary(Virginica$sepal.length)
summary(Virginica$sepal.width)
sumary(Virginica$petal.length)
summary(Virginica$petal.width)
matrix_dimensions <-list(c("Setosa","Versicolor","Virginica"),c("Setosa","Versicolor","Virginica"))
names(matrix_dimensions) <- c("predicited","actual")
matrix_dimensions
error_cost <- matrix(c(0,0,0,0,0,5,0,0,1), nrow =3, dimnames = matrix_dimensions)
error_cost
iris_cost <- C5.0(iris_train[-5],iris_train$variety, costs  = error_cost)
iris_cost_pred <- predict(iris_cost, iris_test)
summary(iris_cost)
CrossTable(iris_test$variety, iris_cost_pred, prop.chisq =  FALSE, prop.c = FALSE, prop.r = FALSE, dnn= c('actual variety','predicted default'))

library(arules)
plants <-read.transactions("plants.csv", sep = ",")
summary(plants)
itemFrequencyPlot(plants, support = 0.15)
itemFrequencyPlot(plants, topN = 20)
apriori(plants)
freq_is <- apriori(plants, parameter = list(target = "frequent itemsets", support=0.0731))
inspect(sort(freq_is, by="support"))
inspect(sort(freq_is, decreasing=FALSE,by="support"))
name_rule <-apriori(plants,parameter = list(support=0.1, confidence=0.1,minlen=2 ))
summary(name_rule)
inspect(sort(name_rule, by="confidence"))
inspect(sort(name_rule, by="lift"))
inspect(sort(name_rule, by="support"))

# Add library moments for skewness and kurtosis calculations
library(moments)

# Calculate mean for each numeric column in the iris dataset
mean_sepal_length <- mean(iris$sepal.length)
mean_sepal_width <- mean(iris$sepal.width)
mean_petal_length <- mean(iris$petal.length)
mean_petal_width <- mean(iris$petal.width)

# Calculate variance for each numeric column in the iris dataset
var_sepal_length <- var(iris$sepal.length)
var_sepal_width <- var(iris$sepal.width)
var_petal_length <- var(iris$petal.length)
var_petal_width <- var(iris$petal.width)

# Calculate skewness for each numeric column in the iris dataset
skewness_sepal_length <- skewness(iris$sepal.length)
skewness_sepal_width <- skewness(iris$sepal.width)
skewness_petal_length <- skewness(iris$petal.length)
skewness_petal_width <- skewness(iris$petal.width)

# Calculate kurtosis for each numeric column in the iris dataset
kurtosis_sepal_length <- kurtosis(iris$sepal.length)
kurtosis_sepal_width <- kurtosis(iris$sepal.width)
kurtosis_petal_length <- kurtosis(iris$petal.length)
kurtosis_petal_width <- kurtosis(iris$petal.width)

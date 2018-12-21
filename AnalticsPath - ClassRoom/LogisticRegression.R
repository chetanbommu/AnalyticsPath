## Class Room coding by @Srinath
titanic = read.csv("Files:Data/titanic.csv")
columnsToUse = c("pclass","survived","sex","age","sibsp","parch","fare","cabin","embarked","home_dest")
dataset_titanic = titanic[,columnsToUse]

## check summary
summary(dataset_titanic)

## too many missing values in cabin and home_dest, so we are dropping those columns
dataset_titanic$cabin=NULL
dataset_titanic$home_dest=NULL

## KNN Inputation
# install.packages("DMwR")
library(DMwR)

dataset_titanic = knnImputation(dataset_titanic, k=3)
summary(dataset_titanic)

## correlation
library(corrplot)
corrplot(cor(dataset_titanic[,c("age","fare","sibsp","parch","pclass")]),method = "number")

## Chi-Square test
chisq.test(dataset_titanic$pclass,dataset_titanic$fare)

chisq.test(dataset_titanic$sex, dataset_titanic$embarked)
dataset_titanic$embarked=NULL

## Train Test Split
nrows = 1:nrow(dataset_titanic)
trainRows = sample(nrows,round(0.7*nrow(dataset_titanic)))
trainData = dataset_titanic[trainRows,]
testData = dataset_titanic[-trainRows,]

## Model
logistic_model = glm(survived~.-parch-fare, 
                     data=trainData,
                     family = binomial(link = "logit"))

summary(logistic_model)

preds = predict(logistic_model, testData, type= 'response')

## Confusion Matrix
preds = ifelse(preds > 0.5, 1, 0)
table(testData$survived, preds, dnn=c('acts','preds'))

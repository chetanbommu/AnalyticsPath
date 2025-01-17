## Decicion Tree - Classfication
## dataset used: universalBank.csv

## load data
dataset = read.csv('Files:Data/universalBank.csv')

## Data Pre-processing
dataset$ID = NULL
dataset$Experience = NULL
dataset$ZIP.Code = as.factor(dataset$ZIP.Code)

dataset$Personal.Loan = as.factor(dataset$Personal.Loan)
dataset$CD.Account = as.factor(dataset$CD.Account)
dataset$Online = as.factor(dataset$Online)
dataset$CreditCard = as.factor(dataset$CreditCard)
dataset$Securities.Account = as.factor(dataset$Securities.Account)

dataset$ZIP.Code = NULL

summary(dataset)
str(dataset)

## Split training and test data
library(caTools)
set.seed(123)
split = sample.split(dataset, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

## Build a Decision Tree classifier
# install.packages("rpart")
library(rpart)
decision_tree_classifier = rpart(Personal.Loan~.,data = training_set)
decision_tree_classifier ## Shows nodes of a tree

decision_tree_classifier = rpart(Personal.Loan~.,data = training_set, control = c(cp=0.001L))
plotcp(decision_tree_classifier) ## choose a cp value using graph

decision_tree_classifier = rpart(Personal.Loan~.,data = training_set, 
                                 control = rpart.control(minsplit = 15, maxdepth = 6, minbucket = 5, cp = 0)) ## override default value of cp 

# install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(decision_tree_classifier)

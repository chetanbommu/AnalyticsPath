## load data
dataset = read.csv('/Users/chetanbommu/Documents/Analtics Path Files/Files:Data/universalBank.csv')

summary(dataset)
dataset = dataset[,10:14]

str(dataset)

dataset$Personal.Loan = ifelse(dataset$Personal.Loan == 0, NA, dataset$Personal.Loan)
dataset$Securities.Account = ifelse(dataset$Securities.Account == 0, NA, dataset$Securities.Account)
dataset$CD.Account = ifelse(dataset$CD.Account == 0, NA, dataset$CD.Account)
dataset$Online = ifelse(dataset$Online == 0, NA, dataset$Online)
dataset$CreditCard = ifelse(dataset$CreditCard == 0, NA, dataset$CreditCard)

## convert every column into factor
for(i in 1:ncol(dataset)){
  dataset[,i] = as.factor(dataset[,i])
}

install.packages('arules')
library(arules)
# as => Coerce an object to a given class.
dataset_transactions = as(dataset,'transactions')
head(dataset_transactions)
inspect(head(dataset_transactions))

## Build a model either with rules or frequent items set
# 1. rules
rules = apriori(dataset_transactions, parameter = list(supp = 0.01, confidence = 0.8, target = 'rules'))
inspect(rules)
rules_dataframe = as(rules, 'data.frame')
  # Subsetting Rules
rules_subset = subset(rules, subset = rhs %pin% "CD.Account")
inspect(rules_subset)

# 2. Frequent Item set
frequent_items = apriori(dataset_transactions, parameter = list(supp = 0.01, confidence = 0.8, target = ''))
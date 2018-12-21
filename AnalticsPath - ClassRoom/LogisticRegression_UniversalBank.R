## Read data
bankdata = read.csv('Files:Data/universalBank.csv')

## Train Test Split
nrows = 1:nrow(bankdata)
trainRows = sample(nrows,round(0.8*nrow(bankdata)))
trainData = bankdata[trainRows,]
testData = bankdata[-trainRows,]

## Building a Model 
logistic_model_bank = glm(Personal.Loan~., data = trainData, family = binomial(link="logit"))
summary(logistic_model_bank)

## Confusion Matrix
preds_bank = predict(logistic_model_bank, testData, type = 'response')
preds_bank = ifelse(preds_bank>0.5, 1, 0)
table(testData$Personal.Loan, preds_bank, dnn=c('actual','predicted'))

## Columns which are Signficant
columnsToUse_bank = c('Income','Family','CCAvg','Education','CD.Account','Online','CreditCard','Securities.Account','Personal.Loan')

dataset_bank = bankdata[,columnsToUse_bank]

## Train Test Split
nrows = 1:nrow(dataset_bank)
trainRows = sample(nrows, 0.8*nrow(dataset_bank))
trainData = dataset_bank[trainRows,]
testData = dataset_bank[-trainRows,]

## Building a Model
logistic_model_bank = glm(Personal.Loan~., data = trainData, family = binomial(link = "logit"))
summary(logistic_model_bank)

## Predicting values
preds = predict(logistic_model_bank, testData, type = 'response')

## Confusion Matrix
preds = ifelse(preds>0.5, 1, 0)
table_bank = table(testData$Personal.Loan, preds, dnn = c('actual','predicted'))
recall_bank = table_bank[2][2] / (table_bank[1][2] + table_bank[2][2])
precision_bank = table_bank[2][2] / (table_bank[2][1] + table_bank[2][2])
f1_score = 2 * recall_bank * precision_bank / (recall_bank + precision_bank)
  

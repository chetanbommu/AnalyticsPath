Credit
Credit$purpose = ifelse(Credit$purpose == 'car0','car',Credit$purpose)

Credit$purpose[as.character(Credit$purpose)== 'car0'] = 'car'
as.factor(Credit$purpose)

head(Credit)
head(Credit$purpose,10)
#Univariate Analysis on default columns
barplot(table(Credit$default), col = c('red','green'), main = "Bar Chart of Loan Defaultters")

barplot(table(Credit$default,Credit$purpose),col = c('red','green'))

library(ggplot2)

## Stacker bar chart
## Purpose vs default => furniture/appliances & cars more
ggplot(data = Credit,aes(x=purpose,fill=default)) + geom_bar()
ggplot(data = Credit,aes(x=purpose,fill=default)) + geom_bar(position = 'fill') ## almost same default rate
ggplot(data = Credit,aes(x=purpose,fill=default)) + geom_bar(position = 'fill') + facet_grid(.~job)

## Job vs default => almost same default but management people defaultted more
ggplot(data = Credit,aes(x=job,fill=default)) + geom_bar(position = position_stack(reverse = TRUE))
ggplot(data = Credit,aes(x=job,fill=default)) + geom_bar()
ggplot(data = Credit,aes(x=job,fill=default)) + geom_bar(position = 'fill')

## savings_balance vs default => <100DM & 100-500 DM are more defaultters
ggplot(data = Credit,aes(x=savings_balance,fill=default)) + geom_bar()
ggplot(data = Credit,aes(x=savings_balance,fill=default)) + geom_bar(position = 'fill')

## months_loan_duration vs default =>more chance for default if loan duration > 20-24
ggplot(data = Credit, aes(x=months_loan_duration, fill = default)) + geom_bar()
ggplot(data = Credit, aes(x=months_loan_duration, fill = default)) + geom_bar(position = 'fill')

## credit_history vs default 
ggplot(data = Credit, aes(x=credit_history, fill = default)) + geom_bar()

ggplot(data = Credit, aes(x=default, fill = housing)) + geom_bar()
ggplot(data = Credit, aes(x=default, fill = housing)) + geom_bar(position = 'fill')
ggplot(data = Credit, aes(x=housing, fill = default)) + geom_bar(position = 'fill')
ggplot(data = Credit, aes(x=default,y=age)) + geom_boxplot()

ggplot(data = Credit, aes(months_loan_duration,amount,col = default)) + geom_jitter()


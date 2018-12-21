## verifying 
Churn

## load Churn.csv into cust_data
cust_data = Churn

cust_data$Churn
## Shows frequency
table(cust_data$Churn)
## shows probability
prop.table(table(cust_data$Churn))

?barplot

## Uni-Variante on discrete variable => Bar chart
barplot(table(cust_data$Churn),col = c('red','black'),
        main = 'Bar Chart for Churn',
        xlab = 'Churn',
        ylab = 'Frequency')
barplot(prop.table(table(cust_data$Churn)))

## Uni-Variante on continuous variable  => Histogram
cust_data$Day_Mins
summary(cust_data$Day_Mins)
hist(cust_data$Day_Mins)
hist(cust_data$Day_Mins, breaks = 5)

## Box Plot
boxplot(cust_data$Day_Mins)


## two numberic var
plot(cust_data$Day_Mins, cust_data$Night_Mins)
plot(cust_data$Day_Mins, cust_data$Day_Charge)
cor(cust_data$Day_Mins, cust_data$Day_Charge)


## pie chart
a = pie(table(cust_data$Churn), col = c('black','red'), main = "Pie Chart of Churn")


boxplot(cust_data$Day_Mins, cust_data$Churn) ## separate plots
boxplot(cust_data$Day_Mins ~ cust_data$Churn)  

## Stacked bar plot
table(cust_data$Churn,cust_data$Intl_Plan,dnn=c("Churn","Intl.Plan"))
barplot(table(cust_data$Churn,cust_data$Intl_Plan),col  = c('red','blue'))

## ggplot2
install.packages('ggplot2')
library(ggplot2)

data(mpg)
head(mpg)
mpg = as.data.frame(mpg)

ggplot(data = mpg, aes(cty), geom) + geom_histogram()
ggplot(data = mpg, aes(cty), geom) + geom_histogram(bins = 10)

ggplot(data = mpg, aes(x= manufacturer, fill=drv)) + geom_bar()

head(Churn_MV)


setwd("/Users/chetanbommu/Documents/Analtics Path Files/CapStone/")
Churn_MV = read.csv("Churn_MV.csv")

str(Churn_MV)


#target variables
#1. Churn
#2. Day Calls
# models
## Classification
## Prediction

#convert numeric to categorical/factors
Churn_MV$Churn = as.factor(Churn_MV$Churn)
Churn_MV$Intl.Plan = as.factor(Churn_MV$Intl.Plan)
Churn_MV$Area.Code = as.factor(Churn_MV$Area.Code)
Churn_MV$VMail.Plan = as.factor(Churn_MV$VMail.Plan)

#find NA in each column
summary(Churn_MV)

# replace NAs
# NAs are placed on alternated rows
# remove the columns, where target value is null, we dont impute target variables
churn = Churn_MV
head(churn)

#1st approach
churn = Churn_MV [ seq(2,nrow(Churn_MV),2),]

#2nd approach
ch1 <- Churn_MV[is.na(Churn_MV$Churn) == FALSE,]

mean(ch1$Day.Charge)
median(ch1$Day.Charge)

ch1$dc_mean = ch1$Daily.Charges.MV
ch1$dc_median = ch1$Daily.Charges.MV

## Imputations with mean and median
ch1$dc_mean = ifelse(is.na(ch1$dc_mean), mean(ch1$dc_mean, na.rm = T), ch1$dc_mean)
ch1$dc_median = ifelse(is.na(ch1$dc_median), median(ch1$dc_median, na.rm = T), ch1$dc_median)

## RMSE function
rmse = function(m,x) {
  sqrt(mean((m-x)^2))
}

## RMSE calculations
rmse(ch1$dc_mean, ch1$Day.Charge)  ## 1.50565
rmse(ch1$dc_median, ch1$Day.Charge)  ## 1.506297

#mean seems to better approach
boxplot(ch1$dc_mean)
boxplot(ch1$Night.Calls)
boxplot(ch1$Night.Charge)
boxplot(ch1$Eve.Calls)
boxplot(ch1$Intl.Calls)

## Adjusting outliers 
## values lying outside 1.5*IQR will be replaced with 5th %ile on upper side, 95th %ile on the lower side
dc <- ch1$dc_mean
qnt <- quantile(dc, probs = c(0.25,0.75))
cap <- quantile(dc, probs = c(0.05, 0.95))
h <- IQR(dc)

ch1$dc_mean[ch1$dc_mean < (qnt[1] - h)] <- cap[1]
ch1$dc_mean[ch1$dc_mean < (qnt[2] - h)] <- cap[2]

boxplot(ch1$dc_mean)

## Adjusting outliers for DC Mean
low = qnt[1]-(1.5*h)
top = qnt[2]+(1.5*h)
ch1 = ch1[(ch1$dc_mean < qnt[2]+(1.5*h)) & (ch1$dc_mean > qnt[1]-(1.5*h)) ,]

## Scaling

## Split into two buckets i.e.,Numerical And Categorical
ch1_num <- ch1[unlist(lapply(ch1, is.numeric))]
ch1_cat <- ch1[unlist(lapply(ch1, is.factor))]
      ## or
ch1_categorical = ch1[,c("Churn","Intl.Plan","VMail.Plan","State","Area.Code","Phone")]
ch1_numerical = ch1[,-which(names(ch1) %in% c(names(ch1_categorical),"Daily.Charges.MV"))]

min_max = function(dataset){
  return (dataset - min(dataset))/(max(dataset) - min(dataset))
}

## Scaling
ch1_numerical_Z_scale = as.data.frame(scale(ch1_numerical))
ch1_numerical_MinMax = min_max(ch1_numerical)

summary(ch1_numerical)

## Correlation
cor(ch1_numerical_Z_scale)

## Correlation Plot Package
# install.packages("corrplot") 
library(corrplot)
?corrplot

corrplot(cor(ch1_numerical_Z_scale))

## We are done with correlation and find out *.Calls, *.Charge are correlated.
## Next use EDA and decide which column needs to be considered/removed
ch1_after_correlation = cbind(ch1_numerical_Z_scale,ch1_categorical)
boxplot(ch1_after_correlation$Day.Mins,ch1_after_correlation$Churn)


## chi-square => To find correlation b/w categorical variables
?chisq.test
chisq.test(table(ch1_categorical$VMail.Plan, ch1_categorical$Intl.Plan))


## Anova => To find correlation b/w Numerical and Categorical
ch1_after_correlation = cbind(ch1_numerical_Z_scale,ch1_categorical)

str(ch1_after_correlation)

summary(aov(dc_mean~Intl.Plan, data = ch1_after_correlation))
aov(dc_mean~Intl.Plan, data = ch1_after_correlation)


## Remove Churn, Daily_charges.MV, State, Area Code, Phone + 4 cols of correlation 
## i.e, Night Charges, Day Charges, Intl Charges, Eve Charges
##  CustServ Calls => Target for Linear Regression
## Churn => Target for Classification(Logistic Regression)


churn_default = read.csv("Churn_MV.csv")  ## Churn as it is
churn_z_scaled = cbind(ch1_numerical_Z_scale,ch1_categorical) ## Z-scaled churn
churn_min_max = cbind(ch1_numerical_MinMax,ch1_categorical)  ## Min-Max Scaled churn


## 1. EDA with 1 inferential stat
## 2. which technique is best for Scaling ? Min Max/ Z Score / Linear Regression
## 3. Which Sampling is working good ?
## 4. RMSE when you run linear regression for cust serv calls 
## 5. Null imputation using Linear Regrssion
library(ggplot2)
summary(churn_z_scaled)
summary(churn_min_max)

chisq.test(table(ch1_categorical$Area.Code, ch1_categorical$VMail.Plan))

churn_min_max$Area.Code = NULL
churn_min_max$State = NULL
churn_min_max$Phone = NULL
churn_min_max$Day.Charge = NULL
churn_min_max$Night.Charge = NULL
churn_min_max$Eve.Charge = NULL
churn_min_max$Intl.Charge = NULL

churn_min_max$Daily.Charges.MV = churn$Daily.Charges.MV
## ToDo - EDA

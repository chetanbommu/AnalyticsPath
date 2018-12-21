head(Churn_MV)

setwd("/Users/chetanbommu/Downloads/")
Churn_MV = read.csv("Churn_MV.csv")

str(Churn_MV)


#target variables
#1. Churn
#2. Day Calls
#models
##Classification
##Prediction

#convert numeric to categorical/factors
Churn_MV$Churn = as.factor(Churn_MV$Churn)
Churn_MV$Intl.Plan = as.factor(Churn_MV$Intl.Plan)
Churn_MV$Area.Code = as.factor(Churn_MV$Area.Code)
Churn_MV$VMail.Plan = as.factor(Churn_MV$VMail.Plan)

#find NA in each column
summary(Churn_MV)

#replace NAs
#NAs are placed on alternated rows
#remove the columns, where target value is null, we dont impute target variables
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
ch1 = ch1[(ch1$dc_mean < qnt[2]+(1.5*h)) & (ch1$dc_mean > qnt[1]-(1.5*h)) ,]

## Scaling

## Split into two buckets i.e.,Numerical And Categorical
ch1_num <- ch1[unlist(lapply(ch1, is.numeric))]
ch1_cat <- ch1[unlist(lapply(ch1, is.factor))]

min_max = function(dataset){
  return (dataset - min(dataset))/(max(dataset) - min(dataset))
}

ch1_num_Z_scale = as.data.frame(scale(ch1_num))
ch1_num_MinMax = min_max(ch1_num)

summary(ch1_num)


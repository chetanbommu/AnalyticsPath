## Dataset being used is "train.csv" unless explicitly specified
## 1.	How do we convert "4+" in "Stay_in_current_city_years" variable  to a value of 4?
## 2.	How many rows exist with a marital_status = 0?
## 3.	How many rows exist within the age_group of "26-35" with a marital status =0?
## 4.	How many distinct users exist within the age_group of "26-35" with a marital status =0?
## 5.	How many distinct age groups exist?
## 6.	How many distinct User_IDs exist?
## 7.	Which product_ID occurs the most frequently?
## 8.	What is the average purchase rate of gender = f & gender = m?
## 9.	What is the average value of purchase when gender = f or age_group = "0-17"
## 10.	What is the average value of purchase within the odd rows of train.csv?
## 11.	create a new dataset (train2) that does not have any row in train.csv that has  missing value
## 12.	In which city_category do most of the users within age group "0-17" live?
## 13.	For how many rows is "Product_category_2" missing a value?
## 14.	Which value of "Product_category_1" occurs the most whenever product_category_2 value is missing?
## 15.	Of all the users that exist in "test.csv", how many of them, also exist in "train.csv"
## 16.	Of all the users in "train.csv" how many of them also exist in "test.csv"
## 17.	What is the average purchase of customers who exist in "train.csv" but not in "test.csv"
## 18.	How many distinct combinations of "user_id" & "Product_id" are available in train.csv?
## 19.	Among all the variables from "Gender" to "Product_Category_3":
      ## A)	Calculate the average purchase rate for all the distinct values of each variable
      ## B)	identify the variable that has the highest lift in purchase rate
          ## (For example, if city has 3 distinct values (A,B,C) with average purchase rate of 	100,200,300 & overall average of 200 - lift is (300/200 - 100/200) 
          ##   i.e., (highest average value/ overall average purchase - lowest average value/ 	overall average purchase)
## 20.	Write a function that takes variable name as input & gives out the frequency of occurrence table of the distinct values of the variable
## 21.	Write a function that takes variable name & creates dummy variables:
      ## For example, if we give age as input to the function, then the function creates 7 	distinct 	columns named Age_0-17, Age_55+ so on.,
      ## For each of the 7 columns, it gives a value of 1 to the row if the value belongs to the 	column - i.e., Age_0-17 will be 1 only if Age = "0-17" else it is a 0.
  

## loading
Train
colnames(Train)
Train$Stay_In_Current_City_Years

setwd("/Users/chetanbommu/Documents/Analtics Path Files/R exercise data/")
Train = read.csv("train.csv",header = T,sep = ",")

## 1.
install.packages("plyr")
library(plyr)
revalue(Train$Stay_In_Current_City_Years,c("4+"="4"))
## or
levels(Train$Stay_In_Current_City_Years)[5] = "4"
## or
Train$Stay_In_Current_City_Years1 = as.character(Train$Stay_In_Current_City_Years)
class(Train$Stay_In_Current_City_Years1) ## verify class is "character"
Train$Stay_In_Current_City_Years1 = ifelse(Train$Stay_In_Current_City_Years1 == "4+",4,Train$Stay_In_Current_City_Years1)
table(Train$Stay_In_Current_City_Years1)

## 2.
nrow(Train[Train$Marital_Status == 0,])  ## 324731

## 3.
nrow(Train[Train$Age == "26-35" & Train$Marital_Status == 0,])  ## 133296

## 4.
library(dplyr)
a = Train[Train$Age == "26-35" & Train$Marital_Status == 0,] 
length(unique(a))  ## 1244

## 5.
length(table(Train$Age))  ## 7
## or
length(unique(Train$Age)) ## *

## 6.
length(table(Train$User_ID)) ## 5891
## or
length(unique(Train$User_ID)) ## *

## 7.
a = data.frame(table(Train$Product_ID))
names(a) = c("prod_id","freq")
b = a[order(a$freq,decreasing = T),]
b[1,1]
 
max(table(Train$Product_ID))
## [1] 1880


## 8.	What is the average purchase rate of gender = f & gender = m?
purchase_value = aggregate(Train$Purchase,by=list(Train$Gender),FUN=mean)
names(purchase_value) = c('Gender','Purchase_Value')
              ## or
pur = aggregate(Purchase~Gender,data=Train,FUN=mean)  ## This way we need not assign column names again

## 9.	What is the average value of purchase when gender = f or age_group = "0-17"
mean(Train[Train$Age=="0-17" | Train$Gender =='F',"Purchase"])
    ## [1] 8768.96
              ## or
Train2 = Train[Train$Gender=='F' | Train$Age=='0-17',]
aggregate(Purchase~Gender+Age,data=Train2,FUN=mean)

## 10.	What is the average value of purchase within the odd rows of train.csv?
mean(Train[seq(1,nrow(Train),2),"Purchase"])
    ## [1] 9253.614

## 11.	create a new dataset (train2) that does not have any row in train.csv that has missing value
Train2 = na.omit(Train)

## 12.	In which city_category do most of the users within age group "0-17" live?
var = data.frame(table(Train[Train$Age == '0-17',"City_Category"]))
var$Var1[which.max(var$Freq)]
    ## [1] C
              ## or
var = data.frame(table(Train[Train$Age == '0-17',"City_Category"]))
ordered_var = var[order(var$Freq,decreasing = T),]
ordered_var[1,1]

## 13.
sum(is.na(Train$Product_Category_2) == T)
   ## [1] 173638

## 14.
Train_pc2_null = data.frame(table(Train[is.na(Train$Product_Category_2) == T,"Product_Category_1"]))
Train_pc2_null$Var1[which.max(Train_pc2_null$Freq)]
  ## [1] 5

## 15.


## 16.


## 19.	Among all the variables from "Gender" to "Product_Category_3":
  ## A)	Calculate the average purchase rate for all the distinct values of each variable
  for(i in seq(3,length(colnames(Train)))-1){
       print(colnames(Train)[i])
       print(aggregate(Train$Purchase,list(Train[,i]),FUN=mean))
   }
  ## B)	identify the variable that has the highest lift in purchase rate
  var1 <- as.data.frame(aggregate(Train$Purchase,list(Train[,6]),mean))
  mean(var1$x)
  maxvalue <- var1[which.max(var1$x),"x"]
  maxvalue
  minvalue <- var1[which.min(var1$x),"x"]
  minvalue
  
  lift <- (maxvalue-minvalue)/mean(var1$x)
  
  
  lift_t <- NULL
  
  for(i in 6:10)
  {
    var1 <- as.data.frame(aggregate(train$Purchase,list(train[,i]),mean))
    
    maxvalue <- var1[which.max(var1$x),"x"]
    
    minvalue <- var1[which.min(var1$x),"x"]
    
    lift <- (maxvalue-minvalue)/mean(var1$x)
    
    lift_t<-rbind(data.frame(cat =c( (colnames(train[i]))),lift =c(lift)),lift_t)
    
    
  }
  
  lift_t
  print(lift_t[which.max(lift_t$lift),])

## 20.	Write a function that takes variable name as input & gives out the frequency of occurrence table of the distinct values of the variable
func = function(col_name){
  print(col_name)
  table(Train[,col_name])
  var_col_name = Train[,col_name]
  print(var_col_name)
}  

func('Age')

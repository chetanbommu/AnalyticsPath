install.packages("titanic")

## Statistics - Practice Exercises
## This data set titanic_data provides information on the fate of passengers on the fatal maiden voyage of the ocean liner "Titanic", summarized according to economic status (class), sex, age and survival.
## Dataset Name:			titanic_train (Titanic Passenger Survival Dataset)

## Table View: Titanic_train


## Practice Exercises:
## 1.	Use titanic data  library(titanic)
library(titanic)

## 2.	 titanic_train is used in the dataset 
  ## data("titanic_train")
  ## head(titanic_train)
head(titanic_train)

## 3.	Compute the descriptive statistics on age variable  summary(titanic_train$Age)
summary(titanic_train$Age)

## 4.	Compute descriptive statistice on Fare variable   summary(titanic_train$Fare)
summary(titanic_train$Fare)

## 5.	Compute the measures of spread for age and Fare variable 
?var
var(titanic_train$Age, na.rm = TRUE)
var(titanic_train$Fare, na.rm = TRUE)

## 6.	Variance, Standard deviation and IQR 
?sd
sd(titanic_train$Age, na.rm = TRUE)

?IQR
IQR(titanic_train$Age, na.rm = TRUE)

## 7.	Select a random sample of 500 records from titanic_train
View(titanic_train)
?sample
sample(1:nrow(titanic_train),500)  ## picks 500 unique and random row numbers from entire row range(891 records)
sample = titanic_train[sample(1:nrow(titanic_train), 500),]
sample

## 8.	 Compute the mean fare by PClass
aggregate(Fare~Pclass,titanic_train, FUN = mean)

## 9.	 Seperate the records of all the classes and compute the mean 
Pclass_1 = titanic_train[titanic_train$Pclass == 1, "Fare"]
mean(Pclass_1)

Pclass_2 = titanic_train[titanic_train$Pclass == 2, "Fare"]
mean(Pclass_2)

Pclass_3 = titanic_train[titanic_train$Pclass == 3, "Fare"]
mean(Pclass_3)

## 10.	 Assuming the age is following normal distribution

## 11.	 What is the propability of a person with age greater than 50
    ## use pnorm 
?pnorm
pnorm(50,mean(titanic_train$Age, na.rm = TRUE), sd(titanic_train$Age, na.rm = TRUE), lower.tail = FALSE) ##lower.tail checks for <= of probability

## 12.	 what is the propability of fiding a person between the age of 40 and 50?
p50 = pnorm(50,mean(titanic_train$Age, na.rm = TRUE), sd(titanic_train$Age, na.rm = TRUE))
p40 = pnorm(40,mean(titanic_train$Age, na.rm = TRUE), sd(titanic_train$Age, na.rm = TRUE))

p50 - p40

## 13.	 what is 75th percentile age?
summary(titanic_train$Age) ## 3rd Quartile = 75%

?quantile
quantile(titanic_train$Age,probs = .75, na.rm = T)

?qnorm ## qnorm normalizes the distribution, so there will be difference between qnorm and quantile
qnorm(.75, mean(titanic_train$Age, na.rm = T), sd(titanic_train$Age, na.rm = T))

## 14.	 age of the 95% of the people ( lower(2.5%) and upper(97.5%))?
quantile(titanic_train$Age,probs = c(0.975,0.025), na.rm = T) 

## 15.	 Plot the probability density of age variable 
?density
?plot
plot(density(titanic_train$Age, na.rm = T), main = "Age Plot", xlab = "Age", ylab = "Density")

## 16.	 Compute Z values for Fare variable 
z_score_Fare = (titanic_train$Fare - mean(titanic_train$Fare, na.rm = T))/sd(titanic_train$Fare, na.rm = T)
   ## z-score is used to normalize the data
range(z_score_Fare) ## shows range i.e., min and max
range(titanic_train$Fare)
?scale 
scale(titanic_train$Fare) ## scale is the function that finds z-score for that variable
range(scale(titanic_train$Fare)) ## verifying with calculated z-score

## 17.	 Convert the Fare into standard normal values 
      ## Min-Max Normalization
standardized_values = (titanic_train$Fare - min(titanic_train$Fare))/(max(titanic_train$Fare) - min(titanic_train$Fare))
standardized_values

## 18.	 Is there a difference in mean age of Males anf Females on Titanic?
help("t.test")
titanic_age_male = titanic_train[titanic_train$Sex == "male","Age"]
titanic_age_female = titanic_train[titanic_train$Sex == "female","Age"]
  ## p-value > 0.05 => accept Null Hypothesis and reject Alternate Hypothesis
  ## p-value <= 0.05 => accept Alternate Hypothesis
t.test(titanic_age_male, titanic_age_female, alternative = "greater")
t.test(titanic_age_male, titanic_age_female, alternative = "two.sided")
t.test(titanic_age_male, titanic_age_female, alternative = "less")

      ## or
t.test(titanic_train$Age ~ titanic_train$Sex,alternative = "less")

## 19.	 Set a Alternate hypothesis and Null hypothesis 


## 20.	 Alternate hypothesis is Mean age of Men is greater than mean age of females 

## 21.	 What is the propability of survival?
prop.table(table(titanic_train$Survived))
prop.table(table(titanic_train$Survived))[2]

## 22.	 what is the propability of survial for Males?
titanic_train_with_male = titanic_train[titanic_train$Sex == "male",]
titanic_train_with_female = titanic_train[titanic_train$Sex == "female",]

prop.table(table(titanic_train_with_male$Survived))[2]

## 23.	 what is the propability of survival of females?
prop.table(table(titanic_train_with_female$Survived))[2]

## 24.	 what is the propability of survival for females in second class?
prop.table(table(titanic_train_with_female[titanic_train$Pclass == 2 ,]$Survived))[2]

## 25.	 what is the propability of survival for males in second class?
prop.table(table(titanic_train_with_male[titanic_train$Pclass ==2, ]$Survived))[2]

## 26.	 compute the odss of survival of Males 
## same as 22

## 27.	 compute the odds of survival for females 
## same as 23

## 28.	 Odds ratio of survival of males vs females ?
## 26/27

## 29.	 Perfrom hypothesis testing on survival of Males vs Survival of females 
  ##   table(titanic_train$Sex, titanic_train$Survived)
  ##   chisq.test(table(titanic_train$Sex, titanic_train$Survived))
  ##   hist(titanic_train$Age)
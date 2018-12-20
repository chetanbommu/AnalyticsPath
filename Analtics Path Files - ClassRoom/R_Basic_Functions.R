## math functions
a = 10
log(a) # natural log => loge(a)
log2(a)

#square root
sqrt(a)

## rounding functions
b = round(sqrt(a),2)

ceiling(10.99)  #next integer =>11
floor(10.99)    #previous integer => 10

round(10.6)

## Data frame explorations and inspection
head(df1) #first six rows
head(df1,5) #first 5 rows
tail(df1) #last six rows
tail(df1,5) #last 5 rows

dim(df1) # no of rows, no of columns
nrow(df1) # number of rows
ncol(df1) # number of columns
colnames(df1) # list of column names of dataframe
names(df1) <- c("col1","col2","col3") # assign names to columns of a dataframe

summary(df1) #gives a summary about data i.e.,min,max,mean,median,1st quadrant,3rd quadrant

table(df1$Department) ## useful on factor variables and numeric column with few unique values but 
                      ## not useful for numeric columns with many unique values

cbind(df1,df2) ##column binding
rbind(df1,df2) ##row binding
prop.table(table(Churn$gender)) ##creates a table with proportion

##Sorting or Ordering the data
df1 = df1[order(df1$Age), ] ## as per ascending order of age
df1 = df1[order(df1$Age, decreasing = FALSE), ]

## RODDBC
install.packages("RODBC")
library(RODBC)

dbConnect = odbcConnect(dsn = datasourceName, uid = "userid", pwd = "password")
datafromDb = sqlQuery(channel = dbConnect,query = "select * from db.tablename")

## Functions from Other Package
library(dplyr)

## Select function
Churn_temp = select(Churn, "VMail.Plan","Day.Mins","Intl.Plan")
Churn_temp_2 = select(Churn,starts_with("Day"))
Churn_temp_3 = select(Churn,ends_with("Plan"))

## Filter function
Churn_temp = filter(Churn, Day.Mins >= 200)
Churn_temp_2 = filter(Churn, Day.Mins >= 200 & State %in% c("NY","NJ","DC"))
Churn_temp_3 = filter(Churn, Day.Mins >= 200, state == "NY")  ##by default and operation is performed on various filters

## Rename function
Churn_temp = rename(Churn,Account_Length = Account.length, Intl_Plan = Intl.Plan)

## Arrange
Churn_temp = arrange(Churn, Day.Mins) ## arrange by Day.Mins
Churn_temp = arrange(Churn, Day.Mins, Eve.Mins) ## arrange by Day.Mins and then by Eve.Mins
Churn_temp = arrange(Churn, Day.Mins, Eve.Mins, desc(Eve.Mins)) ## arrange by Day.Mins and then by descending order of Eve.Mins

## Mutate
Churn_temp = mutate(Churn, Total.Usage = Day.Mins + Eve.Mins + Night.Mins)

##lubridate ##stringr

## Date Functions R always results date in this "2018-10-04" format
library(lubridate)
date_str = "04/10/2018"
date = as.Date(date_str, "%d/%m/%Y") ## %Y for year in 4 digit format

date_str2 = "04-10-2018"
date_2 = as.Date(date_str2, "%d-%m-%Y")

date_str3 = "04-Oct-2018"
date_3 = as.Date(date_str3,"%d-%b-%Y")  ## %b for date in Three letter format

date_str4 =  "01-01-99"
date_4 = as.Date(date_str4,"%d-%m-%y")  ## %y for year in 2 digit format

month = month(date) ## returns month of date object
day = day(date) ## returns the day-date of date object
year = year(date) ## retuns the year of date object
weekday = weekdays(date) ## returns the day of week for date object i.e., Monday-Sunday
weekNumber = week(date) ## returns the week number for date object  i.e., 1 - 53

## Character Functions
a = "apple"

length(a) ## string length i.e, 1 here
nchar(a) ## returns length of a string i.e., 5 here

## sub-string function
a1 = substr(a,2,4) ## substring of a from 2nd to 4th element i.e., "ppl"

## substitute function
a = "01/01/2018"
a = sub("/",".",a) ## replaces only first occurence i.e., 01.01/2018
a = gsub("/",".",a) ## replaces all occurences ...global substitution i.e., 01.01.2018

## paste function
first = "Chetan"
last = "Bommu"
name = paste(first,last) ## like concatination ...as many as vectors can be passed ...default sep(separator) is " " 
name = paste(first,last, sep=" ") 

##  string split
name = "Apple-Iphone"
name_split = strsplit(name,split = "-") ## Returns a list by default
name_split = unlist(strsplit(name,split = "-")) ## Unlist converts list to vector ..here Character vector

### sqldf
install.packages("sqldf")
library(sqldf)

churn_names = colnames(Churn)
churn_names = gsub(churn_names, pattern = "\\.", replacement = "_")
names(Churn) = churn_names

Churn_sql_res = sqldf("select * from Churn where Day_Mins >= 200")

### aggregate function
aggregate(df$sal,by=list(df$gender),FUN=mean)
        # or
aggregate(sal~gender,data=df,FUN=mean)  ## preferable syntax for group by in R

aggregate(amount~default,data = Credit, FUN = mean)
aggregate(Credit$amount, by = list(Credit$default), FUN = mean)

### apply function  => return type is a vector
id = c(1,2,3,4,5)
sal = c(100,200,300,400,500)
age = c(10,20,30,40,50)
df = data.frame(id,sal,age)
## compute column wise
apply(X = df, MARGIN = 2, FUN = mean)  ## margin = 2 apply function column-wise
## compute row wise
apply(X = df, MARGIN = 1, FUN = mean)  ## margin = 2 apply function row-wise

### lapply function  => useful when we want to apply a function on whole data,return type is a list
a = c(10,20,30,40,50)

divby2 = function(x){
  return(x/2)
}

lapply(a, FUN = divby2)

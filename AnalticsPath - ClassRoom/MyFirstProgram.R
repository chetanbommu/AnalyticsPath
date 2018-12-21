# My frirst program in R 
# Data Types 

a = 10 # will create a object a and 10 is assigned as value 
class(a) ## will return the data type of object a 

a = 10.5 ## create object a 
a = 10L ## 
class(a)

 a= "10L"
class(a) 


## Character data types 
 a= "Samsung"
class(a)
a = "apple"
class(a)
a = 'apple'

## type casting 

a = 10 
class(a)

a = as.integer(a)
class(a)

a = 10.5
class(a)

a = as.integer(a)
a

b = as.numeric(a)
b

## conversion from char to numeric 

a = "123"
class(a)

a = as.integer(a)
class(a)

a = "123.5"

b = as.integer(a)
b = as.numeric(a)

as.character(b)

b
 d = b

 ## validate the data type of a object 
 
is.integer(a)
is.character(a)

a = "apple"
is.numeric(a)

## conversion from character to factor 

a = "apple"
a = as.factor(a)
a

### case sensitive 

a
A
A = 123

## boolean data types 
 a = TRUE
 b = FALSE
class(a)
class(b)

a = T 
b = F 
claas(a)
d = "T"
class(d)
### Data Structures 

## vector 

a = c(10,20,30,40)
length(a) ## will return the number of elements in a object

## vector slicing
a[1] ## in R indexing starts with 1, first element will be printed 
b = a[1]
a[3]
a[1:3] # : colon operator, will create a sequence 
 1:5
a[1:2]
a[2:1]
5:1
 
## negative indexing 
 a[-1] ## - is for exclusion, first element will e excluded
a[-1:-2] ## first and second elements will be excluded
a[-c(1,4)] ## eclude first and fourth element 
a[-c(1,3)]

### vector append 

a[5] = 50  ## fifth element added to vector a with a value of 50 
a

a[7] = 70 ## sixth and seventh element will be added to vector a 
a


## deletion 
 a = a[-4]
a 

a = a[-2]

a

a[4] = 60
a
class(a)
##  character vectors 
a = c("M","F","M","F","M","F")
a
class(a)
a = as.factor(a)
a

class(a)

## Mixed data types 

a = c(1,2,3,"A","B","C",T,F)
class(a)
a

a = c(1,2,3,4,5)
b = c(6,7)
d = c(a,b)
d
 a = c(1,2,3,4)
b = c("M","F")
class(a)
class(b)

d = c(a,b)
d

### matrices 

a = c(1,2,3,4)
b = matrix(a, 2,2)
b = matrix(1:6, nrow = 3, ncol = 2)
b
b = matrix(1:6,nrow = 3, ncol=2, byrow = T)
b

## matrices slicing 

b[1,1] ## first row and first element 
b[1,] ## first row 
b[,1] ## first column, all rows by default 
b[1:2,1:2]
b[-1,]
b[,-1]


### dataframes 

id = c(1,2,3,4)
age = c(10,20,30,40)
gen = c("M","F","M","F")

## create a dtaframe df1 

df1 = data.frame(id, age, gen)

## inspect a dataframe 

str(df1)

View(df1)
 ## print a few records from the df 

head(df1) ## Head prints the first six records 
tail(df1) ## tail prints the last six records 

head(df1,2) ## will only print the first 2 records
tail(df1, 2) ## will print two last two records


## inspect the churn dataset 

str(Churn)

## change the datatype of a variable 

Churn$Phone = as.character(Churn$Phone)

head(Churn,5)


### Read a CSV file using program 
dfcredit = read.csv("D:/AP/baging and  RF/credit.csv", header = T, sep=",", stringsAsFactors = F)

str(dfcredit)

getwd()
setwd("D:/AP/baging and  RF")
getwd()
?read.delim

credit = read.csv("credit.csv")

str(credit)


### dataframe slicing 

credit2 = credit[ , 1:3]
credit2 = credit[1:10, ]
credit2 = credit[100:110,]

credit[500:505,]

colnames(credit)

credit2 = credit[ , c(1,5, 6, 9, 11, 13)]

colnames(credit2)

credit2 = credit[ , c(5, 13, 1 , 9, 6 , 11)]
colnames(credit2)


credit2 = credit[ , -c(1:5)]

credit2 = credit[, -c(1, 5, 9, 13 )]

1:10
seq(1,17,2)
seq(2,17, 2)

## slect all odd rows 

credit2 = credit[ seq(1,nrow(credit),2), ]

## Select all even columns 

credit2 = credit[ , seq(2,ncol(credit), 2)]

### deleting cloumns 

credit2 = credit2[, -c(1:2)]

credit$checking_balance = NULL

colnames(credit2)
### slice dataframes using column names 

credit2 = credit[ , c("savings_balance", "job", "phone")]

## Operations 

## Arithematic operations 
a = 10 
b = 2 

c = a + b # addtion
c = a - b # substraction
c = a * b # Multiplication
c = a / b # divsion
c = a %% b # Reaminder 
c = a**b # Power
c = a ^ b # Power

## Oparations on Vectors 

a = c(1,2,3,4,5)
b = c(10,20,30,40,50)

a + b 

a - b 

a = c(1,2,3,4)
b = c(10,20)

a + b 

a = c(1,2,3,4,5)
b = c(10,20)

a + b 

### on data frames 

Churn$Tot.Usage = Churn$Day.Mins + Churn$Eve.Mins + Churn$Night.Mins

Churn$Tot.Charge = Churn$Day.Charge + Churn$Eve.Charge + Churn$Night.Charge

### Compasrison operators 

Churn2 = Churn[ Churn$Day.Mins > 200 , ] ## select all the rows where Day.Mins is greater than 200 
Churn2 = Churn[Churn$Day.Mins >= 200 , ] ## greater than or eqaul to 

Churn2 = Churn[Churn$State == "NY",  ] ## equal to 

Churn2 = Churn[Churn$State %in% c("NY","NJ","DC"), ] ## in operator 

##  Using loical operations 

Churn2 = Churn[ Churn$Day.Mins >= 200 & Churn$Night.Mins >= 200,]

Churn2 = Churn[Churn$State == "NY" & Churn$State == "NJ", ] ## will result in 0 records 
Churn2 = Churn[Churn$State == "NY" & Churn$Day.Mins > 150 , ]

Churn2 = Churn[Churn$State == "NY" | Churn$State == "NJ", ]

### Merges or Joins 

id = c(1,2,3,4,5)
gen = c("M","F","M","F","M")
sal = c(100,200,300,400,500)

df1 = data.frame(id,gen,sal)

id = c(1,2,3,4,6)
dept = c("A","B","A","B","A")
age = c(10,20,30,40,60)

df2 = data.frame(id,dept,age)

## inner merge 

df3 = merge(x = df1, y = df2, by = "id") ## inner merge 
df3

df3 = merge(x = df1, y = df2, by = "id", all.x = T) ## left merge 
df3

df3 = merge(x = df1, y = df2, by = "id", all.y = T) ## right merge 
df3

df3 = merge(x = df1, y = df2, by = "id", all.x = T, all.y = T) # Full merge 

## Duplicates 

id = c(1,1,2,2)
dept = c("A","B","A","B")
age = c(10,20,30,40)

df1 = data.frame(id, dept, age)

id = c(1,1,2,2)
dept = c("A","B","A","B")
gen = c("F","M","F","M")

df2 = data.frame(id,dept, gen)

### inner merge 

df3 = merge(x = df1, y = df2, by ="id")
df3


## merge with a composite key 

df3 = merge(x=df1, y = df2, by = c("id","dept"))
df3


### duplicates in one of the dataframes 

id = c(1,1,1,1,2,2,2,2)
mon = c(1,2,3,4,1,2,3,4)
bill = c(100,101,102,103, 102,103,101,100)

bill = data.frame(id,mon, bill)

id = c(1,2)
gen = c("M","F")
state = c("A","B")

dem = data.frame(id,gen,state)

dem

## merge bill and gen 

bill_dem = merge(x = bill, y = dem , by = "id", all.x=T)

### Control structures 
## conditional statements 

age = 16 

if(age >=18){ 
  age_cat = "Adult"
}else { 
  age_cat = "Child"  
}
age_cat

num = 11
num_check 

###  check of odd or even 

if ( num %% 2 == 0){ 
  num_check = "even"
  }else num_check = "odd"

num_check


### agegrp as '0-25', '26-35', '36-45', '45+

age = 39 

if (age <=25){ 
  agegrp = '0-25'
}else if(age >25 & age <= 35){ 
  agegrp = '26-35'  
}else if(age > 35 & age <= 45){ 
  agegrp = "36-45"  
}else agegrp = "45+"

agegrp 

### ifelse function 
age = 20
age_cat = ifelse(age >= 18,"Adult", "Child"  )
age_cat

### multiple checks 

agegrp = ifelse( age <= 18 , "0-18",(ifelse(age > 18 & age<=36,"19-36",(ifelse(age > 36& age<=48,"37-48","48+")))))


## (Day.Mins > 200 | Eve.Mins > 200 ) & State = "FL"


age  = c(36, 21, 54, 40)


for ( i in 1:length(age)){
  
  if (age[i] <=25){ 
    agegrp[i] = '0-25'
  }else if(age[i] >25 & age[i] <= 35){ 
    agegrp[i] = '26-35'  
  }else if(age[i] > 35 & age[i] <= 45){ 
    agegrp[i] = "36-45"  
  }else agegrp[i] = "45+"
  
}

age  = c(36, 21, 54)

agegrp=c()
for ( i in 1:length(age)){
  
  if (age[i] <=25){ 
    agegrp[i] = '0-25'
  }else if(age[i] >25 & age[i] <= 35){ 
    agegrp[i] = '26-35'  
  }else if(age[i] > 35 & age[i] <= 45){ 
    agegrp[i] = "36-45"  
  }else agegrp[i] = "45+"
  
}

agegrp


for(i in 1:length(age)){ 
  
  if (age <=25){ 
    agegrp = '0-25'
  }else if(age >25 & age <= 35){ 
    agegrp = '26-35'  
  }else if(age > 35 & age <= 45){ 
    agegrp = "36-45"  
  }else agegrp = "45+"
  
}

age
### iflese function by default performs a element wise opeartion no need to use index 
agegrp = ifelse( age <= 18 , "0-18",(ifelse(age > 18 & age<=36,"19-36",(ifelse(age > 36& age<=48,"37-48","48+")))))

agegrp

id = c(1,2,3,4,5)
age = c(20, 39, 42, 18, 29)
df = data.frame(id, age) 

for ( i in 1:nrow(df)){
  
  if (df$age[i] <=25){ 
    df$agegrp[i] = '0-25'
  }else if(df$age[i] >25 & df$age[i] <= 35){ 
    df$agegrp[i] = '26-35'  
  }else if(df$age[i] > 35 & df$age[i] <= 45){ 
    df$agegrp[i] = "36-45"  
  }else df$agegrp[i] = "45+"
  
}

df


## using the ifelse function 

df$agegrp = ifelse( df$age <= 18 , "0-18",(ifelse(df$age > 18 & df$age<=36,"19-36",(ifelse(df$age > 36& df$age<=48,"37-48","48+")))))

df

## vector slicing 

 a = c(10,23,30,33,40,43)

 even = c()
 odd = c()

 for(i in 1 :length(a)){ 
   if(a[i] %% 2 == 0){ 
     even = c(even,a[i])
     }else odd = c(odd,a[i])
 } 
 even
 odd 

### packages 
 
#install.packages("dplyr")

 library(dplyr)
 filter_(a)
 detach("package:dplyr", unload=TRUE)
 filter_(a)
 ?detach

 detach("package:dplyr", unload=T)
 
### functions 

## math functions 

a = 10  #log
log(a) 
log2(a)
## sqrt 
a = 10 
b = sqrt(a)

## rounding functions 

b = round(sqrt(a),2)

## ceiling 
ceiling(10.1)
ceiling(10.0001)
floor(10.99)
floor(10.01)
b = round(10.6)

### Data explorations and inspection 
head(df1) ## prints top six records 
tail(df1) ## last six records 
head(df1, 5) ## prints the first five records 
tail(df1, 5) ## prints the last five records 

dim(df1) ## no of rows , no of columns 
nrow(df1) ## no of rows 
ncol(df1) ## no of columns 
colnames(df1) ## prints the list of column names 
names(df1) = c("vector of column names") ## assign column names 
colnames(df1)
names(df1) = c("Custid","Department","Age")
colnames(df1)
## Summary 

summary(df1)

table(df1$Department) ## use on factor variables 
table(df1$Custid) ## numeric column with very few uniqe values 
table(df1$Age) ## Dont use table on numeric clumns with many unique values 

### CHurn dataset 

table(Churn$State)
table(Churn$Churn)

## table can take multiple arguments 

table(Churn$Churn, Churn$Intl.Plan)

### sorting and ordering the data 

df1 = df1[ order(df1$Department),] ## order or arrange by Department
df1 = df1[order(df1$Custid), ] ## order or arrange by ID 
df1 = df1[order(df1$Age,decreasing = T),]

## RODBC 
# install.packages("RODBC")
library(RODBC)

dbconnect = odbcConnect(dsn = mysqldb, uid = "A123", pwd = "A!@#@@")

datafromdb = sqlQuery(channel = dbconnect, query = "select * from db.tablename ")

### column binding and rowbinding 
id = c(1,2,3,4,5)
gen = c("M","F","M","F","M")
age = c(10,20,30,40,50)
sal = c(100,200,300,400,500)
df1 = data.frame(id,gen,age,sal)
df1

dfa = df1[,1:2]
dfb = df1[,3:4]

dfa
dfb

dfb$comp = sal/age
dfb
dfc = cbind(dfa,dfb)
dfc

### rbind 

dfa = df1[1:3,]
dfb = df1[4:5,]

dfa
dfb

dfc = rbind(dfa,dfb)

##

table(df1$gen)
prop.table(table(df1$gen))
prop.table(table(Churn$Churn))

prop.table(table(Churn$Churn, Churn$Intl.Plan))

## Functions from other packages 

library(dplyr)

### select function 
?select

colnames(Churn)

Churn2 = select(Churn, "VMail.Plan", "Churn", "Intl.Plan" )

Churn2 = select(Churn, starts_with("Day"))
Churn2 = select(Churn, ends_with("Plan"))

## filter 
?filter

Churn2 = filter(Churn, Day.Mins >= 200)
Churn2 = filter(Churn, Day.Mins >=200 & State %in% c("NY","NJ","DC"))
Churn2 = filter(Churn, Day.Mins >=200, State == "NY") ## by default and operation 

## rename
?rename

Churn2 = rename(Churn2, Account_Length = Account.Length, Intl_Plan = Intl.Plan)
colnames(Churn2)

## arrange 

?arrange

Churn2 = arrange(Churn, Day.Mins, desc(Eve.Mins))
Churn2 = arrange(Churn, State)

## mutate 

Churn$col1 = **operation 
Churn$col2 = Churn$col1 / Churn$Churn

?mutate

Churn2 = mutate(Churn, Tot.Usage = Day.Mins + Eve.Mins + Night.Mins, Tot.Charges = Tot.Usage*0.34)


## Character functions 

## Date  functions

##lubridate ##stringr 
library(lubridate)
date = "01/01/2018"
date1 = as.Date(date, "%d/%m/%Y") # value seperators are / and year is four digit
date1
date = "01-01-2018"
date1 = as.Date(date, "%d-%m-%Y") ## the value sperators are -
date1

date = "01-Jan-2018"
date1 = as.Date(date, "%d-%b-%Y") ## %b for date in There letter format 
date1

date = "01-01-18"
date1 = as.Date(date,"%d-%m-%y")
date1

date = "01-01-99"
date1 = as.Date(date,"%d-%m-%y")
date1

Sys.Date()

mon = month(date1)
mon

day = day(date1)
day

year = year(date1)
year

weekday = weekdays(date1)
weekday

weekday = weekdays(Sys.Date())
weekday

weekn = week(Sys.Date())
weekn

weekn = week("2018-06-01")
weekn


### Character functions 

a = "apple"

length(a)
### string length 

nchar(a) ## length of a string 

a1 = substr(a, 1,2)
a1

a2 = substr(a, 1,3)
a2

a3 = substr(a, 3,5)
a3

## replacment or substitution 

a = "01/01/2018"

## sub and gsub 

a = sub(pattern = "/",  "-", a) ## sub only replaces the first instance of pattern
a = gsub(pattern = "/",  "-", a) ## replaces all instances of the pattern
a

## paste function 

first = "Abcd"
last = "efgh"

name = paste(first, last)  ## by default concatenates with a space between the strings 
name = paste(first, last, sep = "") ## no space as sep is having a blank value 
name

### stringsplit 

name = "apple-iphone"
name_split = unlist(strsplit(name , split = "-")) ## strsplit will return a list, unlist will break the list to a vector
name_split

date = "01/01/2018"

date_split = unlist(strsplit(date, split="/"))
date_split

### sqldf

library(sqldf)

Chrun2 = sqldf("select * from Churn2")
Churn2


Chrun2 = sqldf("select * from Churn2 where Day.Mins > 200") ## will throw an erro as Day.Mins is not a valid name in sql 
churnnames = colnames(Churn2)
churnnames

## remove the . from colnames on churn2 

## example for pattern replacement 
string = "A.R.Rehman"

string = gsub(string, pattern = "\\.", replacement = " ")
string

churnnames = gsub(churnnames, pattern = "\\.", replacement = "_")
churnnames

names(Churn2 ) = churnnames

Churn3 = sqldf("select * from Churn2 where Day_Mins >= 200") 



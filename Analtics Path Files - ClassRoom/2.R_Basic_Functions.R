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


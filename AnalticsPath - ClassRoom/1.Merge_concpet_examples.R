id = c(1,2,3,4,5)
gender = c('M','F','M','F','M')
sal = c(100,200,300,400,500)
df_1 = data.frame(id,gender,sal)

id = c(1,2,3,4,6)
dept = c('A','B','A','B','A')
age = c(10,20,30,40,60)
df_2 = data.frame(id,dept,age)


## inner merge
df_3 = merge(x=df_1, y=df_2, by="id")
df_3

## left merge
df_4 = merge(x=df_1, y=df_2, by="id", all.x=T)
df_4

## right merge
df_5 = merge(x=df_1, y=df_2, by="id", all.y=T)
df_5

## full merge
df_6 = merge(x=df_1, y=df_2, by="id", all.x=T, all.y=T)
df_6

---------------------------------------------------

## duplicates values in each data-frame => cartesian 

id = c(1,1,2,2)
dept = c('A','B','A','B')
age = c(10,20,30,40)
df1 = data.frame(id,dept,age)
df1

id = c(1,1,2,2)
dept = c('A','B','A','B')
gen = c('F','M','F','M')
df2= data.frame(id,dept,gen)
df2

## inner merge
df3 = merge(x = df1,y=df2,by='id')
df3

## merge with a composite key
df3 = merge(x=df1, y=df2, by=c('id','dept'))
df3

---------------------------------------------------

## duplicates in one of the dataframes
id = c(1,1,1,1,2,2,2,2)
mon = c(1,2,3,4,1,2,3,4)
bill = c(100,101,102,103,102,103,101,100)
bill_df = data.frame(id,mon,bill)
bill_df

id = c(1,2)
gen = c('M','F')
state = c('A','B')
dem = data.frame(id,gen,state)
dem

#merge bill and dem
bill_dem = merge(x=bill_df,y=dem,by="id",all.x=T)
bill_dem
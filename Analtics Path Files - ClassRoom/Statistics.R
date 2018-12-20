#stat functions
#t-test

#one saample - one sided t-test
x = c(999,998,1000,1001,1003,996,1000, 1002, 1001, 1004,1006,1009,997,999,1000,1000)
mean(x)
# H0: mean(x) <= 1000
# Ha: mean(x) > 1000

t.test(x, mu=1000, alternative = "greater") #if p-value < 0.05, reject H0 and go with H1
#p-value, is the probability of making type-1 error

#one sample - two sided
# H0: mean(x) == 1000
# Ha: mean(x) != 1000

t.test(x, mu=1000, alternative = "two.sided")#two sided

#two sample - one sided
# H0: mean score of girls <= mean score of boys
# Ha: mean score of girls > mean score of boys
girls = c(7,8,8.9,4.4,5.6,7.9,9.2,8.1,8.6,7.4,7.2,7.1,9.5,8.8,6.0,7.6)
boys = c (8,9.4,9.5,5.6,8.4,6.9,7.8,4.5,7,9,5.5,6.9,8.8,6.1,7.7,6.6)
t.test(x=girls, y=boys, alternative = "greater")

#two sample - two sided
# H0: mean score of girls == mean score of boys
# Ha: mean score of girls != mean score of boys
t.test(x=girls,y=boys, alternative = "two.sided")


##### chi square test
smoker = c (rep("No",75),rep("Yes",25))
table(smoker)

cancer = c(rep("No",70),rep("Yes",5),rep("No",5),rep("Yes",20))
table(cancer)

table(smoker,cancer)

chisq.test(table(smoker,cancer))

## Example - 2
disease = c(rep("No",100),rep("Yes",50))
table(disease)

ethinicity = c(rep("A",40),rep("B",30),rep("C",30),rep("B",15),rep("A",25),rep("C",10))
table(ethinicity)

table(ethinicity,disease)

chisq.test(table(ethinicity,disease))

### 3 Cities Temp example
a = c(24,26,31,27)
b = c(29,31,30,36,33)
c = c(29,27,34,26)

city = c(rep("A",4),rep("B",5),rep("C",4))
temp = c(a,b,c)

mean(a)
mean(b)
mean(c)

f = aov(temp ~ city)
summary(f)


aggregate(temp~city,FUN=mean)

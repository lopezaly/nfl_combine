#Homework 3
#Alyssa Lopez

#install packages
install.packages("dplyr")
library("dplyr")

install.packages("psych")
library("psych")

install.packages("corrplot")
library(corrplot)

install.packages("ggplot2")
library("ggplot2")


#read data
nfl = read.csv(file.choose()) #import combine data

#descriptive statistics of raw data
summary(nfl)

#create BMI variable
nfl$bmi = (nfl$Wt/2.205)/((nfl$Ht/39.37)**2)
ggplot(nfl, aes(x=Shuttle, y=bmi))+geom_point()


#subset numerical data to complete correlation matrix raw data
nfl_num = select_if(nfl, is.numeric)

M = cor(nfl_num, use="pairwise.complete.obs")
corrplot(M, method = 'number') 

#visualize positons by BMI
ggplot(nfl, aes(x=Pos, y=bmi))+geom_boxplot()

#exclude observations with missing Forty Yd time.
dim(nfl)

nfl_2 = subset(nfl, !is.na(nfl[5]))
dim(nfl_2)

dim(nfl)-dim(nfl_2)

#########look at distributions of each variable##########
ggplot(nfl_2, aes(x=bmi))+geom_histogram(bins=100)
ggplot(nfl_2, aes(x=bmi))+geom_boxplot()

sum(nfl_2$bmi>(mean(nfl$bmi) + (2*sd(nfl$bmi)))) #there are 179 players with right outlier BMI
sum(nfl_2$bmi<(mean(nfl$bmi) - (2*sd(nfl$bmi)))) #there are 4 players with left outlier BMI

#exclude outlying data from BMI
nfl_3 = subset(nfl_2, (bmi < (mean(nfl$bmi) + (2*sd(nfl$bmi)))) & (bmi > (mean(nfl$bmi) - (2*sd(nfl$bmi)))))
dim(nfl_2) - dim(nfl_3) #confirm that it only removed the outlying observations = 183 rows

#we will remove observations with outliers on the forty
ggplot(nfl_3, aes(x=Forty))+geom_histogram(bins=100)
ggplot(nfl_3, aes(x=Forty))+geom_boxplot()

#exclude outlying data from Forty Yd Dash
sum(nfl_3$Forty > mean(nfl_3$Forty) + (2*sd(nfl_3$Forty))) #274 players have right outlier (slower) 40-yd dash times
sum(nfl_3$Forty < mean(nfl_3$Forty) - (2*sd(nfl_3$Forty))) #0 players have left outlier

nfl_4 = subset(nfl_3, (Forty < mean(nfl_3$Forty) + (2*sd(nfl_3$Forty))) & (Forty > mean(nfl_3$Forty) - (2*sd(nfl_3$Forty))))
dim(nfl_3) - dim(nfl_4) #confirm that it only removed the outlying observations = 274 rows
dim(nfl_4)

#subset numeric data for updated correlation matrix
nfl_4num = select_if(nfl_4, is.numeric)
M = cor(nfl_4num, use="pairwise.complete.obs")
corrplot(M, method = 'number') 

#updated descriptive charts for variables after cleaned data
ggplot(nfl_4, aes(x=Vertical))+geom_histogram(bins=100)
ggplot(nfl_4, aes(x=Vertical))+geom_boxplot()

ggplot(nfl_4, aes(x=BenchReps))+geom_histogram(bins=100)
ggplot(nfl_4, aes(x=BenchReps))+geom_boxplot()

ggplot(nfl_4, aes(x=BroadJump))+geom_histogram(bins=100)
ggplot(nfl_4, aes(x=BroadJump))+geom_boxplot()

ggplot(nfl, aes(x=Cone))+geom_histogram(bins=100)
ggplot(nfl, aes(x=Cone))+geom_boxplot()

#check for linear relationships
ggplot(nfl_4, aes(x=Forty, y=bmi))+geom_point()
ggplot(nfl, aes(x=Forty, y=bmi))+geom_point()
ggplot(nfl_4, aes(x=Vertical, y=bmi))+geom_point()
ggplot(nfl, aes(x=BenchReps, y=bmi))+geom_point()
ggplot(nfl, aes(x=BroadJump, y=bmi))+geom_point()
ggplot(nfl, aes(x=Cone, y=bmi))+geom_point()

#check independence of observation
sum(duplicated(nfl$Player))

#check linear relationship with cleaned dataset
ggplot(nfl_4, aes(x=Pos, y=bmi))+geom_boxplot()

########################################################################
#                        Linear Regression Modeling                    #
########################################################################
model1 = lm(Forty~bmi, nfl_4)
summary(model1)

ggplot(nfl_4, aes(x = bmi, y = Forty)) + 
  geom_point() +
  stat_smooth(method = "lm", col = "red")

#plot residual distribution
res = resid(model1)
res
hist(res)

#plot residuals against the model to check homoscedasticity
plot(fitted(model1), res)
abline(0,0)

#MODEL 2 - MLR, Forty ~ bmi + Pos
model2 = lm(Forty~bmi+Pos, nfl_4)
summary(model2)


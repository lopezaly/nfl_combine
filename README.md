# NFL Combine - BMI & Position on Player Speed

### Introduction
This study analyzes NFL combine data from 2000-2018. The dataset includes 16 variables including players’ physical attributes (height and weight), abilities (40-yard dash (Forty), vertical jump, bench repetitions, broad jump, cone drill, shuttle run), approximate value (AV) and draft information (round, pick). The dataset is representative of 6218 players over the 18 year period, and includes repeat entries from players as they participated across several years.
Findings from this analysis may be beneficial to sports nutritionists, sports trainers, and coaches to better understand the relationship of body mass index (BMI) and position on player speed. 

### Methods
The primary analysis considers the relationship between player BMI (independent variable) and Forty (dependent variable, proxy for speed). BMI and Forty are linearly related and have a positive correlation of 0.79. A second model will be run to analyze the role of Position on Forty. A boxplot of each position’s Forty data is provided below to illustrate the vast differences between groups.

![correlation of forty x bmi](https://github.com/lopezaly/nfl_combine/blob/main/fortyxbmi.png)

### Data Cleaning
172 players were excluded due to missing datapoint for Forty variable. Univariate boxplot analysis also indicated that Forty and BMI each contained outlying observations. A total of 457 players/observations were removed from analysis as outlying values. Outliers, for the purpose of this analysis, are defined as values outside of two standard deviations from the mean. 183 players were removed for outlying BMI values. 274 players were removed for having outlying Forty meter dash times. Further analysis into position subgroups should be considered to more accurately exclude outlying values. BMI and Forty have a positive correlation of 0.75 (0.04 less than with the outlying variables).

### Descriptive Statistics / Data Exploration
Forty has a mean value of 4.734, median of 4.9, IQR of 0.32, and range from 3.73 to 5.38 after exclusion of 274 outliers. The data is slightly right-skewed. 
![forty eda](https://github.com/lopezaly/nfl_combine/blob/main/forty-eda.png)

BMI has a mean value of 30.66, median of 29.99, IQR of 5.44, and range from 22.38 to 40.11 after exclusion of 183 outliers. The data appears to be multi-modal and right skewed.
![bmi eda](https://github.com/lopezaly/nfl_combine/blob/main/bmi-eda.png)

When consider player position within this dataset, it may be important to group some positions together that have extremely low representation in relationship to other positions. One consideration may be to group LB (n=2), OL (n=1), and OLB (n=422) into a single group.

### Modeling
Multiple Linear regression model was chosen to analyze to determine the role of position and BMI on Forty (proxy for speed). 
| Assumption  | Condition Met? |
| ------------- | ------------- |
| Independence of Observation  | Yes - All observations represent a unique player  |
| Linear Relationship | Scatterplots and correlation indicate a positive linear relationship  |
| Homoscedasticity  | Confirmed via visual inspection of residuals plotted against the fitted model  |
| Free of Multicollinearity | Not applicable, as we are only considering a single explanatory variable |
| Free of Outliers  | Data cleaned to remove values that were +/- 2 standard deviations away from the mean  |
| Residuals Normally Distributed  | Yes - The residuals appear to be normally distributed from histogram  |

The model was run using R programming: lm(formula = bmi ~ Forty + Pos, data = nfl_4)

### Results
#### Model 1: Simple Linear Regression, Dependent = Forty, Independent = BMI
The model was significant with R2 = 0.56, adj-R2 = 0.5599, F= 7111, p(F-statistic) < 2.2e-16. A histogram plot of the residuals visually confirms a normal distribution and the plot of residuals against the fitted model confirms homoscedasticity. The following table details the Coefficients from the model:
![model 1](https://github.com/lopezaly/nfl_combine/blob/main/model1.PNG)

#### Model 2: Multiple Linear Regression, Dependent = Forty, Independent = BMI, Position
The model was significant with R2 = 0.7843, adj-R2 = 0.7833, F= 842.7, p(F-statistic) < 2.2e-16. BMI and 19 of the 23 positions were found to be significant, with p<0.01. The R2 value indicates that the model explains 78.4% of the variation of Forty-yard dash times across all players. The coefficients indicate that with every increase in 1 for BMI, there is a 0.014 second increase to the Forty-yard dash.

### Discussion
It is no surprise that player physicality is strongly tied to player speed. Coaches, trainers, and sports nutritionists can use the results from the 18-year Combine analysis as a means to predict potential in new and up and coming athlete’s for drafting purposes. If a player is unable to attend the Combine, they can predict with some certainty, how quickly they may be based on their height and weight (BMI). Additionally, they can better understand how player nutrition/body composition impacts their speed. If a coach/training moves to increase body weight for stronger hits/tackles, they will also understand by how many seconds their sprint may be increased. Coaches that are looking to draft the fastest player in the Combine should consider a player who’s BMI is on the lower end, and who plays a position with a low negative Beta Coefficient (for example, DB, RB, WR).

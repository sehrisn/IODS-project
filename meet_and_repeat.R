#Sehrish Naveed
#Date 9.12.2019

# load the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#basics of the BPRS data
names(BPRS)
str(BPRS)
summary(BPRS)

*The BPRS data is based on th brief psychiatric rating scale which was measured before the start of treatment (week 0) and then continued weekly till eight weeks. The  BPRS assesses the level of 18 psychiatric symptoms on a scle ranges from one (not present) to seven (extremely severe) and is used to evaluate patients for having schizophrenia.
Treatment variable is either 1 or 2 . Minimum points are 0, maximum 18*7=126. Ratings are done during 9 weeks and for each patient both treatments are done.
The data is first loaded in a wide form and demonstrating 40 rows and 11 variables. The wide data format shows single row for every week with multiple columns demonstrating the values of various observations taken on that day.

#basics of the RATS data
names(RATS)
str(RATS)
summary(RATS)

*The RATS data is collected from three groups of rats on which nutrition study is conducted. The groups were given different diets, and the data was collected for 9-weeks in the form of weekly recording of body weight (grams), except in week 7 when two recordings were taken . The difference in the growth profiles of three groups was the question of interest.
The data has 16 obs. of  13 variables.The data is in wide format having a single row for every time point with multiple columns for various observations at that time point.


#factoring of categorical variables of BPRSL data
library(dplyr)
library(tidyr)
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

*In BPRS, categorical datasets are created and week variable is created to show the week numbers

# Convert BPRSL data to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# glimpse at the BPRSL data
glimpse(BPRSL)
dim(BPRSL)
str(BPRSL)

*Now BPRS data is in the long format having observations of each time point as rows and the weeks are columns. Now there are 360 obs. of  5 variables.

# factoring of categorical variables of RATS data
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert RATS data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Glimpse at the RATSL data
glimpse(RATSL)
dim(RATSL)
str(RATSL)

*In RATS, Time variable is categorized to show the week numbers. In long formate the data is now having 5 variables and 176 observations. The weeknumbers are now attribute for the data point.

#BRSL analysis
library(ggplot2)
ggplot(BPRSL, aes(x = week, y = bprs, linetype = subject)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ treatment, labeller = label_both) +
  theme(legend.position = "none") + 
  scale_y_continuous(limits = c(min(BPRSL$bprs), max(BPRSL$bprs)))

*The analysis was based on the linear mixed effects models. First the points belonging to each patient were joined and a plot was drawn to see that each measure points is independent.
It is seen that the patients having high values in the start tend to have higher values at the end. Therefore, the time points were standardize to track the treatment more clearly.
In standardization, the mean is 0. Now the plots are different. It is not obvious, whether the treatment is effective or not as the decrease in the points is not obvious compared to the starting time.

#After using the linear regression
simple_linear_model <- lm(bprs ~ treatment + week, data = BPRSL)
summary(simple_linear_model)

* Simple linear model is used for comparison. The explanatory variables are treatment and week.
P value is significat for the week. The model is not valid , because it assumes independence of the repeated measures of bprs
but it is not likely.

#tracking phenomenan plots
# Standardise the variable bprs
BPRSL <- BPRSL %>%
  group_by(week) %>%
  mutate(stdbprs = (bprs - mean(bprs))/sd(bprs) ) %>%
  ungroup()

# Glimpse the data
glimpse(BPRSL)

*Further, Random Intercept Model is used. The standard deviation of each subject is quite high (6.89).
Week’s t-value is high and it indicates relation, but treatment2 is close to zero indicating that there isn’t a significant difference and it does not have effect on bprs resutls.

# Plot again with the standardised bprs
ggplot(BPRSL, aes(x = week, y = stdbprs, linetype = subject)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ treatment, labeller = label_both) +
  scale_y_continuous(name = "standardized bprs")

#chapter 9 exercises with BPRS data
#PLOT BPRSL
ggplot(BPRSL, aes(x = week, y = bprs, linetype = subject)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ treatment, labeller = label_both) +
  theme(legend.position = "none") + 
  scale_y_continuous(limits = c(min(BPRSL$bprs), max(BPRSL$bprs)))

#RIM
#install.package("lme4")
library(lme4)
BPRSL_ref <- lmer(bprs ~ week + treatment + (1 | subject), data = BPRSL, REML = FALSE)
summary(BPRSL_ref)

#Slippery slopes: Random Intercept and Random Slope Model
BPRSL_ref1 <- lmer(bprs ~ week + treatment + (week | subject), data = BPRSL, REML = FALSE)
summary(BPRSL_ref1)
# perform an ANOVA test on the two models
anova(BPRSL_ref1, BPRSL_ref)

#Time to interact: Random Intercept and Random Slope Model with interaction
BPRSL_ref2 <- lmer(bprs ~ week * treatment + (week | subject), data = BPRSL, REML = FALSE)
summary(BPRSL_ref2)
anova(BPRSL_ref2, BPRSL_ref1)

*When models BPRSL_ref and BPRSL_ref1 are compared in the likelihood ratio test above, chi square value is close to zero, and it is significat on 0.05 level.
The lower the value of chi square test, the better the fit against the comparison model.


# Create a vector of the fitted values
Fitted <- fitted(BPRSL_ref2)

# Create a new column fitted to BPRSL
BPRSL <- BPRSL %>%
  mutate(Fitted)

# draw the plot of BPRSL with fitted values
ggplot(BPRSL, aes(x = week, y = Fitted, group= subject, linetype = treatment)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ treatment, labeller = label_both) +
  theme(legend.position = "right") + 
  scale_y_continuous(limits = c(min(BPRSL$bprs), max(BPRSL$bprs)))

# draw the plot of BPRSL with observed values
ggplot(BPRSL, aes(x = week, y = bprs, group= subject, linetype = treatment)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ treatment, labeller = label_both) +
  theme(legend.position = "right") + 
  scale_y_continuous(limits = c(min(BPRSL$bprs), max(BPRSL$bprs)))

*A vector of fitted values is created and added to the BPRSL data. Next fitted values from the model are plotted.
The both treatments show decrease of bprs points over time.

#RATSL data analysis
#tracking without standardization
library(ggplot2)
ggplot(RATSL, aes(x = Time, y = Weight, linetype = ID)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ Group, labeller = label_both) +
  theme(legend.position = "none") + 
  scale_y_continuous(limits = c(min(RATSL$Weight), max(RATSL$Weight)))


#tracking phenomenan plots
RATSL <- RATSL %>%
  group_by(Time) %>%
  mutate(stdweight = (Weight - mean(Weight))/sd(Weight) ) %>%
  ungroup()
glimpse(RATSL)
ggplot(RATSL, aes(x = Time, y = stdweight, linetype = ID)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ Group, labeller = label_both) +
  scale_y_continuous(name = "standardized weights")

#standard error calculation
# Number of weeks, baseline (week 0) included
n <- RATSL$Time %>% unique() %>% length()

# Summary data with mean and standard error of bprs by group and time 
RATSSS <- RATSL %>%
  group_by(Group, Time) %>%
  summarise( mean = mean(Weight), se = sd(Weight)/sqrt(n) ) %>%
  ungroup()

*Mouse having more weight in the beginning tends to have higher weight at the end. Therefore the weights are standardized to see the difference more clearly by groups. 
In standardization, the mean is 0.

# Glimpse the data
glimpse(RATSSS)

# Plot the mean profiles
ggplot(RATSSS, aes(x = Time, y = mean, linetype = Group, shape = Group)) +
  geom_line() +
  scale_linetype_manual(values = c(1,2,3)) +
  geom_point(size=3) +
  scale_shape_manual(values = c(1,2,3)) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se, linetype="1"), width=0.3) +
  theme(legend.position = c(0.8,0.8)) +
  scale_y_continuous(name = "mean(Weight) +/- se(Weight)")
RATSL$Time

*Mean weight gain profiles are drawn. All groups gain wieght, but groups 2 and 3 gain weight faster than group 1. 
Group 2 gained the most weight, but there is more variance in it compared to other groups.

#means and outlier checking
# Create a summary data by treatment and subject with mean as the summary variable (ignoring baseline week 0).
RATSSL8S <- RATSL %>%
  filter(Time > 1) %>%
  group_by(Group, ID) %>%
  summarise( mean=mean(Weight))

*Means from weeks 8-64 are calculate to check the mean development.
The week 1 is not included as there was no change i weight due to dietary changes.
# Glimpse the data
glimpse(RATSSL8S)
# Draw a boxplot of the mean versus treatment
ggplot(RATSSL8S, aes(x = Group, y = mean)) +
  geom_boxplot() +
  stat_summary(fun.y = "mean", geom = "point", shape=23, size=4, fill = "white") +
  scale_y_continuous(name = "mean(Weight), weeks 8-64")

# Create a new data by filtering the outlier and adjust the ggplot code the draw the plot again with the new data
RATSSL8S1 <- RATSSL8S %>%
  filter(mean < 550 & mean>250)
ggplot(RATSSL8S1, aes(x = Group, y = mean)) +
  geom_boxplot() +
  stat_summary(fun.y = "mean", geom = "point", shape=23, size=4, fill = "white") +
  scale_y_continuous(name = "mean(Weight), weeks 8-64")

* Outliers more than 550 and under 250 outliers are excluded from data.

#anova test
# Perform a two-sample t-test cannot be run, because there are more than two groups. Anova is used instead
#t.test(mean ~ Group, data = RATSSL8S1, var.equal = TRUE)
# Add the baseline from the original data as a new variable to the summary data
RATSSL8S2 <- RATSSL8S %>%
  mutate(baseline = RATS$Time1)
# Fit the linear model with the mean as the response 
fit <- lm(mean ~ Group, data = RATSSL8S2)

# Compute the analysis of variance table for the fitted model with anova()
anova(fit)
confint(fit)

*Anova is used instead of T-test as there are more than two groups.
P value is < 0.05 demonstrating significant relationship between group and weight.
F value is high. Confidence intervals for group 2 and group 3 are also shown. 
concluding that nutritional changes are meaningful.

#Liner model, just for fun
simple_linear_model_rats <- lm(Weight ~ Group + Time, data = RATSL)
summary(simple_linear_model_rats)

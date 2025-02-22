install.packages("car")       
install.packages("boot") 
install.packages("ggplot2")   
install.packages("lme4")        
install.packages("RColorBrewer")
install.packages("tidyverse")    
install.packages("effectsize") 
install.packages("multcomp")
install.packages("rcompanion", dependencies = TRUE)   
install.packages("nlme")  


library(car)
library(boot)
library(ggplot2)
library(lme4)
library(RColorBrewer)
library(tidyverse)
library(effectsize)
library(rcompanion)
library(nlme)
brewer.pal(n=9,"Pastel1")
library("Hmisc")

#between subject design; referring to format of instructions (between condition-comparing between two groups boys vs girs)(within condition - all girls)

data <- read.csv('Final Report/ST-P 2 Dataset use this!!!.csv')


#### Figures for Open-Ended Explanations Measure
table(data$Condition, data$robot_OE_cat)
table(data$Condition, data$puzzle_OE_cat)

#robot
#creating dataframe for the plot

#change the number according the the number of explanation types
Condition <- c(rep("Baseline" , 5) , rep("Between" , 5) , rep("Within" , 5)) 
# 3 refers to 3 conditions
Explanation_Type <- rep(c("Intrinsic", "Structural", "Extrinsic", "Other", "Structural+Intrinsic") , 3)
#review the numbers later
value <- c(9/11,0,1/11,1/11,0,6/11,0,0,2/11,2/11,4/15,10/15,1/15,0,0)
table <- data.frame(Condition,Explanation_Type)
table$Explanation_Type<- with(table, factor(Explanation_Type, levels=c("Intrinsic","Structural","Extrinsic","Other","Structural+Intrinsic")))

ggplot(table, aes(fill=Explanation_Type, y=value, x=Condition)) + 
  geom_bar(position="fill", stat="identity", aes(fill=Explanation_Type))+
  labs(y="Percent of Children Gave Explanation", x="Condition")+
  scale_fill_manual(values = c("Intrinsic" = "#FBB4AE",
                               "Structural"="#1F78B4",
                               "Other"="#F2F2F2",
                               "Extrinsic"= "purple",
                               "Structural+Intrinsic"="red"))+
  theme_bw()

#puzzle
Condition <- c(rep("Baseline" , 4) , rep("Between" , 4) , rep("Within" , 4))
Explanation_Type <- rep(c("Intrinsic", "Structural", "Extrinsic", "Other") , 3)
#review the numbers later
value <- c(5/6,1/6,0,0,3/4,0,0,1/4,3/6,1/6,1/6,1/6)
table <- data.frame(Condition,Explanation_Type)
table$Explanation_Type<- with(table, factor(Explanation_Type, levels=c("Intrinsic","Structural","Extrinsic","Other")))

ggplot(table, aes(fill=Explanation_Type, y=value, x=Condition)) + 
  geom_bar(position="fill", stat="identity", aes(fill=Explanation_Type))+
  labs(y="Percent of Children Gave Explanation", x="Condition")+
  scale_fill_manual(values = c("Intrinsic" = "#FBB4AE",
                               "Structural"="#1F78B4",
                               "Extrinsic"="plum",
                               "Other"="#F2F2F2"))+
  theme_bw()
#think about how we can help children generalize it to another scenario (discussion section)

#### Figures for Explanation Ratings
#exchanging really right into a number 
data$robot_ability <-replace(data$robot_ability, data$robot_ability_r == "Really right", 4)
data$robot_ability <-replace(data$robot_ability, data$robot_ability_r == "A little right", 3)
data$robot_ability <-replace(data$robot_ability, data$robot_ability_nr == "A little not right", 2)
data$robot_ability <-replace(data$robot_ability, data$robot_ability_nr == "Really not right", 1)

data$robot_interest <-replace(data$robot_interest, data$robot_interest_r == "Really right", 4)
data$robot_interest <-replace(data$robot_interest, data$robot_interest_r == "A little right", 3)
data$robot_interest <-replace(data$robot_interest, data$robot_interest_nr == "A little not right", 2)
data$robot_interest <-replace(data$robot_interest, data$robot_interest_nr == "Really not right", 1)

data$robot_structural <-replace(data$robot_structural, data$robot_structural_r == "Really right", 4)
data$robot_structural <-replace(data$robot_structural, data$robot_structural_r == "A little right", 3)
data$robot_structural <-replace(data$robot_structural, data$robot_structural_nr == "A little not right", 2)
data$robot_structural <-replace(data$robot_structural, data$robot_structural_nr == "Really not right", 1)

data$robot_control <-replace(data$robot_control, data$robot_control_r == "Really right", 4)
data$robot_control <-replace(data$robot_control, data$robot_control_r == "A little right", 3)
data$robot_control <-replace(data$robot_control, data$robot_control_nr == "A little not right", 2)
data$robot_control <-replace(data$robot_control, data$robot_control_nr == "Really not right", 1)

data$puzzle_ability <-replace(data$puzzle_ability, data$puzzle_ability_r == "Really right", 4)
data$puzzle_ability <-replace(data$puzzle_ability, data$puzzle_ability_r == "A little right", 3)
data$puzzle_ability <-replace(data$puzzle_ability, data$puzzle_ability_nr == "A little not right", 2)
data$puzzle_ability <-replace(data$puzzle_ability, data$puzzle_ability_nr == "Really not right", 1)

data$puzzle_interest <-replace(data$puzzle_interest, data$puzzle_interest_r == "Really right", 4)
data$puzzle_interest <-replace(data$puzzle_interest, data$puzzle_interest_r == "A little right", 3)
data$puzzle_interest <-replace(data$puzzle_interest, data$puzzle_interest_nr == "A little not right", 2)
data$puzzle_interest <-replace(data$puzzle_interest, data$puzzle_interest_nr == "Really not right", 1)

data$puzzle_structural <-replace(data$puzzle_structural, data$puzzle_structural_r == "Really right", 4)
data$puzzle_structural <-replace(data$puzzle_structural, data$puzzle_structural_r == "A little right", 3)
data$puzzle_structural <-replace(data$puzzle_structural, data$puzzle_structural_nr == "A little not right", 2)
data$puzzle_structural <-replace(data$puzzle_structural, data$puzzle_structural_nr == "Really not right", 1)

data$puzzle_control <-replace(data$puzzle_control, data$puzzle_control_r == "Really right", 4)
data$puzzle_control <-replace(data$puzzle_control, data$puzzle_control_r == "A little right", 3)
data$puzzle_control <-replace(data$puzzle_control, data$puzzle_control_nr == "A little not right", 2)
data$puzzle_control <-replace(data$puzzle_control, data$puzzle_control_nr == "Really not right", 1)

#figure out rcompanion installation & error bars
# maybe we have high structural ratings bc intuitively it makes sense even without the stimuli, the structural explanation

#robot
df.1.ratings = reshape(data, direction = "long", idvar = "ID",
                       varying = list(c('robot_structural', 'robot_ability', 'robot_interest', 'robot_control')),
                       v.names = c("rating"),
                       timevar = "explanation", times = c("Structural", "Intrinsic-ability", "Intrinsic-interest", "Random"))
df.1.ratings$explanation <- factor(df.1.ratings$explanation, levels = c("Structural", "Intrinsic-ability", "Intrinsic-interest", "Random"))

# ggplot
#intrinsic explanations decrease in within condition as well. 
ggplot(df.1.ratings, aes(x = Condition, y = rating, group = explanation, fill = explanation)) +
  # means
  geom_bar(stat = "summary", position = "dodge", color = "black") +
  # color of bars
  scale_fill_manual(values=c("#1F78B4","#FBB4AE","#fbaecf","snow3")) +
  # error bars
  stat_summary(fun.data="mean_cl_normal", 
               fun.args = list(mult=1), 
               geom ="errorbar", 
               width = .2,
               position = position_dodge(width = .9)) +
  # raw data
  geom_point(aes(x = Condition, y = rating, group = explanation), 
             shape = 21,
             alpha = .8, 
             position = position_jitterdodge(jitter.width = 0.2, 
                                             jitter.height=0.1, 
                                             dodge.width=0.9),
             color = "white") +
  # y-axis
  coord_cartesian(ylim = c(1, 4)) +
  xlab("Condition") +
  ylab("Rating of Explanation") +
  # legend title
  guides(fill=guide_legend(title="Explanation")) +
  # plot title
  # theme
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5, size = 20, face = "bold"),
        axis.title = element_text(size = 18),
        axis.text = element_text(size = 16),
        legend.title = element_text(size = 18),
        legend.text = element_text(size = 16),
        legend.position = "right")

  
#puzzle
df.2.ratings = reshape(data, direction = "long", idvar = "ID",
                         varying = list(c('puzzle_structural', 'puzzle_ability', 'puzzle_interest', 'puzzle_control')),
                         v.names = c("rating"),
                         timevar = "explanation", times = c("Structural", "Intrinsic-ability", "Intrinsic-interest", "Random"))
df.2.ratings$explanation <- factor(df.1.ratings$explanation, levels = c("Structural", "Intrinsic-ability", "Intrinsic-interest", "Random"))
  
  # RATINGS PLOT
  # ggplot
ggplot(df.2.ratings, aes(x = Condition, y = rating, group = explanation, fill = explanation)) +
    # means
    geom_bar(stat = "summary", position = "dodge", color = "black") +
    # color of bars
    scale_fill_manual(values=c("#1F78B4","#FBB4AE","#fbaecf","snow3")) +
    # error bars
    stat_summary(fun.data="mean_cl_normal", 
                 fun.args = list(mult=1), 
                 geom ="errorbar", 
                 width = .2,
                 position = position_dodge(width = .9)) +
    # raw data
    geom_point(aes(x = Condition, y = rating, group = explanation), 
               shape = 21,
               alpha = .8, 
               position = position_jitterdodge(jitter.width = 0.2, 
                                               jitter.height=0.1, 
                                               dodge.width=0.9),
               color = "white") +
    # y-axis
    coord_cartesian(ylim = c(1, 4)) +
    xlab("Condition") +
    ylab("Rating of Explanation") +
    # legend title
    guides(fill=guide_legend(title="Explanation")) +
    # plot title
    # theme
    theme_bw() + 
    theme(plot.title = element_text(hjust = 0.5, size = 20, face = "bold"),
          axis.title = element_text(size = 18),
          axis.text = element_text(size = 16),
          legend.title = element_text(size = 18),
          legend.text = element_text(size = 16),
          legend.position = "right")


# Analysis for OE Measure
# robot - Chi Square
chisq.test(data$Condition, data$robot_OE_cat)
cramerV(data$Condition, data$robot_OE_cat)

# robot - data cleaning for logistic regression
data$robot.open.struc = 0
data$robot.open.struc[data$robot_OE_cat == "structural"] = 1

data$robot.open.intrnsc = 0
data$robot.open.intrnsc[data$robot_OE_cat == "intrinsic"] = 1

data$robot.open.other = 0
data$robot.open.other[data$robot_OE_cat == "other"] = 1


# robot - logistic regressions
## structural
#check there's no age or gender effect
logistic.struc <- glm(robot.open.struc ~ Condition*AgeYears*Gender, data = data, family = "binomial") 
summary(logistic.struc)
#compared to baseline
data$Condition <- factor(data$Condition, levels = c("Baseline","Between", "Within"))
logistic.struc <- glm(robot.open.struc ~ Condition, data = data, family = "binomial")
summary(logistic.struc)
exp(logistic.struc$coefficients['ConditionBetween']) #odds ratio
exp(logistic.struc$coefficients['ConditionWithin']) #odds ratio
#within compared to between
data$Condition <- factor(data$Condition, levels = c("Between", "Baseline","Within"))
logistic.struc <- glm(robot.open.struc ~ Condition, data = data, family = "binomial")
summary(logistic.struc)

## intrinsic
#check there's no age or gender effect
logistic.intr <- glm(robot.open.intrnsc ~ Condition*AgeYears*Gender, data = data, family = "binomial") 
summary(logistic.intr)
#compared to baseline
data$Condition <- factor(data$Condition, levels = c("Baseline","Between", "Within"))
logistic.intr <- glm(robot.open.intrnsc ~ Condition, data = data, family = "binomial")
summary(logistic.intr)
exp(logistic.intr$coefficients['ConditionBetween']) #odds ratio
exp(logistic.intr$coefficients['ConditionWithin']) #odds ratio
#within compared to between
data$Condition <- factor(data$Condition, levels = c("Between", "Baseline","Within"))
logistic.intr <- glm(robot.open.intrnsc ~ Condition, data = data, family = "binomial")
summary(logistic.intr)

## other
#check there's no age or gender effect
logistic.intr <- glm(robot.open.other ~ Condition*AgeYears*Gender, data = data, family = "binomial") 
summary(logistic.intr)
#compared to baseline
data$Condition <- factor(data$Condition, levels = c("Baseline","Between", "Within"))
logistic.intr <- glm(robot.open.other ~ Condition, data = data, family = "binomial")
summary(logistic.intr)
exp(logistic.intr$coefficients['ConditionBetween']) #odds ratio
exp(logistic.intr$coefficients['ConditionWithin']) #odds ratio
#within compared to between
data$Condition <- factor(data$Condition, levels = c("Between", "Baseline","Within"))
logistic.intr <- glm(robot.open.other ~ Condition, data = data, family = "binomial")
summary(logistic.intr)


# puzzle - Chi Square
chisq.test(data$Condition, data$puzzle_OE_cat)
cramerV(data$Condition, data$puzzle_OE_cat)

# puzzle - data cleaning for logistic regression
data$puzzle.open.struc = 0
data$puzzle.open.struc[data$puzzle_OE_cat == "structural"] = 1

data$puzzle.open.intrnsc = 0
data$puzzle.open.intrnsc[data$puzzle_OE_cat == "intrinsic"] = 1

data$puzzle.open.other = 0
data$puzzle.open.other[data$puzzle_OE_cat == "other"] = 1


# puzzle - logistic regressions
## structural
#check there's no age or gender effect
logistic.struc <- glm(puzzle.open.struc ~ Condition*AgeYears*Gender, data = data, family = "binomial") 
summary(logistic.struc)
#compared to baseline
data$Condition <- factor(data$Condition, levels = c("Baseline","Between", "Within"))
logistic.struc <- glm(puzzle.open.struc ~ Condition, data = data, family = "binomial")
summary(logistic.struc)
exp(logistic.struc$coefficients['ConditionBetween']) #odds ratio
exp(logistic.struc$coefficients['ConditionWithin']) #odds ratio
#within compared to between
data$Condition <- factor(data$Condition, levels = c("Between", "Baseline","Within"))
logistic.struc <- glm(puzzle.open.struc ~ Condition, data = data, family = "binomial")
summary(logistic.struc)

## intrinsic
#check there's no age or gender effect
logistic.intr <- glm(puzzle.open.intrnsc ~ Condition*AgeYears*Gender, data = data, family = "binomial") 
summary(logistic.intr)
#compared to baseline
data$Condition <- factor(data$Condition, levels = c("Baseline","Between", "Within"))
logistic.intr <- glm(puzzle.open.intrnsc ~ Condition, data = data, family = "binomial")
summary(logistic.intr)
exp(logistic.intr$coefficients['ConditionBetween']) #odds ratio
exp(logistic.intr$coefficients['ConditionWithin']) #odds ratio
#within compared to between
data$Condition <- factor(data$Condition, levels = c("Between", "Baseline","Within"))
logistic.intr <- glm(puzzle.open.intrnsc ~ Condition, data = data, family = "binomial")
summary(logistic.intr)

## other
#check there's no age or gender effect
logistic.intr <- glm(puzzle.open.other ~ Condition*AgeYears*Gender, data = data, family = "binomial") 
summary(logistic.intr)
#compared to baseline
data$Condition <- factor(data$Condition, levels = c("Baseline","Between", "Within"))
logistic.intr <- glm(puzzle.open.other ~ Condition, data = data, family = "binomial")
summary(logistic.intr)
exp(logistic.intr$coefficients['ConditionBetween']) #odds ratio
exp(logistic.intr$coefficients['ConditionWithin']) #odds ratio
#within compared to between
data$Condition <- factor(data$Condition, levels = c("Between", "Baseline","Within"))
logistic.intr <- glm(puzzle.open.other ~ Condition, data = data, family = "binomial")
summary(logistic.intr)



# Analysis for CE measure

# ANOVA for robot
# structural
res.aov <- aov(robot_structural ~ Condition, data = data)
summary(res.aov)
effectsize::eta_squared(model = res.aov)

# ability
res.aov <- aov(robot_ability ~ Condition, data = data)
summary(res.aov)
effectsize::eta_squared(model = res.aov)

# interest
res.aov <- aov(robot_interest ~ Condition, data = data)
summary(res.aov)
effectsize::eta_squared(model = res.aov)

# random
res.aov <- aov(robot_control ~ Condition, data = data)
summary(res.aov)
effectsize::eta_squared(model = res.aov)

# Linear regression for robot
data$Condition <- factor(data$Condition, levels = c("Baseline", "Between","Within"))

# structural
linear.struc <- lm(robot_structural ~ Condition, data = data)
summary(linear.struc)

# ability
linear.abil <- lm(robot_ability ~ Condition, data = data)
summary(linear.abil)

# interest
linear.inter <- lm(robot_interest ~ Condition, data = data)
summary(linear.inter)

# control
linear.cntrl <- lm(robot_control ~ Condition, data = data)
summary(linear.cntrl)


# ANOVA for puzzle
# structural
res.aov <- aov(puzzle_structural ~ Condition, data = data)
summary(res.aov)
effectsize::eta_squared(model = res.aov)

# ability
res.aov <- aov(puzzle_ability ~ Condition, data = data)
summary(res.aov)
effectsize::eta_squared(model = res.aov)

# interest
res.aov <- aov(puzzle_interest ~ Condition, data = data)
summary(res.aov)
effectsize::eta_squared(model = res.aov)

# random
res.aov <- aov(puzzle_control ~ Condition, data = data)
summary(res.aov)
effectsize::eta_squared(model = res.aov)


# Linear regression for puzzle
data$Condition <- factor(data$Condition, levels = c("Baseline", "Between","Within"))

# structural
linear.struc <- lm(puzzle_structural ~ Condition, data = data)
summary(linear.struc)

# ability
linear.abil <- lm(puzzle_ability ~ Condition, data = data)
summary(linear.abil)

# interest
linear.inter <- lm(puzzle_interest ~ Condition, data = data)
summary(linear.inter)

# control
linear.cntrl <- lm(puzzle_control ~ Condition, data = data)
summary(linear.cntrl)




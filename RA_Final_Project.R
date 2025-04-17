#Loading the libraries
library(readxl)
library(MPV)
library(lattice)
library(leaps)
library(car)
library(MASS)
library(GGally)
library(corrplot)

# Loading the dataset
energy_data <- read_excel("ENB2012_data.xlsx")
energy_data

# Converting the categorical variables to type factor
energy_data$X6 <- as.factor(energy_data$X6)
levels(energy_data$X6)
levels(energy_data$X6) <- c("North", "East", "South", "West")

energy_data$X8 <- as.factor(energy_data$X8)
levels(energy_data$X8)
levels(energy_data$X8) <- c("Unknown", "Uniform", "North", "East", "South", "West")

# Checking for missing values
sum(is.na(energy_data)) > 0

#Structure and Summary statistics
names(energy_data)
str(energy_data)
summary(energy_data)

data <- energy_data[,c("X1","X2","X3","X4","X5","X6","X7","X8","Y2")]

# Distribution of Cooling Load
ggplot(data, aes(x = Y2)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "black") +
  theme_minimal() +
  ggtitle("Distribution of Cooling Load") +
  xlab("Cooling Load") +
  ylab("Frequency")

# Boxplot of Cooling Load by Glazing area distribution
ggplot(data, aes(x = X8, y = Y2, fill = X8)) +
  geom_boxplot() +
  theme_minimal() +
  ggtitle("Boxplot of Cooling Load by Glazing area distribution") +
  xlab("Glazing area distribution") +
  ylab("Cooling Load")

# Correlation heatmap
par(mfrow=c(1,1))
numeric_vars <- data[, sapply(data, is.numeric)]
cor_matrix <- cor(numeric_vars, use = "complete.obs")
corrplot(cor_matrix, method = "color", type = "upper", tl.col = "black", tl.cex = 0.8)

y <- energy_data$Y2
x1 <- energy_data$X1
x2 <- energy_data$X2
x3 <- energy_data$X3
x4 <- energy_data$X4
x5 <- energy_data$X5
x6 <- energy_data$X6
x7 <- energy_data$X7
x8 <- energy_data$X8

model1<-lm(y~x1+x2+x3+x4+x5+x6+x7+x8, data=energy_data)
summary(model1)

alias_info <- alias(model1)
print(alias_info)

model<-lm(y~x1+x2+x3+x5+x6+x7+x8, data=energy_data)
summary(model)

anova_res <- anova(model)
anova_res

# Residual Analysis
par(mfrow=c(2,2))
plot(model)

# Test for constant variance/Homoscedasticity
ncvTest(model)

# Test for Autocorrelated Errors
durbinWatsonTest(model)

# Test for Normally Distributed Errors
shapiro.test(model$residuals)

# Test for Linearity  
crPlots(model)

# Outlier Test 
outlierTest(model)

# Leverage and Influential point check
summary(influence.measures(model))

# Test for multicollinearity 
vif(model)

par(mfrow=c(1,1))
bc <- boxcox(y~x1+x2+x3+x5+x6+x7+x8)
lambda_opt <- bc$x[which.max(bc$y)]
print(lambda_opt)

t_y = (y^lambda_opt-1)/lambda_opt

model2 <- lm(t_y~x1+x2+x3+x5+x6+x7+x8, data=energy_data)
summary(model2)

anova_res <- anova(model2)
anova_res

# Residual Analysis
par(mfrow=c(2,2))
plot(model2)

# Test for constant variance/Homoscedasticity
ncvTest(model2)

# Test for Autocorrelated Errors
durbinWatsonTest(model2)

# Test for Normally Distributed Errors
shapiro.test(model2$residuals)

# Test for Linearity  
crPlots(model2)

# Outlier Test 
outlierTest(model2)

# Leverage and Influential point check
summary(influence.measures(model2))

# Test for multicollinearity 
vif(model2)

#Finding the best subset model
r<-leaps::regsubsets(t_y~x1+x2+x3+x5+x6+x7+x8, data=energy_data)
summary(r)

Bic<-summary(r)$bic
Bic

par(mfrow=c(1,1))
plot(r, scale="bic")

plot(Bic, xlab = "Number of Predictors", ylab = "BIC", 
     type = 'l', lwd = 2)

fit_bic1= lm(t_y~x3+x5+x7+x8, data=energy_data)
summary(fit_bic1)

# Residual Analysis
par(mfrow=c(2,2))
plot(fit_bic1)

# Test for constant variance/Homoscedasticity
ncvTest(fit_bic1)

# Test for Autocorrelated Errors
durbinWatsonTest(fit_bic1)

# Test for Normally Distributed Errors
shapiro.test(fit_bic1$residuals)

# Test for Linearity  
crPlots(fit_bic1)

# Outlier Test 
outlierTest(fit_bic1)

# Leverage and Influential point check
summary(influence.measures(fit_bic1))

# Test for multicollinearity 
vif(fit_bic1)

# Predicting the Cooling Load
predicted <- predict(fit_bic1, newdata = data.frame(x3 = 417, x5 = 7, x7 = 0.4, x8 = "East"))
pred_og <- (predicted * lambda_opt + 1)^(1 / lambda_opt)
pred_og



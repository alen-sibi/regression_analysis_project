# Regression Analysis Project
The aim of this project is to analyse the “Energy Efficiency” dataset from the UCI Machine Learning Repository and study the contribution of several building features such as Relative Compactness, Surface Area, Wall Area, Overall Height, Orientation etc. on the target feature - Cooling Load, using the concepts of multiple linear regression. Additionally, model adequacy checks and variable selection procedures are performed on the dataset for achieving the model with the most significant variables. Finally, the ideal regression model chosen after appropriate model validation is used to predict the cooling load.

The dataset taken into consideration for this project was the “Energy Efficiency” dataset from the UCI Machine Learning Repository. The dataset consisted of a total of 10 variables with 768 observations of various attributes with different building shapes. Among the 10 variables 8 were feature variables and 2 were target variables. The attributes and their definitions are given in the below table.

    Variable Name         Definition                        Type                    Unit
    -----------------------------------------------------------------------------------------------------------
    X1                    Relative Compactness              Numerical                -
    X2                    Surface Area                      Numerical                m^2
    X3                    Wall Area                         Numerical                m^2
    X4                    Roof Area                         Numerical                m^2
    X5                    Overall Height                    Numerical                m
    X6                    Orientation                       Categorical              -
    X7                    Glazing Area                      Numerical                Proportion of Floor area
    X8                    Glazing Area Distribution         Categorical              -
    Y1                    Heating Load                      Numerical                kWh/m^2 
    Y2                    Cooling Load                      Numerical                kWh/m^2 
    
The categorical variable X6 has four levels representing - "North", "East", "South" and "West" and X8 has six levels representing - "Unknown", "Uniform", "North", "East", "South" and "West". Of these variables Cooling Load (Y2) was taken as our target variable and X1 to X8 were chosen as the predictor variables.

Firstly, the dataset was checked for missing values and further exploratory data analysis was performed on the dataset in order to get an idea regarding the relationship between the target and feature attributes. After data cleaning, a multiple linear regression model was fit for the target variable (Y2) using all the other regressor variables and model assessment was performed on this model. Furthermore, model adequacy and diagnostic tests were also performed on this dataset for checking factors like homoscedasticity and normality of residuals. Additionally, BoxCox transformations were performed on the response variable and a new model was created using the transformed data in an attempt to improve the model adequacy conditions. The final model made was the subset model created using the regressor variables chosen through the all-possible regression approach with BIC as the criterion. Model adequacy and diagnostic checks were carried out on this final model as well. Lastly a prediction for the Cooling Load was made using the best model found out through model validation.

Instructions to run the code:

* Download the ENB2012_data.xlsx from the UCI Machine Learning repository.
* Run the code in R to view the results.

X = matrix(rnorm(200), ncol = 5)
y = as.matrix(rnorm(40))

# Bundling data variables into dataframe
train_data <- data.frame(X,y)

# Training model for generating prediction
lmodel<- lm(y~ train_data $X1 + train_data $X2 + train_data $X3 +
                train_data $X4 + train_data $X5,data= train_data)
summary(lmodel)
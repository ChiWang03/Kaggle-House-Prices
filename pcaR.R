#Since we have already saved the numeric 
#dataset from running pca in python lets
#just run this to make sure everyhting's working correctly
train <- read.csv("train_cleaned.csv")
df <- read.csv("numeric_forpca.csv")


#So we have 23 princpial components 
housepca <- prcomp(df, scale.=TRUE)
summary(housepca)


# And as mentioned in the ipython notebook 
# we retain 90% of the variability with 15 principal components 
# but apparently the scree plot tells us that we should probably pick 4 principal components since that's where the elbow is

plot(housepca, type="lines") 

# But if we were to use the Kaiser criterion we would only keep up to 8 components 
# So different from the 90% variablity we discussed in the notebbook we will 
# take the averaage amount of principal componets from the different decision methods 
# so lets take 8 predicotors explaing 64% of the variability



#store the scores 
scr <- housepca$x[,1:8]
scr

# Principal Componenet Regression 

#now lets run the multiple linear regression on the pc's 
#lets first get the response varialbe from the training set 

pcregmod <- lm(train$SalePrice ~ scr)
summary(pcregmod)
# Observing the output only PC1 is significant based on the pvalue of the null hypothesis 
# And R squared is extremely low at 0.09818
# so this kind of concludes that hey not much is very useful and significant for modelling 
# We may look in to different methods or maybe the numeric variables are the best predictors for this model




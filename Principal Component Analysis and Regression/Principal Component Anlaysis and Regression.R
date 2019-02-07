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


#lets look at some loadings 
housepca$rotation[,1:4] 
# By looking at PC1 with a cutoff at 0.3 we can see that 
# TotalBsmtSF, X1stFlrSF, GrLivArea,GarageArea,TotalSF has a large magnitude
# PC1 probabily explains the size of the house more or less the higher a house scores in these parts 
# the more expensive the house it makes a lot of sense as well since the total square feet has the largest magnitude

# PC2 seems LowQualFinSF, EnclosedPorch, Age, RemodAge seems to do with the quality of the house 
# With the negative loadings meaning if a house scores high in age and low quality finish and even 
# a large in door porch the price of the price of the house wont be that high 

# PC3 has high magnitude loadings in BsmtFinSF1 and BsmtUnfSF
# this explains the basement conditions of the house 
# high negative loadings with BsmtUnfSF means that the more
# unfinished area of the basement the cheaper the house
# The higher a house scores on the area of type 1 finishing the higher the price of the house
# This also makes sense since for a basement to be considered finished it needs to meet most of the conditiosn for a finished house
# in regards to the lights walls electricty .....


# PC4 Has high magnitudes with garage age and LowQualFinSF
# this seems quite arbbitary so im not sure what we can conclude of PC4 
# since garage age has postive loadings it may mean the older the garage the higher the price 
# This doesnt really add up and so is it for lowQualFinSF

# These interpretations would be useful in the latter analysis 


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

# Now maybe we take only what the Kaiser Criterion tells us to 
scr_Kaiser <- housepca$x[,1:4]
pcregKaiser <- lm(train$SalePrice ~ scr_Kaiser)
summary(pcregKaiser)

# And it is not too greate either 
# lets just take PC1 

scr_PC1<- housepca$x[,1:1]
pcregPC1 <- lm(train$SalePrice ~ scr_PC1)
summary(pcregPC1)
# and we still get a pretty bad result but we do see that PC1 
# explains most of the variance and it is contriubting to the
# R squared the most since it didnt change much over subtracting the predictors. 





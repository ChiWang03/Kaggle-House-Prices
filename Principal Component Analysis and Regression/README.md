# Kaggle-House-Prices
## Principal Component Analysis in Python and R

Through princpal compoenet analysis we were able to use dimension reduction to see that only 8 principal components show 64% of the variablitiy of the data. 

However, as you run pca regression with these 8 components or even 15 components the results of the multiple linear regression were aweful. R-sqaured and Adjust R-sqaured were around 0.1.

Therefore I took away a component everytime I fitted the linear model and as expected, the first principal component explains most of the variance so it also contributes most to the Adjusted R-squared, which is 0.098 for the 1 model predictor. 

This indicates that the numeric variables in this data set aren't that useful in predicitng the sale prices. To be fair not even PC1 is useful. 

But for statistical inference, we can see that PC1 has large magnitudes in loadings: TotalBsmtSF, X1stFlrSF, GrLivArea,GarageArea, and TotalSF. This explains the size of the house, which indicates that the higher a house scores in these parts the more expensive the house is.

This indeed makes sense.


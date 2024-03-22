# Debt Impact on Economic Growth

## Introduction
The research is looking into how government debt might affect a country's economic growth, specifically its per-capita GDP. Think of this as trying to find out if borrowing too much money slows down a country's economy. Using data from the WorldBank, I cleaned up and organized the information for 12 different countries.  These countries were picked based on their influence in the world and the strength of their Currency. The goal is to see if there's a point where debt starts to hurt these countries' growth. To do this, we'll look at some basic stats, how things have changed over time, and use some simple models to get clearer insights. List from Forbes got used in order to help to help pick the countries, focusing on the most influential ones and those with strong currencies.

## Libraries used
- Pandas
- Numpy
- Matplolib.pyplot
- Seaborn
- Statsmodels.formula.api
- linearmodels

*No minimum Hardware Hardware requirements* 

## Table of Contents
- **Import of WorldBank Data**
- **Data cleaning**
    - Replacing the missing values with the numpy module to na
    - Separating the dataset to one dataframe for each country
    - Finding out the variation (using the Standard Deviation) of the data for each country
    - Figuring out the missing values of the data 
- **Descriptive Statistics**
    - Summary of the central tendency, dispersion, and shape of the distribution for the data of each Country
    - Analysis of the evolution of the Indicators through time of each country
    - Correlation Analysis between the indicators of each Country
    - Adding all the countries in a dataframe and analyzing the GDP Growth and the debt in debth 
    - Analyzing the rest Indicators
- **Econometric Analysis**
    - Correlation Analysis using Scatterplots
    - Regression analysis model for all the countries
    - Distinguishing the Countries to higher and lower Income
    - Regression Analysis model on lower Income Countries and on Higher Income Countries
    - Comparing the prediction of the model to the reality of GDP Growth

### Project Status: It is still being developed

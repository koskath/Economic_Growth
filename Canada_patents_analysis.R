
########## INSTALL THE LIBRARIES NEEDED ###############

#install.packages("readxl")
#install.packages("writexl")
#install.packages("dplyr")
#install.packages("Hmisc")
#install.packages("lattice")
#install.packages("survival")
#install.packages("Formula")
#install.packages("ggplot2")
#install.packages("corrplot")
#install.packages("reshape2")
#install.packages("GGally")
#install.packages("lmtest")

########## LOAD THE LIBRARIES TO READ AND IMPORT THE DATASET #############

#library("readxl")
#library("writexl")
#library("dplyr")
#library("reshape2")
#library("GGally")
#library("lmtest")
#library("Hmisc")
#library("lattice")
#library("survival")
#library("Formula")
#library("ggplot2")
#library("corrplot")


########## SET THE PATH FOR MY ENVIRONMENT ############

getwd()
setwd("C:/Users/kosta/Downloads")
patents <- read_excel("Canada_Patents.xlsx")

#Appyear: Application Year for patent registration 
#Appnumber: Patent Code
#Gyear : Official patent registration year
#Inventors: number of inventors  
#Nipc: number of ipc of each patent 
#ncpc: the number of CPCs of each patent
#backcites: the number of patent 
#claims: references to the patent 
#renew: renewal years 

####### Find out the length from the time of the application until the official date ##
patents$length <- patents$gyear - patents$appyear


#### Find out the longlasting patents #####
#### number 3 means the patent has been renewe after 7.5 years #####
patents$renew12 <- ifelse(patents$renew == 3,1,0)

#### combine the most important columns ####
x <- cbind(patents$inventors, patents$ncpc, patents$backcites, patents$claims, patents$length)

##### Descriptive statistics for the new dataset #####
summary(x)

##### Descriptive statistics for each column #####
summary(patents$renew)
summary(patents$renew12)
summary(patents$ncpc)
summary(patents$backcites)
summary(patents$claims)
summary(patents$length)
summary(patents$inventors)

### Standard Deviation ###
sd(patents$ncpc)
sd(patents$backcites)
sd(patents$claims)
sd(patents$length)
sd(patents$renew)
sd(patents$renew12)
sd(patents$inventors)

###### Mean ######
mean(patents$renew)
mean(patents$renew12)
mean(patents$ncpc)
mean(patents$backcites)
mean(patents$claims)
mean(patents$length)
mean(patents$inventors)

### Calculate the mean and standard deviation for each column and insert them in a table ####

stats <- data.frame(
  Mean = c(
    mean(patents$renew),
    mean(patents$renew12),
    mean(patents$ncpc),
    mean(patents$backcites),
    mean(patents$claims),
    mean(patents$length),
    mean(patents$inventors)
  ),
  SD = c(
    sd(patents$renew),
    sd(patents$renew12),
    sd(patents$ncpc),
    sd(patents$backcites),
    sd(patents$claims),
    sd(patents$length),
    sd(patents$inventors)
  )
)

### Name the rows according to the variables ###
row.names(stats) <- c("renew", "renew12", "ncpc", "backcites", "claims", "length", "inventors")
print(stats)

#### CORRELATION PLOT ####
cor_matrix <- cor(patents[, c("ncpc", "backcites", "claims", "length", "renew", "renew12", "inventors")], use="complete.obs")

#### Create the plot using ggplot using ggplot with a heatmap####
cor_matrix_melted <- melt(cor_matrix)

ggplot(data = cor_matrix_melted, aes(x=Var1, y=Var2, fill=value)) +
  geom_tile() + 
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1, 1), space = "Lab", name="Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  labs(title = "Correlation Matrix of Variables", x = "", y = "") 


### 2nd way kind of same display ####
corrplot(cor_matrix, method = "color", col = c("#FF0000", "#FFFFFF", "#0000FF"), 
         type = "upper", order = "hclust", 
         addCoef.col = "black", 
         tl.col="black", tl.srt=45, 
         diag=FALSE)


### Main scatterplot using all variables in one display #####
ggpairs(patents[, c("ncpc", "backcites", "claims", "length", "renew", "renew12", "inventors")])


# Separate scatterplot for claims and inventors as they seem to have the greatest correlation ###

variable1 <- patents$claims # Example: Number of non-patent citations
variable2 <- patents$inventors # Example: Number of claims

ggplot(patents, aes(x = variable1, y = variable2)) +
  geom_point(color = "#2C3E50", alpha = 0.6) +
  theme_minimal() + # Use a minimal theme
  theme(plot.title = element_text(hjust = 0.5),
        axis.text = element_text(color = "#34495E"), 
        axis.title = element_text(color = "#34495E"), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        legend.position = "none") + 
  labs(title = "Scatterplot of Claims vs Inventors", 
       x = "Claims", 
       y = "Inventors") 


### Regression ###

# Fitting the multiple linear regression model
model <- lm(claims ~ inventors + ncpc + backcites + renew, data = patents)

# Summary of the model to view coefficients and statistics
summary(model)

# Additional diagnostics
# Check for homoscedasticity
bptest(model)

# Plotting diagnostic plots for further analysis
par(mfrow=c(2,2))
plot(model)














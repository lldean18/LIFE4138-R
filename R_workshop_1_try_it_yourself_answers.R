# TRY IT YOURSELF ANSWERS

# Part 1

# 1 Create a vector, with 10 numbers, print your vector to the console
x <- c(1,2,3,4,5,6,7,8,9,10) # OR
x <- 1:10 # OR
x <- seq(1,10,1)
x # print to the console

# 2 Print the length of your vector to the console
length(x)

# 3 Replace the 4th number in your vector with 100
x[4] <- 100
x

# 4 Create another numeric vector and combine your 2 vectors into a matrix,
# print your matrix to the console
y <- 51:60
y
m <- cbind(x,y)
m
m <- rbind(x,y)
m

# 5 Print the dimensions of your matrix to the console
dim(m)

# 6 Create a data frame with 4 variables, 
# make your variables a mixture of character, numeric and logical classes.
var1 <- c("mouse", "cat")
var2 <- 1:2
var3 <- c(T,F)
var4 <- 60:61
df<- data.frame(var1,var2,var3,var4)
df

# 7 Print your 2nd variable to the screen using 2 different methods
df$var2
df[ ,2]

# BONUS Replace the first variable in your data frame with a new one
df$var1 <- c(6,8)
df



# Part 2

# 1 Clear your environment
rm(list = ls())

# 2 Create a data frame with 3 variables, one character, one numeric and one logical
df <- data.frame(name = c("John", "Sophie", "James"),
                 age = c(45,34,70),
                 coder = c(T,T,F))
df

# 3 Save the data frame to your project directory then remove in from your R environment
write.csv(df, "coder_data.csv", row.names = F)
rm(df)

# 4 Read the data frame that you saved back into R using the read.csv()function
df <- read.csv("coder_data.csv")

# 5 with read.table()
rm(df)
df <- read.table("coder_data.csv", header = T, sep = ",")

# 6 Create 2 numeric vectors and make a scatter plot of them, give your plot a title
num1 <- 1:100
num2 <- seq(1,1000,10)
plot(num1, num2, main = "Plot of num1 against num2")

# 7 Load the iris data and make some boxplots of the different variables
data(iris)
boxplot(iris$Sepal.Width ~ iris$Species)

# 8 BONUS: Add axis labels and a title to one of your boxplots
boxplot(iris$Sepal.Width ~ iris$Species, main = "this is a title",
        xlab = "Species", ylab = "Sepal Width")

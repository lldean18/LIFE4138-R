##################
#  R Workshop 1  #
##################

#### SECTION 1 ####

# printing the current working directory
getwd()

# R as a calculator
4
4 + 3 # addition
50 - 5 # minus
10 * 2000 # multiplication
9 / 3 # division
10 ^ 2 # to the power

# R can interpret text
"Hello world!"
'Hello world'
Hello world # text strings need quotation marks

# R as a logical interpreter
# works with numbers
2 == 2 # equals
5 > 10 # greater than
9 <= 10 # less than or equal to

# logical interpretation also works with strings
"Hedgehog" == "Hedgehog"
"Hedgehog" == "Squirrel"

# assigning objects
my_number <- 8473 # can be done with arrow
my_number2 = 348575 # or single equals sign
my_text <- "Hello world" 
my_text
My_text # Variable names are case sensitive to this object won't be found
1my_text <- "text" # variable names cannot start with a number (although they can contain numbers)
for <- "Hello world" # variable names cannot be key words e.g. for if or else

# numeric vectors
x <- c(1,2,3,4,5) # using the combine funtion
x <- 1,2,3,4,5 # without the c() function we will get an error
y <- 1:5 # using a semicolon
z <- seq( 1 , 5 , by = 1) # using the seq function

# string vectors
a <- c("Hedgehog", "Squirrel", "Pigeon")
b <- c("Pig", "Squirrel", "Horse")

# Logical vectors
e <- c(TRUE, FALSE, TRUE) # TRUE and FALSE have to be capitalised
e <- c(true, false, true) # lower case will not be recognised
e <- c(T,F,T) # can be abbreviated to T and F

# logical statement
f <- a == b # using variables
f

# Vector properties
class(x) # prints the class of the vector
class(a)
class(e)

length(x) # prints the length of the vector
length(a)
length(e)

# Mathematical operations on vectors
x <- 1:10 # create a new vector

# maths on the whole vector
x + 5
x - 5

# maths on two vectors
y <- 11:20
x + y
x * y

# vectors of different lengths
y <- 1:5
length(x)
length(y)

x + y # the shorter vector will be repeated

# what if the shorter vector is not a multiple of longer one?
z <- 1:3
y * z # you will get a warning and the output will not be sensible

# accessing parts of a vector
x <- c("dog", "cat", "mouse")
x[] # use square brackets
x[1] # accessing the first element
x[c(1,3)] # accessing the first and third element
x[2:3] # accessing the second to the third element

# change the contents of a vector
x[c(2,3)] <- c("elephant", "giraffe") # replace elements 2 and 3
x
x[3] <- NA # replace element 3 with NA

# placeholders in R
NA # not available
NaN # not a number
Inf # infinity


# Matrices

# make a matrix
x <- 1:4
y <- 21:24

z <- cbind(x ,y) # bind by column
z

z <- rbind(x, y) # bind by row
z

# Properties of matrix
class(z) # print the class
is.matrix(z) # logical question
is.matrix(a)
dim(z) # dimensions
nrow(z) # number of rows
ncol(z) # number of columns

# limitations of matrices
x <- c("Hedgehog", "Squirrel", "Pigeon") # character vector
y <- c("Pig", "Cow", "Sheep") # character vector
z <- c(1,2,3) # numeric vector
m <- cbind(x,y,z) # the numeric vector is coerced into a string
m

# accessing parts of a matrix
m <- matrix(1:10, ncol = 2) # create a new matrix
m

m[1, ] # print the first row
m[ ,2] # print the second column
m[1,2] # print the element in the first row of the second column


# Data frames

# Making a data frame
name <- c("Hedgehog", "Squirrel", "Pigeon", "Fox") # string vector
height <- c(15,16,23.3,70.3) # numeric vector
age <- c(2,1,3,5) # integer vector

df <- data.frame(name, height, age) # merge the vectors into a data frame
df

# getting info about our data frame
str(df) # structure
class(df) # class
is.data.frame(df) # logical question
dim(df) # dimensions
nrow(df) # number of rows
ncol(df) # number of columns

# accessing parts of our data frame
df[ ,1] # print the first column
df[1, ] # print the first row
df[4,3] # print the element in the 4th row of the 3rd column

# using column names as a reference
df[,"name"] # access the column by name
df$name # an easier way to access the column by name
df$age <- c(4,6,2,3) # replace values in a column
df


#### SECTION 2 ####


# clearing your environment
rm(a) # remove an object by name
rm(age,b,e) # remove multiple objects by name
ls() # list all objects in your environment
rm(list = ls()) # remove all objects from your environment

# functions
y <- 1:10 # create a new variable
length(y) # use the length() function on it
?length # open the help for the length() function

sum(y) # use the sum() function
y[5] <- NA # add an NA to our vector
sum(y) # now the sum() function outputs NA
sum(y, na.rm = T) # add an argument telling sum() to ignore the NAs

# saving data out of R
animals  <- data.frame(name = c("Hedgehog", "Squirrel", "Pigeon", "Fox"),
                       height = c(4,7,3,5),
                       age = c(6,6,8,3)) # create a new data frame

# write data out of R
write.csv(animals, "animals.csv", row.names = F)

rm(animals) # remove animals from your environment

# reading the data back in
# first use the menu's
rm(animals) # remove animals from your environment

animals <- read.csv("animals.csv") # use the read.csv() function
rm(animals)  # remove animals from your environment
animals <- read.table("animals.csv", sep = ",", header = T) # use the read.table() function

# plotting
demo(graphics) # loop through the demo graphics

# scatter plot
x <- seq(1,100,5) # create a new vector
y <- x^2 # create a new vector
plot(x,y) # make a scatter plot of our new vectors
plot(x,y, type = "l") # make it a line graph
plot(x,y, las = 1) # change the orientation of the y axis values to make them readable
plot(x,y, las = 1, col = "red") # colour the points
plot(x,y, las = 1, col = "red", main = "My title") # add a title

# boxplots
# load practice data set
data("iris") # load the iris dataset

boxplot(iris$Petal.Width ~ iris$Species) # draw a boxplot

boxplot(iris$Petal.Width ~ iris$Species, las = 1,
        main = "My_title", ylab = "Petal Width",
        xlab = "Species") # add a title, axis labels and fix the orientation of the y axis numbers

# histogram
x <- rnorm(n = 1000, mean = 25.5, sd = 3) # create a normally distributed variable
hist(x) # draw a histogram

y <- rpois(n=1000, lambda = 2) # create a poisson distributed variable
hist(y) # draw a histogram


# packages
install.packages("ggplot2") # install package by name
library(ggplot2) # load the package into your environment
ggplot() # check you can access a function from the ggplot2 package

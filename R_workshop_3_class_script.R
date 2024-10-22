################
# R workshop 3 #
################

# clear working environment
rm(list = ls()) # clear global environment
dev.off() # clear plot history

# load packages
library(tidyverse)

# for loops
# simple example
for (x in 1:10){
  print(x)
}

# simple mathematical example
for (x in 1:10){
  print(x + 10)
}

# for loops across character strings
for (x in c("2019", "2020", "2021", "2022")){
  y <- paste("The year is ", x)
  print(y)
}

# if we look at y only the final iteration of the loop is stored
y

# assigning the output to an object
new_vector <- NA # first we must create a new empty object for the loop to write to

# now we can write to the object in the loop
for (x in 1:10){
  new_vector[x] <- x + 10
}

# look at the vector we have created
new_vector


# adding a new column to an existing data set
data("starwars") # load the starwars data

# create an empty column to write to
starwars$size <- NA

# add to the new column in a for loop
for (i in 1:nrow(starwars)){
  starwars$size[i] <- starwars$height[i] * starwars$mass[i]
}

# look at the new column we have created
starwars$size

# avoiding for loops with vectorisation instead
# with our simple examples we don't actually need the for loop
x <- 1:10
print(x)
print(x+10)
x+10

years <- c("2019", "2020", "2021", "2022")
paste("The year is ", years)



# CONDITIONAL STATEMENTS

# If
z <- 11
if (z < 10){
  print("z is less than 10")
}


# adding else
if (z < 10){
  print("z is less than 10")
} else {
  print("z is more than 10")
}

# doing the same thing with ifelse
ifelse(z < 10, "z is less than 10", "z is more than 10")

# working on vectors
z <- seq(1,60,6) # create a new vector
z # look at our vector

# apply our ifelse statement to our vector
ifelse(z < 10, "z is less than 10", "z is more than 10")

# ifelse also works with a character vector
countries <- c("UK", "USA", "France", "China")
ifelse(countries == "UK", "UK", "Elsewhere")

# add a new factor variable to a data frame with ifelse
data(iris) # load the iris data

levels(iris$Species) # look at the different species in the data 

# add a new column that just separates the setosa species from all others
iris$NewSpecies <- ifelse(iris$Species == "setosa", "setosa", "other")

# we can then use this new factor variable e.g. to colour points in a plot
ggplot(iris, aes(Sepal.Length, Sepal.Width, colour = NewSpecies)) +
  geom_point()

# nested ifelse statements
# if we want more than 2 levels we can nest ifelse statements
iris$Petal.Width.New <- ifelse(iris$Petal.Width < 0.3, "small",
                               ifelse(iris$Petal.Width >= 0.3 & iris$Petal.Width < 0.5, "medium", "large"))

# testing NA
iris[1,4] <- NA # introduce an NA to our data set

# the ifelse statement retains the NA 
iris$Petal.Width.New <- ifelse(iris$Petal.Width < 0.3, "small",
                               ifelse(iris$Petal.Width >= 0.3 & iris$Petal.Width < 0.5, "medium", "large"))


# ggplot using our new variable with 3 levels
ggplot(iris, aes(Petal.Length, Petal.Width, colour = Petal.Width.New)) +
  geom_point()


# WRITING OUR OWN FUNCTIONS

# lets make a function to add ten to the input 
add_ten <- function(x){
  y <- x + 10
  return(y)
}

add_ten(100) # try out our function

z <- 1:10 # create a new vector
add_ten(z) # try out our function on a vector


# making functions with multiple arguments
multiply <- function(x, y){
  z <- x * y
  return(z)
}

multiply(3,2) # try out our function

multiply(3) # we will get an error if we don't give it two arguments

# adding a default argument
multiply <- function(x, y = 10){
  z <- x * y
  return(z)
}

multiply(3) # now we don't get an error because we added a default for y

# we can override the default we set by specifying y as well when we call the function
multiply(3,2)


# combining conditional statements and functions
# e.g. we can use ifelse inside a function
# lets make a function to evaluate if a number is less than 10:
eval10 <- function(x){
  y <- ifelse(x < 10, "less than 10", "greater than 10")
  return(y)
}

eval10(1) # try it out
eval10(15) # try it out



# LISTS

# create three vectors for our list
nintendo <- c("Mario", "Luigi", "Peach")
numbers <- 1:100
logic <- c(T,F,F,T)

# combine our vectors into a list
my_list <- list(nintendo, numbers, logic)

my_list # look at our list

my_list[1] # access the first element of our list

class(my_list[1]) # but this is still a list

my_list[[1]] # to access the element as a vector use the double square brackets

class(my_list[[1]]) # now the first element is a character vector

# colons work differently inside double square brackets
my_list[1:2] # in single brackets the colon specifies a range
my_list[[1:2]] # in double brackets the colon takes the a numbered element from what is before the colon

my_list[[1]][1] # this would be the way to access the first element of the first item in a list
my_list[[1]][1:2] # we can specify a range within the single square brackets

# items within a list can be named e.g.
my_list <- list(nintendo = nintendo, numbers = numbers, logic = logic)
my_list # look at our new list

# now we can access elements in the list by their name or their index
my_list$nintendo
my_list[["nintendo"]]
my_list[[1]]

# items within a list can also be defined directly within the list function
# they don't need to exist outside of the list
# e.g.
my_list <- list(nintendo = c("Mario", "Luigi", "Peach"),
                numbers = 1:100,
                logic = c(T,F,F,T))
my_list # identical list to before



# APPLY FUNCTIONS

# apply() function - apply functions to data frames or matrices

data("airquality") # load some data to practice on

# if we wanted to get the means of all the columns in our data frame
# we could get them one by one by re-writing the code
mean(airquality[,1], na.rm = T)
mean(airquality[,2], na.rm = T)
mean(airquality[,3], na.rm = T)

# or we could use a for loop
for (x in 1:ncol(airquality)){
  print(mean(airquality[,x], na.rm = T))
}

# but we could do it more quickly and succinctly with apply:
# note the 2 is the column index, if we wanted row means we would use 1 instead
apply(airquality, 2, mean, na.rm = T)

# in this simple example there is also a built in function for this
colMeans(airquality, na.rm = T)


# we can also use our own functions with apply
# define a simple function of our own
square <- function(x){
  y <- x^2
  return(y)
}

square(10) # try out our function

# use our function on the airquality data set with apply
apply(airquality, 1, square)


# ANONYMOUS FUNCTIONS

# we can also define functions directly within apply
# e.g. to square all values
apply(airquality, 2, function(x){
  x^2
})

# or to count NAs in each column
apply(airquality, 2, function(x){
  is.na(x)
})

# we can wrap the is.na function in the sum function to get totals for each column
apply(airquality, 2, function(x){
  sum(is.na(x))
})


# lapply - apply functions to lists
my_list # lets look at our list again

# determine the length of each element in our list using lapply
lapply(my_list, length)

# note that lapply always outputs the result as a list
class(lapply(my_list, length))

# we can also use lapply on a data frame e.g.
lapply(airquality, mean)

# it will just coerce the dataframe into a list before it applies the function
# so it will do this under the hood
as.list(airquality)

# we can add addtionional arguments to our functions after the first2 inputs to lapply
# e.g. adding na.rm = T
lapply(airquality, mean, na.rm = T)


# sapply - apply functions to lists and by default simplify the output
# we get the same output as above with sapply
# but the output has been simplified to a vector rather than a list
sapply(airquality, mean, na.rm = T)

# if we want sapply not to simplify the output we can just tell it not to...
# and it will behave exactly like lapply
sapply(airquality, mean, na.rm = T, simplify = F)

# we can use anonymous functions with sapply exactly like with apply or lapply
# and if we give a vector as input, this will also just be coerced into a list
# e.g.
sapply(1:10, function(x){
  sqrt(x)
}, simplify = F)


# a real world example - using sapply to make chromosome names with a 
# user defined anonymous function
sapply(1:24, function(x){
  paste("chr", x , sep = "_")
})










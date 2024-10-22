

# clear working environment
rm(list = ls())
dev.off()

# load packages
library(tidyverse)

# for loops
for (x in 1:10){
  print(x)
}

for (x in 1:10){
  print(x + 10)
}

# for loops across character strings
for (x in c("2019", "2020", "2021", "2022")){
  y <- paste("The year is ", x)
  print(y)
}

y

# assigning the output to an object
new_vector <- NA

for (x in 1:10){
  new_vector[x] <- x + 10
}

new_vector


# adding a new col to existing dataset
data("starwars")

# create empty column
starwars$size <- NA

# add to the new column in a for loop
for (i in 1:nrow(starwars)){
  starwars$size[i] <- starwars$height[i] * starwars$mass[i]
}

starwars$size

# avoiding for loops with vectorisation instead
x <- 1:10
print(x)
print(x+10)
x+10

years <- c("2019", "2020", "2021", "2022")
paste("The year is ", years)

# conditional statements

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
z <- seq(1,60,6)
z
ifelse(z < 10, "z is less than 10", "z is more than 10")

# ifelse with a character vector
countries <- c("UK", "USA", "France", "China")
ifelse(countries == "UK", "UK", "Elsewhere")

# add a new factor variable to a data frame with ifelse
data(iris)

levels(iris$Species)

iris$NewSpecies <- ifelse(iris$Species == "setosa", "setosa", "other")

ggplot(iris, aes(Sepal.Length, Sepal.Width, colour = NewSpecies)) +
  geom_point()

# nested ifelse statements
iris$Petal.Width.New <- ifelse(iris$Petal.Width < 0.3, "small",
                               ifelse(iris$Petal.Width >= 0.3 & iris$Petal.Width < 0.5, "medium", "large"))

# testing NA
iris[1,4] <- NA

# ggplot of our new variable
ggplot(iris, aes(Petal.Length, Petal.Width, colour = Petal.Width.New)) +
  geom_point()


# FUNCTIONS
add_ten <- function(x){
  y <- x + 10
  return(y)
}

add_ten(100)

z <- 1:10
add_ten(z)


# functions with multiple arguments
multiply <- function(x, y){
  z <- x * y
  return(z)
}

multiply(3,2)

multiply(3)

# adding a default argument
multiply <- function(x, y = 10){
  z <- x * y
  return(z)
}

multiply(3)

multiply(3,2)


# combining conditional statements and functions
eval10 <- function(x){
  y <- ifelse(x < 10, "less than 10", "greater than 10")
  return(y)
}

eval10(1)
eval10(15)









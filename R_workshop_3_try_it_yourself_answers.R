# TRY IT YOURSELF ANSWERS

# Part 1

# 1. Write a for loop to iterate over numbers 1 to 100, multiply each one by 5 and print the output
for (i in 1:100){
  print(i*5)
}

# 2. Write an if statement to multiply a number by 100 only if it is less than 100
x = 99
x = 101
if (x < 100){
  print(x*100)
}

# 3. Write an ifelse() statement to output "X is big" if x is greater than or
# equal to 20 and "X is small" if x is less than 20
ifelse(x >= 20, "X is big", "X is small")

# 4. Write a function to divide one input by another and return the output
division <- function (x, y){
  z <- x / y
  return(z)
}
division(10,5)
division(50,5)

# 5. modify your function from 4 to have a default value for both inputs
division <- function (x=10, y=5){
  z <- x / y
  return(z)
}
division()
division(100)
division(,100)

# 6. Write a function to add 50 to an input variable only if the input is less than
# or equal to 10
funky <- function (x){
  y <- ifelse(x <= 10, x + 50, x)
  return(y)
}
funky(5)
funky(18)

# BONUS: Use nested ifelse statements to add a new factor variable to the airquality
# data set that says early if the day is 10 or under. middle if the day is 11-20 and
# late if the day is 21 or greater.
airquality$NewDay <- ifelse(airquality$Day <= 10, "early",
                            ifelse(airquality$Day > 10 & airquality$Day <= 20, "middle", "late"))
airquality



# Part 2

# 1. Create a new list with 5 named elements, make sure you include logical, 
# character and numeric elements and at least one data frame
new_list <- list(animals = c("squirrel", "hamster", "goldfish"),
                 logical = c(T,T,T,T,F,T,F,F,F),
                 rainfall = seq(1, 30, by = 2),
                 fish = c("Stickleback", "Tuna"),
                 data = airquality)
new_list

# 2. Using its number, access the second element in your list and return it as a list
new_list[2]

# 3. Using its number, access the second element in your list and return it as a
# vector or data frame (whichever it would be outside of the list)
new_list[[2]]

# 4. Using its name, access the 5th element in your list.
new_list$data
new_list["data"]
new_list[["data"]]

# 5. Using the apply() function, find the total sums of each column in the airquality
# dataset (note: you'll need to reload the dataset to remove the column we added earlier)
data(airquality)
apply(airquality, 2, sum, na.rm = T)

# 6. Using the lapply() function, print the classes of the items in the list 
# you made in question 1.
lapply(new_list, class)

# BONUS Using the sapply() function, paired with your own custom function output 
# the class of each item in the list you created in question 1
sapply(new_list, function(x){
  y <- class(x)
  return(y)
})




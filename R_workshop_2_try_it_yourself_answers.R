# TRY IT YOURSELF ANSWERS

# Part 1

# 1 Load the iris dataset into your environment.
# Use you preferred method to select the Sepal.Length and Sepal.Width columns
data("iris") # load the data

iris[ ,c("Sepal.Length", "Sepal.Width")] # with baseR

select(iris, Sepal.Length, Sepal.Width) # with dplyr OR

iris %>%
  select(Sepal.Length, Sepal.Width) # with dplyr and piping


# 2 Using dplyr and pipes, select only the columns that start with “P” from the iris data frame
iris %>%
  select(starts_with("P"))

# 3 Using dplyr but no pipes, filter the iris dataset to contain only the setosa species
filter(iris, Species == "setosa")

# 4 Using dplyr subset the iris dataset to contain only the Species and Sepal.Length columns
# for the species virginica.
iris %>%
  select(Species, Sepal.Length) %>%
  filter(Species == "virginica") # OR

select(filter(iris, Species == "virginica"), Species, Sepal.Length)

# 5 Summarise the number of records for each species in the iris data set
iris %>%
  group_by(Species) %>%
  count() # OR

iris %>%
  group_by(Species) %>%
  summarise(count = n())

# 6 BONUS: use the group_by() and summarise_at() functions to get the means of all
# of the numeric variables in the iris data set for each species.
iris %>%
  group_by(Species) %>%
  summarise_at(vars(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width), mean) # OR

summarise_at(group_by(iris, Species), vars(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width), mean)



# Part 2

# 1 Using the Iris dataset, make a scatter plot of Petal.Length and Petal.Width with ggplot()
ggplot(iris, aes(Petal.Length, Petal.Width)) +
  geom_point()

# 2 Colour the points in your previous plot by species
ggplot(iris, aes(Petal.Length, Petal.Width, colour = Species)) +
  geom_point()

# 3 Using ggplot(), make a histogram of Sepal.Width, play with the binwidth until
# you think it is appropriate
ggplot(iris, aes(Sepal.Width)) +
  geom_histogram(binwidth = 0.1)

# 4 Using ggplot(), Create a boxplot of Sepal.Length for each species, 
# colour the points by species and add your own axis labels
ggplot(iris, aes(Species, Sepal.Length, colour = Species)) +
  geom_boxplot() +
  xlab("Sepal Width") +
  ylab("Count")

# 5 Make your own theme for your boxplot above, get rid of the legend 
# and make the background white
ggplot(iris, aes(Species, Sepal.Length, colour = Species)) +
  geom_boxplot() +
  xlab("Sepal Width") +
  ylab("Count") +
  theme(legend.position = "none",
        panel.background = element_rect(fill = "white", colour = "black"))

# 6 Convert the starwars data to long format using pivot_longer(),
# select the height and mass columns to lengthen.
starwars_wide <- pivot_longer(starwars, cols = 2:3, names_to = "measure")

# 7 BONUS: load the “storms” dataset, pivot longer columns 10 & 11, 
# then make a boxplot of status against value and facet wrap using ‘measure’
data(storms)

storms2 <- pivot_longer(storms, cols = 10:11, names_to = "measure")

ggplot(storms2, aes(status, value)) +
  geom_boxplot() +
  facet_grid(~measure) +
  theme(axis.text.x = element_text(angle = 90))

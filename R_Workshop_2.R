######################
#### R Workshop 2 ####
######################

# clear our environment
rm(list = ls()) # remove all objects from your working environment
dev.off() # clear your plot window

# install and load packages
# install tidyverse using the packages tab
library(tidyverse) # load the package into your global environment

# load data
data(starwars) # load the data set
head(starwars) # look at the first few lines

# piping
length(starwars$name) # example function

# example piping into this fuction
starwars$name %>%
  length()


# dplyr
# select()

# select column with base R
starwars$name

select(starwars, name)

# piping into select function
starwars %>%
  select(name)

# select more than 1 column
# with baseR
starwars[ ,c("name", "homeworld")]

# with dplyr
select(starwars, name, homeworld)

# with dplyr a pipe
starwars %>%
  select(name, homeworld)

# select only columns with a certain character
starwars %>%
  select(-contains("_"))

# select only columns without a certain character
starwars %>%
  select(-starts_with("S"))

# select everything except the name column
starwars %>%
  select(-name)

# filter

# baseR
starwars[starwars$species == "Human", ]

# with dplyr
filter(starwars, species == "Human")

# with dplyr and piping
starwars %>%
  filter(species == "Human")

# baseR
# to fix the fact that we are also retaining NAs when we use base R we have to
# wrap our logical statement inside the which function
starwars[which(starwars$species == "Human"), ]

# filtering on multiple variables
filter(starwars, species == "Human" & homeworld == "Tatooine")

# with piping
starwars %>%
  filter(species == "Human" & homeworld == "Tatooine")


# select and filter together
select(filter(starwars, species == "Human"), name, height, birth_year)

# and with piping
starwars %>%
  filter(species == "Human") %>%
  select(name, height, birth_year)




# SUMMARISING DATA

# grouping our data
starwars %>%
  group_by(species)

# counting groups
starwars %>%
  group_by(species) %>%
  count()

# counting groups within groups
starwars %>%
  group_by(species, gender) %>%
  count()

# arrange output
starwars %>%
  group_by(species, gender) %>%
  count() %>%
  arrange(desc(n))




# list distinct species
starwars %>%
  distinct(species)

# arrange our species
# add the - before the desc() function to get ascending order
starwars %>%
  distinct(species) %>%
  arrange(-desc(species))

# count the distinct species
starwars %>%
  distinct(species) %>%
  count()


# summarise

# summarising a single column
# we create a new column called mean_height
# and call the mean function
starwars %>%
  summarise(mean_height = mean(height, na.rm = T))

# we can use any function inside summarise
# e.g. to count:
starwars %>%
  group_by(species) %>%
  summarise(count = n())

# or to summarise the mean for each species seperately
# we can group first before summarising
starwars %>%
  group_by(species) %>%
  summarise(mean_height = mean(height, na.rm = T))


# multiple summaries using different functions
starwars %>%
  group_by(species) %>%
  summarise(max_height = max(height, na.rm = T),
            min_height = min(height, na.rm = T))

# we can also use the same function to summarise multiple columns
# but note there is an easier way to do this below
starwars %>%
  group_by(species) %>%
  summarise(mean_height = mean(height, na.rm = T),
            mean_mass = mean(mass, na.rm = T))



# summarise at
starwars %>%
  group_by(species) %>%
  summarise_at(vars(height, mass), mean, na.rm = T)


# GGPLOT2

# build up layers of our plot
ggplot()

# give ggplot our data frame
ggplot(starwars)

# add our x and y aesthetics
ggplot(starwars, aes(x = height, y = mass))

# we don't need to tell it which is x and which is y because x is always first
# so this works exactly the same way:
ggplot(starwars, aes(height, mass))

# then we tell it we want to add a layer of points
ggplot(starwars, aes(height, mass)) +
  geom_point()

# Our plot has one quite serious outlier
# We can use dplyr to identify it
starwars %>%
  filter(mass > 1000) %>%
  select(name, species, mass)

# we can customise the points inside the geom_point brackets
ggplot(starwars, aes(height, mass)) +
  geom_point(size = 4, shape = 22, alpha = 0.5, fill = "purple", colour = "orange")


# histograms
ggplot(starwars, aes(mass)) +
  geom_histogram(binwidth = 20)

# boxplots
ggplot(starwars, aes(species, mass)) +
  geom_boxplot()

# This boxplot is too busy, lets filter out most abundant species
# we will first identify them using dplyr
starwars %>%
  group_by(species) %>%
  count() %>%
  arrange(desc(n))

# now we'll filter the data set for the most abundant species
new_starwars <- filter(starwars, species == "Human" | species == "Droid" | species == "Gungan")

# now plot our new dataset
ggplot(new_starwars, aes(species, mass)) +
  geom_boxplot()


# CUSTOMISATION
# start witha basic plot
ggplot(starwars, aes(height, mass)) +
  geom_point()

# we will filter out our outlier
starwars2 <- filter(starwars, mass <= 1000)

# then use the new data frame in ggplot
# play around with the different built in themes in R
ggplot(starwars2, aes(height, mass)) +
  geom_point() +
  theme_void()


# create our own cusom theme
ggplot(starwars2, aes(height, mass, colour = height)) +
  annotate("rect", xmin = 80, xmax = 120, ymin = -Inf, ymax = Inf, fill = "pink", alpha = 0.5) +
  geom_point() +
  theme(axis.text = element_text(size = 16, colour = "red"),
        axis.title.x = element_text(size = 20, colour = "purple"),
        axis.title.y = element_text(size = 10, colour = "darkgreen", angle = 360, family = "serif", face = "italic"),
        panel.background = element_rect(fill = "white", colour = "black"),
        axis.ticks = element_line(linewidth = 3)) +
  scale_colour_continuous(type = "viridis") +
  xlab("Height (cm)") +
  ylab("Mass (g)")


# reshaping data
head(iris)

# make a plot with the wide data frame
ggplot(iris, aes(Species, Sepal.Length)) +
  geom_boxplot()

# pivot longer
# first we need to add an ID column as this data set does not already have one
iris$ID <- row.names(iris)

# convert data from wide to long format
iris2 <- pivot_longer(iris, col = 1:4, names_to = "measure")
# look at the new dataset we created
head(iris2)

# plot the long iris dataset
ggplot(iris2, aes(Species, value)) +
  geom_boxplot()

# use facet wrap to split up the plots
ggplot(iris2, aes(Species, value)) +
  geom_boxplot() +
  facet_wrap(~measure)

# again we can play around with the theme
# we can also assign our plot to an object
plot1 <- ggplot(iris2, aes(Species, value)) +
  geom_boxplot() +
  facet_wrap(~measure) +
  theme_dark()
# then look at it using the object name
plot1


# pivot_wider
# return the data frame to its previous wide state
pivot_wider(iris2, values_from = "value", names_from = "measure")

# saving plot as a jpeg
jpeg("our_R_plot.jpg", units = "cm", width = 10, height = 10, res = 300)
plot1
dev.off()

# saving our plot as a pdf
pdf("our_plot.pdf", width = 5, height = 5)
plot1
dev.off()





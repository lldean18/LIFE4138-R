
# clear our environment
rm(list = ls())
dev.off()

# install and load packages
library(tidyverse)

# load data
data(starwars)
head(starwars)

# piping
length(starwars$name)

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
# baseR
starwars[ ,c("name", "homeworld")]

# with dplyr
select(starwars, name, homeworld)

# with a pipe
starwars %>%
  select(name, homeworld)

# select only cols with a certain character
starwars %>%
  select(-contains("_"))

starwars %>%
  select(-starts_with("S"))

starwars %>%
  select(-name)

# filter

# baseR
starwars[starwars$species == "Human", ]

# with dplyr
filter(starwars, species == "Human")

# with piping
starwars %>%
  filter(species == "Human")

# baseR
starwars[which(starwars$species == "Human"), ]

# filtering by multiple variables
filter(starwars, species == "Human" & homeworld == "Tatooine")

# piping
starwars %>%
  filter(species == "Human" & homeworld == "Tatooine")


# select and filter
select(filter(starwars, species == "Human"), name, height, birth_year)

# pipe
starwars %>%
  filter(species == "Human") %>%
  select(name, height, birth_year)




# SUMMARISING DATA

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
starwars %>%
  distinct(species) %>%
  arrange(-desc(species))

# count the distinct species
starwars %>%
  distinct(species) %>%
  count()


# summarise

# summarising a single column
starwars %>%
  summarise(mean_height = mean(height, na.rm = T))

starwars %>%
  group_by(species) %>%
  summarise(count = n())


starwars %>%
  group_by(species) %>%
  summarise(mean_height = mean(height, na.rm = T))


# multiple summaries
starwars %>%
  group_by(species) %>%
  summarise(max_height = max(height, na.rm = T),
            min_height = min(height, na.rm = T))


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


ggplot(starwars)

ggplot(starwars, aes(x = height, y = mass))

ggplot(starwars, aes(height, mass))

ggplot(starwars, aes(height, mass)) +
  geom_point()

# use dplyr to find our outlier
starwars %>%
  filter(mass > 1000) %>%
  select(name, species, mass)


ggplot(starwars, aes(height, mass)) +
  geom_point(size = 4, shape = 22, alpha = 0.5, fill = "purple", colour = "orange")


# histograms
ggplot(starwars, aes(mass)) +
  geom_histogram(binwidth = 20)

# boxplots
ggplot(starwars, aes(species, mass)) +
  geom_boxplot()

# filter out most abundant species
starwars %>%
  group_by(species) %>%
  count() %>%
  arrange(desc(n))

new_starwars <- filter(starwars, species == "Human" | species == "Droid" | species == "Gungan")

ggplot(new_starwars, aes(species, mass)) +
  geom_boxplot()


# CUSTOMISATION
ggplot(starwars, aes(height, mass)) +
  geom_point()

starwars2 <- filter(starwars, mass <= 1000)

ggplot(starwars2, aes(height, mass)) +
  geom_point() +
  theme_void()


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

ggplot(iris, aes(Species, Sepal.Length)) +
  geom_boxplot()

# pivot longer
iris$ID <- row.names(iris)

iris2 <- pivot_longer(iris, col = 1:4, names_to = "measure")
head(iris2)

ggplot(iris2, aes(Species, value)) +
  geom_boxplot()

ggplot(iris2, aes(Species, value)) +
  geom_boxplot() +
  facet_wrap(~measure)


plot1 <- ggplot(iris2, aes(Species, value)) +
  geom_boxplot() +
  facet_wrap(~measure) +
  theme_dark()

plot1


# pivot_wider
pivot_wider(iris2, values_from = "value", names_from = "measure")

# saving plot
jpeg("our_R_plot.jpg", units = "cm", width = 10, height = 10, res = 300)
plot1
dev.off()

# pdf
pdf("our_plot.pdf", width = 5, height = 5)
plot1
dev.off()





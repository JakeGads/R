setwd('~/source/repo/R/Group Projects/Group Project 4')
# install.packages("tidyverse")
# install.packages(c("viridis"))
library(tidyverse)

water <- read_csv('Data/basic_water_access.csv') %>%
pivot_longer(
    "2000":"2017", 
    names_to="year", 
    values_to="per_water_usage"
)
colnames(water)

energy <- read_csv('Data/energy_production.csv') %>%
pivot_longer(
    "1960":"2010", 
    names_to="year", 
    values_to="energy"
)
colnames(energy)

income <- read_csv("Data/income.csv") %>%
pivot_longer(
    "1800":"2040", 
    names_to="year", 
    values_to="avg_income"
)
colnames(income)

life <- read_csv("Data/life_expectancy.csv") %>%
pivot_longer(
    "1800":"2100", 
    names_to="year", 
    values_to="life_expectancy"
)
colnames(life)

literacy <- read_csv("Data/literacy_rate.csv") %>%
pivot_longer(
    "1975":"2011", 
    names_to="year", 
    values_to="lit_rate"
)
colnames(literacy)

pop <- read_csv("Data/under_5_population.csv") %>%
pivot_longer(
    "1950":"2100", 
    names_to="year", 
    values_to="population"
)
colnames(pop)

# we must always <some_kind>_join the smaller dataset with the larger one

#region Jake
#region 1

library(viridis)
library(scales)

theme_set(theme_minimal())

options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")


j1 <- life %>%
inner_join(literacy) %>%
inner_join(pop) %>%
na.omit(lit_rate) %>%
na.omit(population)

j1 %>%
ggplot(mapping=aes(life_expectancy, lit_rate, color=population)) +
geom_point() +
geom_smooth(se=FALSE)

j1 %>%
ggplot(mapping=aes(life_expectancy, lit_rate, color=population)) +
geom_point() +
geom_smooth(se=FALSE) + 
facet_wrap(~year)

j1 %>%
filter(population < 10**7) %>%
ggplot(mapping=aes(life_expectancy, lit_rate, color=population)) +
geom_point() +
geom_smooth(se=FALSE) + 
facet_wrap(~year)

j1 %>%
filter(population < 10**7) %>%
ggplot(mapping=aes(life_expectancy, lit_rate, color=population)) +
geom_point() +
geom_smooth(se=FALSE) + 
facet_wrap(~year) +
labs(
    title = "Life Expectancy vs Literarcy Rate",
    subtitle = "colored by population\nwrapped by year",
    x="Life Expectancy",
    y="Literacy Rate",
    color="Population"
) +
theme(
    legend.position = "left"
)
#endregion

#region 2

j2 <- income %>%
inner_join(energy) %>%
inner_join(water) %>%
na.omit(energy) %>%
na.omit(per_water_usage) %>%
na.omit(avg_income)

j2 %>%
ggplot(aes(energy, per_water_usage, color=avg_income)) +
geom_point()


j2 <-j2 %>%
group_by(country) %>%
#                                                                       Reminder add that extra _
summarize(avg_energy = mean(energy), avg_water = mean(per_water_usage), avg_income_  = mean(avg_income))

j2 %>%
ggplot(aes(avg_energy, avg_water, color=avg_income_)) +
geom_point()

j2 %>%
filter(avg_energy < 1000000) %>%
ggplot(aes(avg_energy, avg_water, color=avg_income_)) +
geom_point() +
facet_wrap(~country)
# now I want to clear out some 

#endregion
#endregion
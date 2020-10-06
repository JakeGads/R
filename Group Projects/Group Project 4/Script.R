setwd('~/source/repo/R/Group Projects/Group Project 4')
install.packages("tidyverse")
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
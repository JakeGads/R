setwd('~/source/repo/R/Group Projects/Group Project 4')
library(tidyverse)
water <- read_csv('Data/basic_water_access.csv')
colnames(water)

energy <- read_csv('Data/energy_production.csv')
colnames(energy)

income <- read_csv("Data/income.csv")
colnames(income)

life <- read_csv("Data/life_expectancy.csv")
colnames(life)

literacy <- read_csv("Data/literacy_rate.csv")
colnames(literacy)

pop <- read_csv("Data/under_5_population.csv")
colnames(literacy)
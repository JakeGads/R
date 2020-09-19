# install.packages("tidyverse")
library(tidyverse)

# Making it color blind friendly
#region 

# uncomment as needed
# install.packages("viridis")
# install.packages("scales")

library(viridis)
library(scales)

theme_set(theme_minimal())

options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")
#endregion

setwd('~/source/repo/R/Group Projects/Group Project 3') # For Jake

getwd() # for error checking
# no skips but col names need to be overridden
airlines <- read_csv("airlines.csv")

drivers <- read_csv(
    "drivers.csv",
    col_names =  c(
        "state", 
        "num_drivers_in_fatal_per_billion", 
        "per_speeding",
        "per_alcohol",
        "per_not_distracted",
        "per_not_invlolved_previous",
        "car_insurances_cost",
        "insurance_company_losses_per_driver",
    ),
    skip=1
)

states <- read_csv(
    "states.csv",
    col_names = c(
        "state",
        "pop_18",
        "travel_time",
        "income",
        "area",
        "pop_per_square_mile",
        "error_catch"
    ),
    skip=1
 ) %>%
 select(-error_catch)

states <- states %>%
select(-error_catch)


colnames(airlines)
colnames(drivers)
 
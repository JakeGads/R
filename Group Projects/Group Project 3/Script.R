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

#region Data Parsing

# Loading in data
# Load the data into R from the given csv file. In this step, you must make sure every column of data is appropriately labeled and has the correct data type associated. This must be done every column, even if you do not plan on using a specific column for your subsequent analysis.
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
        "insurance_company_losses_per_driver"
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


megastate <- merge(drivers, states, by="state")
colnames(airlines)
colnames(drivers)
colnames(states) 
colnames(megastate)

#endregion

#region Airlines 1 (Moses)

# total_fatalites X total_incidents

#endregion

#region Airlines 2 (Cam)

# something that changes per year

#endregion

#region Drivers 1 (Jake)

# "num_drivers_in_fatal_per_billion" x "insurance_company_losses_per_driver"

ggplot(data = drivers, aes(num_drivers_in_fatal_per_billion, insurance_company_losses_per_driver)) +
geom_point()

#endregion


#region Drivers 2 (Moses)

# Districted x per_not_distracted

#endregion

#region States 1 (Cam)

# pop_per_square_mile x income

#endregion

#region States 2 (Jake)

# Travel_time vs income

#endregion
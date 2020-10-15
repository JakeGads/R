library(tidyverse)

clean_data <- function(csv_file) {
    # country, a bunch of years
    data <- read_csv(paste(csv_file, '.csv', sep = ""))
    r <- colnames(data)
    data %>%
    pivot_longer(
        r[-1], 
        names_to="year", 
        values_to=csv_file
    )
}

setwd("~/source/repo/R/Group Projects/Group Project 4/Data")

set <- "basic_water_access"
clean_data("basic_water_access")
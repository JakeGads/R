library(tidyverse)

clean_data <- function(csv_file) {
    # country, a bunch of years
    data <- 0
    if (grepl('.csv', csv_file)){ # checks to see if .csv is in the csv call already
        data <- read_csv(csv_file)     
    }
    else{ # if not it concats it on
        data <- read_csv(paste(csv_file, '.csv', sep = ""))
    }
    r <- colnames(data)
    data %>%
    pivot_longer(
        r[-1], 
        names_to="year", 
        values_to=csv_file
    )
}

set <- "basic_water_access"
clean_data(set)
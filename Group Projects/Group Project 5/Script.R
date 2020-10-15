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
    
    data <- data %>%
    pivot_longer(
        r[-1], 
        names_to="year", 
        values_to=csv_file
    )
}

jake_join <- function(x,y,z=FALSE){
    gen_data <- clean_data(x) %>%
    inner_join(clean_data(y)) %>%
    na.omit(x) %>%
    na.omit(y)

    if(z != FALSE){
        gen_data <- gen_data %>%
        inner_join(clean_data(z)) %>%
        na.omit(z)
    }
    
    gen_data
}

generate_scatterplot <- function(x,y, color='None'){

}

jake_join("basic_water_access", "energy_production.csv", "income")
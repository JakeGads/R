install.packages('tidyverse')
library(tidyverse)


# x verctor of 4 strings
# n subdivisions of dataset3
# m subdivisions of dataset4
explore <- function(x, n, m){
    data <- average_data(merge_data(x[1], x[2], x[3], x[4]), x) %>%
    ungroup %>%
    mutate(
        subdivision3 = ntile(data[[x[3]]], n), 
        subdivision4 = ntile(data[[x[4]]], m)
    )

    ggplot(data) +
    geom_point(mapping = aes_string(x[1], x[2], color=factor("subdivision3"),shape=factor("") )) +
    facet_grid(subdivision3 ~ subdivision4)
}

clean_string <- function(file){
    if(grepl(".csv", file)){
        file <- str_split(file,".csv", 2)
        file <- file[[1]][1]
    }
    if(grepl(" ", file){
        file <- str_replace_all(file, " ", "_")
    })

    file <- str_to_lower(file)

    return(file)
}

# load datasets
load_data <- function(csv_file) {
    # country, a bunch of years
    csv_file <- clean_string(csv_file)
    gen_data <- 0
    gen_data <- read_csv(paste(csv_file, '.csv', sep = ""))
    
    return(gen_data)
}

# tidy 
tidy_data <- function(data) {
    r <- colnames(data)
    
    gen_data <- data %>%
    pivot_longer(
        r[-1], 
        names_to="year", 
        values_to=csv_file
    )
}

# merge data
merge_data <- function(x,y,z,foo){
    gen_data <- tidy_data(load_data(x)) %>%
    inner_join(tidy_data(load_data(y))) %>%
    inner_join(tidy_data(load_data(z))) %>%
    inner_join(tidy_data(load_data(foo))) %>%
    na.omit(x) %>%
    na.omit(y) %>%
    na.omit(z) %>%
    na.omit(foo)

    return(gen_data)
    
}
# compute the averages
average_data <- function(data, cols){
    stat <- data %>%
    group_by(country) %>%
    summarise_at(
        vars(clean_string(cols[1]),clean_string(cols[2]),clean_string(cols[3]), clean_string(cols[4])),
        funs(mean)
    )
}



sets <- list.files(pattern="*.csv")

library(tidyverse)

clean_data <- function(csv_file) {
    # country, a bunch of years
    
    gen_data <- 0
    gen_data <- read_csv(paste(csv_file, '.csv', sep = ""))
    
    r <- colnames(gen_data)
    
    gen_data <- gen_data %>%
    pivot_longer(
        r[-1], 
        names_to="year", 
        values_to=csv_file
    )

    return(gen_data)
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
    
    return(gen_data)
}

remove_csv <- function(file){
    if(grepl(".csv", file)){
        file <- str_split(file,".csv", 2)
        file <- file[[1]][1]
    }
    return(file)
}

generate_scatterplot <- function(x,y, c='None'){
    x <- remove_csv(x)
    y <- remove_csv(y)
    c <- remove_csv(c)

    joined <- jake_join(x,y,c)

    graph <- 0
    if(c != 'None'){
        graph <- joined %>%
        ggplot(aes_string(x, y, color=c)) + # aes string allows for the column name to as a string and not a datapoint
        geom_point() +
        labs(
            title=paste(x, 'vs', y, sep = " "),
            subtitle=paste("colored by", c),
            x=x,
            y=y,
            color=c
        )
    }
    else{
        graph <- jake_join(x,y) %>%
        ggplot(mapping=aes(x,y)) + 
        geom_point() +
        labs(
            title=paste(x, 'vs', y, sep = " "),
            x=x,
            y=y
        )
    }
    
    return(graph)
}

generate_scatterplot("basic_water_access", "energy_production.csv", "income")

joined <- jake_join("basic_water_access", "energy_production", "income")

x <- "basic_water_access"
joined[x]
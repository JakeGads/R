library(tidyverse)

# takes the data and makes it a formated data
clean_data <- function(csv_file) {
    # country, a bunch of years
    
    gen_data <- read_csv(paste(csv_file, '.csv', sep = "")) # add .csv so the file is findable (this is called after the remove_csv function)
    
    r <- colnames(gen_data)
    
    gen_data <- gen_data %>%
    pivot_longer(
        r[-1], 
        names_to="year", 
        values_to=csv_file
    )

    return(gen_data)
}


# joins the data when accepted as a string
jake_join <- function(...){ # this means it can take an unlimited amount of
    my_list <- list(...)
    
    gen_data <- clean_data(my_list[1]) %>%
    na.omit(my_list[1])

    for (i in 2:length(my_list)){
        gen_data <- gen_data %>%
        inner_join(my_list(i)) %>%
        na.omit(my_list[i])
    }
    
    return(gen_data)
}

# removes csv from the string
remove_csv <- function(file){
    if(grepl(".csv", file)){
        file <- str_split(file,".csv", 2)
        file <- file[[1]][1]
    }
    return(file)
}

# makes a scatterplot, either colored or uncolored
generate_scatterplot <- function(...){
    my_list <- list(...)
    
    for (i in my_list){
        my_list[i] <- remove_csv(my_list[i])
    }

    joined <- jake_join(my_list)

    plot_call <- 0

    if(){
        plot_call <- ggplot(aes_string(my_list[1], my_list[2], my_list[1])) + # aes string allows for the column name to as a string and not a datapoint
        
    }
    else{
        plot_call <- ggplot(mapping=aes_string(x,y)) + 
    }
    
    graph <- ggplot(joined) +
    plot_call +
    geom_point() +
    labs(
        title=paste(x, 'vs', y, sep = " "),
        x=my_list[1],
        y=my_list[2],
        color=my_list[3]
    )

    return(graph)
}

generate_scatterplot("basic_water_access", "energy_production.csv", "income")

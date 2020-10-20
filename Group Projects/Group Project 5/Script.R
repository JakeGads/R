library(tidyverse)

# takes the data and makes it a formated data
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


# joins the data when accepted as a string
jake_join <- function(x,y,z=FALSE){
    gen_data <- clean_data(x) %>%
    inner_join(clean_data(y)) %>%
    na.omit(x) %>%
    na.omit(y)

    if(z != FALSE){
        gen_data <- gen_data %>%
        inner_join(clean_data(z)) %>%
        na.omit(z)
        
        gen_data <- gen_rank(gen_data, x,y,z)
    }
    else {
       gen_data <- gen_rank(gen_data, x,y)
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

# mutates a data set to add a rank based on distance from the sd of each column
gen_rank = function(data_frame, x, y, z=FALSE){
    if(z != FALSE){
        data_frame %>%
        mutate(
            score = (data_frame[[x]] - mean(data_frame[[x]])) / sd(data_frame[[x]]) + 
                    (data_frame[[y]] - mean(data_frame[[y]])) / sd(data_frame[[y]]) + 
                    (data_frame[[z]] - mean(data_frame[[z]])) / sd(data_frame[[z]])
        )
    }
    else{
        data_frame %>%
        mutate(score =  (mean(data_frame[[x]]) - data_frame[[x]]) / sd(data_frame[[x]]) + 
                        (mean(data_frame[[y]]) - data_frame[[y]]) / sd(data_frame[[y]])
        )
    }
}

# makes a scatterplot, either colored or uncolored
generate_scatterplot <- function(x,y, c='None'){
    x <- remove_csv(x)
    y <- remove_csv(y)
    c <- remove_csv(c)

    graph <- 0
    if(c != 'None'){
        df = gen_rank(jake_join(x,y,c), x, y, c)
        graph <- df %>%
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
        df = gen_rank(jake_join(x,y), x, y)
        graph <- df %>%
        ggplot(mapping=aes_string(x,y)) + 
        geom_point() +
        labs(
            title=paste(x, 'vs', y, sep = " "),
            x=x,
            y=y
        )
    }
    
    return(graph)
}

ccj_main <- function(collection){
    if(is.na(collection[3])){
        generate_scatterplot(collection[1], collection[2])
    }
    else{
        generate_scatterplot(collection[1], collection[2], collection[3])
    }
}

ccj_main(c("basic_water_access", "energy_production.csv", "income"))
ccj_main(c("basic_water_access", "energy_production.csv"))

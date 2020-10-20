library(tidyverse)
# install.packages('gtools')
library(gtools)

perm <- function(x){
    n <- length(x)

    #set r
    r <- 3
    p <- permutations(n, r, v = x)
    pdf(file=paste(1, '-', 50, '.pdf', sep = ""))
    for(i in 1:nrow(p)){
        ccj_main(c(p[i,1], p[i,2], p[i,3]))
        dev.off()
    }
}

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
    
    df <- 0
    
    if(z != FALSE){
        df <- data_frame %>%
        group_by(country) %>%
        summarize_at(
            vars(x,y,z),
            funs(mean)
        )

        df <- df %>%
        mutate(score = df[[z]])
    }
    else{
        df <- data_frame %>%
        group_by(country) %>%
        summarize_at(
            vars(x,y),
            funs(mean)
        )

        df <- df %>%
        mutate(score = df[[y]])
    }
}

# makes a scatterplot, either colored or uncolored
generate_scatterplot <- function(x,y, c='None', high=TRUE){
    x <- remove_csv(x)
    y <- remove_csv(y)
    c <- remove_csv(c)
    df <- 0
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
    
    graph + gen_label(df, high)
}

gen_label <- function(data_frame, bool) {
    
    g <- 0
    if (bool){
        g <- data_frame %>%
        arrange(desc(score))
    }
    
    else{
        g <- data_frame %>%
        arrange(score)
    }
    
    #select the first value of score
    return (geom_label(data = head(g, 1), mapping = aes(label = paste(country, score))))
}

ccj_main <- function(collection, high=TRUE){
    if(is.na(collection[3])){
        generate_scatterplot(collection[1], collection[2], high=high)
    }
    else{
        generate_scatterplot(collection[1], collection[2], collection[3], high = high)
    }
}

perm(c(
    "basic_water_access", 
    "energy_production.csv", 
    "income",
    "under_5_population",
    "life_expectancy",
    "literacy_rate"
))

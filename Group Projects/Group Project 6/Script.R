library(tidyverse)

# generates a tibble that has been joined
# filepath will set the dir, if required
# locs will only include those indexed datasets (alphabetically)
get_tibble <- function(file_path="", locs=0){
    # joins however many files are pased into the it
    mass_join <- function(files){

        # cleans the individual tables for joining
        clean_data <- function(csv_file, val=1) {
            gen_data <- read_csv(csv_file) # read in the csv file        
            cols <- colnames(gen_data) # parses
            
            gen_data <- gen_data %>%
            pivot_longer(
                cols[-1], 
                names_to="year", 
                values_to=paste("value", val, sep="")
            ) # pivits

            

            return(gen_data)
        }

        values = c()
        # get the starting point
        df <- clean_data(files[1], 1)

        # loops through and continues to add to the tibble
        for(i in 2:length(files)){
            values[i] <- paste("value", i, sep='')
            
            df <- df %>%
            inner_join(clean_data(files[i], i)) %>%
            na.omit(
                values[i]
            )
        }
        return(df)

    }

    # sets the file_path but only if requred
    if(file_path != ""){
        setwd(file_path)
    }
    # grab all files
    files <- list.files(full.names = T, recursive = T, pattern = ".*.csv")
    
    # runs a mass join on all datasets
    if(locs==0){
        return(
            mass_join(files)
        )
    }
    # runs the mass join on only the requested sets
    else{
        return(
            mass_join(files[locs])
        )
    }
}

# gets the variables from the col locations listed in locs
get_var_names <- function(file_path="", locs=0){
    # returns a singluar column while editing it so it looks fancy
    pretty_print <- function(file){
        # if the files have been gained through recursion it cuts off all of the routing information and leaves just the final aspect
        remove_dir <- function(file){
            # checks if their are /s
            if(grepl("/", file)){ 
                # splits completely
                file <- str_split(file,"/") 
                # only pulls the last of the of the spllit which would be just the file
                file <- file[[1]][length(file[[1]])]
            }
            
            return(file) # explict return if it doesn't make changes
        }
        # removes .csv from the end of the file
        remove_csv <- function(file){
            # checks to see if csv in is the file name
            if(grepl(".csv", file)){ 
                # if it is it splits in 2
                file <- str_split(file,".csv", 2)
                # pulls the first element (file name) 
                file <- file[[1]][1]
            }
            return(file)
        }
        
        # adds spaces instead of underscores
        add_spaces <- function(file){
            # keeps running while there is an _
            while(grepl("_", file)){
                # replaces
                file <- str_replace(file, "_", " ")
            }
            return(file)
        }

        # adds capitilization to the strings
        add_capitilzation <- function(file){
            # first run through is true so it capitlizes
            found_space <- TRUE
            # string saver
            new_str <- ""
            # splits the word per letter
            for(i in strsplit(file, "")[[1]]){
                # capitilzes after ever space
                if(found_space){
                    # appends the capital to the space
                    new_str <- paste(new_str, str_to_upper(i), sep="")
                    # stands down
                    found_space = FALSE
                    # `continue` doesn't run the remainder of this loop
                    next
                }
                
                # if its found a space force uppercase on next letter
                if(i == " "){
                    found_space = TRUE
                }

                # at end paste the string
                new_str <- paste(new_str, i, sep="")
            }

            # force the return
            return(new_str)

        }

        # this order is very important like don't change this
        return(
            add_capitilzation(
                remove_dir(
                    remove_csv(
                        add_spaces(
                            file
                        )
                    )
                )
            )
        )
    }

    if(file_path != ""){
        setwd(file_path)
    }

    # pulls all the files, in the current dir, note this comes after the get_tibble so its already set
    files <- list.files(recursive = T, pattern = ".*.csv")
    names <- c() # starts up the c so we can append to it later on

    # if no locations have been specified
    if(locs == 0){
        # do for all files
        for(i in 1:length(files)){
            names[i] <- pretty_print(files[i]) 
        }
    }
    else{
        for(i in 1:length(locs)){
            names[i] <- pretty_print(files[locs[i]])
        }
    }
    return(names)
}

get_group_mean_vals <- function(df) {
    return(
        df %>% 
        group_by(country) %>%
        summarize_all(
            funs(mean)
        ) %>%
        select(-year)
    )
    
}

get_group_score <- function(df){
    # colnames(df)[2:length(colnames(df))]

    df <- df %>%
    group_by(country) %>%
    summarize_all(
        funs(mean)
    ) %>%
    select(-year) %>%
    mutate(score = 0)

    for (i in colnames(df)[2:length(colnames(df))]){
        df <- df %>%
        mutate(score = score + ((df[[i]] - mean(df[[i]])) / sd(df[[i]])))
    }

    return(df)
}

get_individual_mean_vals <- function(df) {
    return(
        df %>% 
        summarize_all(
            funs(mean)
        )
    )
    
}

get_individual_score <- function(df){
    # colnames(df)[3:length(colnames(df))]

    df <- df %>%
    mutate(score = 0)

    for (i in colnames(df)[3:length(colnames(df))]){
        df <- df %>%
        mutate(score = score + ((df[[i]] - mean(df[[i]])) / sd(df[[i]])))
    }

    return(df)
}


# TODO everything after this need to be worked on

generate_bar <- function(df, cols){
    get_labs <- function(cols) {
        return labs(
            labs(
                title = paste(cols[1], "vs", cols[2])
            )
        )
    }

    return(
        ggplot(df) +
        geom_bar(

        ) + 
        get_labs(cols)
    )
}

generate_scatter <- function(df, cols){
    get_labs <- function(cols) {
        return labs(
            labs(
                title = paste(cols[1], "vs", cols[2])
            )
        )
    }

    return(
        ggplot(df) + 
        geom_point(

        ) + 
        get_labs(cols)
    )

}

generate_densitity <- function(df, cols){
    get_labs <- function(cols) {
        return labs(
            labs(
                title = paste(cols[1], "vs", cols[2])
            )
        )
    }

    return(
        ggplot(df) +
        geom_density(

        ) + 
        get_labs(cols)
    )

}

generate_line <- function(df, cols){
    get_labs <- function(cols) {
        return labs(
            labs(
                title = paste(cols[1], "vs", cols[2])
            )
        )
    }

    return(
        ggplot(df) +
        geom_line(

        ) + 
        get_labs(cols)
    )

}

generate_facet <- function(df, cols) {
    if(length(df) < 3){
        return(geom_blank())
    }
    else if (length(df) == 3) { #single facet
       return(
           facet_wrap(~value3) +
           labs(
               subtitle = paste("faceted by", cols[3])
           )
       )
    }
    else{ # double facet
        return(
            facet_grid(value3~value4) +
            labs(
                subtitle = paste("faceted by", cols[3], "and", cols[4])
            )
        )
    }
}


#' will generate a graph of your choosing
#' @param graph_type (int) 1 for bar, 2 for scatter, 3 for density, 4 for line
#' @param summarize_type (int) 1 group mean; 2 individual mean; 3 sum(group zscores); 4 sum(indivual group zscores)
#' @param file_path (string) the location of the csv's, it will be running a setwd on this statment and must be finable from the current path
#' @param locs (c(<int>)) in alphabetical order the location of all the csvs that you wish to grab
#' @return the generated graph
#' @export
ccj_wrapper = function(graph_type, summarize_type=1, file_path="", locs=0){
    df <- get_tibble(file_path=file_path, locs=locs)
    var_names <- get_var_names(file_path=file_path, locs=locs)

    
    df <- switch(summarize_type, get_group_mean_vals(df), get_individual_mean_vals(df), get_group_score(df), get_individual_score(df))

    
}    

df <- get_tibble(file_path="~/source/repo/R/Group Projects/Group Project 6", locs=c(3,1,5))
cols <- get_var_names(file_path="~/source/repo/R/Group Projects/Group Project 6")

ccj_wrapper(1)
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

        # get the starting point
        df <- clean_data(files[1], 1)

        # loops through and continues to add to the tibble
        for(i in 2:length(files)){
            df <- df %>%
            inner_join(clean_data(files[i], i)) %>%
            na.omit(
                paste("value", i, sep='')
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

get_var_names <- function(locs=0){

    pretty_print <- function(file){
        remove_dir <- function(file){
            if(grepl("/", file)){
                file <- str_split(file,"/", 2)
                file <- file[[1]][2]
            }
            
            return(file)
        }
        
        remove_csv <- function(file){
            if(grepl(".csv", file)){
                file <- str_split(file,".csv", 2)
                file <- file[[1]][1]
            }
            return(file)
        }

        add_spaces <- function(file){
            while(grepl("_", file)){
                file <- str_replace(file, "_", " ")
            }
            return(file)
        }

        add_capitilzation <- function(file){
            found_space <- TRUE
            new_str <- ""
            for(i in strsplit(file, "")[[1]]){
                if(found_space){
                    new_str <- paste(new_str, str_to_upper(i), sep="")
                    found_space = FALSE
                    next
                }
                
                if(i == " "){
                    found_space = TRUE
                }

                new_str <- paste(new_str, i, sep="")
            }

            return(new_str)

        }

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

    files <- list.files(recursive = T, pattern = ".*.csv")
    names <- 0

    if(locs == 0){
        names <- c()
        for(i in 1:length(files)){
            temp <- pretty_print(files[i])
            names[i] <- temp
        }
    }
    else{
        names <- c()
        for(i in 1:length(locs)){
            temp <- pretty_print(files[locs[i]])
            names[i] <- temp
        }
    }
    return(names)
}

get_tibble(file_path="~/source/repo/R/Group Projects/Group Project 6", locs=c(3,1,5))
get_var_names(locs=c(3,1,5))
# generate additional files for making graphs pretty


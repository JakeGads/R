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

get_tibble(file_path="~/source/repo/R/Group Projects/Group Project 6", locs=c(1,3,5))
# generate additional files for making graphs pretty
files <- list.files(full.names = T, recursive = T, pattern = ".*.csv")

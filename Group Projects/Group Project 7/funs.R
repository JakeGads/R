get_tibble <- function(one,two) {
    clean_data <- function(df, val=1) {
        df <- df %>%
        pivot_longer(
            colnames(df)[-1],
            values_to="year",
            values_to=paste("value", val, sep="")
        )

        return(df)
    }

    values <- c()

    df <- clean_data(files[1], 1) %>%
    inner_join(
        clean_data(files[2], 2)
    ) %>%
    na.omit(values[2])
}

get_var_name <- function(file) {
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

    return(pretty_print(file))
}
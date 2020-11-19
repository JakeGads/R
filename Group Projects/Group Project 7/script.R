# Libraries
# once their smart loaded but windows didn't like that
# "e tu bill gates"
library(tidyverse)
library(devtools)
library(modelr)
library(gridExtra)

#' Loads script via strings, if the script is not present it will attempt to download them
#' @param location (string) if the entire project is loaded where it would stand
#' @param repo (string) the raw github link, defaults to the repo used by to host this project
#' @export
smart_script_loader <- function(location, repo = "https://raw.githubusercontent.com/gadzygadz/R/master/Group%20Projects/Group%20Project%207/"){
    tryCatch({
            source(location) # tries to download locally
        }, warning = function(e) {
            print(paste("Downloading ", location, sep= "")) 
            source_url(paste(repo, location, sep="")) # checks the website
        }, error = function(e) {
            print("must use the raw page ie raw.githubusercontent.com, instead of github.com") # assumes the link was sent wrong
        })
}

# for loop to grab additional scripts
for (i in c("funs.R", "regression.R")){
    smart_script_loader(i) # loads scripts even if not present on harddrive
}

# all files present in the system
files <- c(
    "armed_forces_personnel.csv",
    "basic_water_access.csv",
    "earthquake.csv",
    "energy_production.csv",
    "income.csv",
    "life_expectancy.csv",
    "literacy_rate.csv",
    "refugee_diaspora.csv",
    "refugee_share.csv",
    "under_5_population.csv"
)

# for making graphs pretty
val_names <- c(NA)

# loads them in dynamicaly
for (i in 1:length(files)) {
    val_names[i] <- get_var_name(files[i])
}


# # # All Types of regression that we have used previously
# # linear
# lm(y ~ x, data=data)
# lm(y ~ I(x^2), data)
# lm(log(y) ~ sqrt(x) - 1, data)
# lm(y ~ I(x^2) + x - 1, data)

# loess
# loess(y ~ x, data=data)
# loess(y ~ I(x^2), data)
# loess(log(y) ~ sqrt(x) - 1, data)
# loess(y ~ I(x^2) + x - 1, data)
#endregion




#region first graph
start <- 8
end <- 9

data <- get_tibble(files[start], files[end]) # running get tibles will join the files
regression <- loess(y ~ x, data) # the regression algorithm you want ot run
grid <- data %>%
    data_grid(x) %>%
    add_predictions(regression) # follow this example to save it to the grid

gen_model(
    data, # the data frame
    regression, # the regression
    grid, # the grid, must be generated oustide of the function for some reason
    "Loess: log(y) ~ sqrt(x)", # a string to be used in labs
    val_names[start], # used for labs, should match the first file
    val_names[end], # used for labs should match the second file
    pdf="1", # if set it will save the pdf as that location, if not it will save as a raw
    smooth_comp=T, # will add a comparison to a geom_smooth
    bins = 10
)
#endregion

#region second graph
start <- 1
end <- 3

data <- get_tibble(files[start], files[end]) # running get tibles will join the files
regression <- lm(y ~ I(x^2) + x - 1, data) # the regression algorithm you want ot run
grid <- data %>%
    data_grid(x) %>%
    add_predictions(regression) # follow this example to save it to the grid

gen_model(
    data, # the data frame
    regression, # the regression
    grid, # the grid, must be generated oustide of the function for some reason
    "lm y ~ I(x^2) + x - 1", # a string to be used in labs
    val_names[start], # used for labs, should match the first file
    val_names[end], # used for labs should match the second file
    pdf="2", # if set it will save the pdf as that location, if not it will save as a raw
    smooth_comp=T, # will add a comparison to a geom_smooth
    bins = 10
)
#endregion

#region third graph
start <- 2
end <- 4

data <- get_tibble(files[start], files[end]) # running get tibles will join the files
regression <- loess(y ~ I(x^2), data) # the regression algorithm you want ot run
grid <- data %>%
    data_grid(x) %>%
    add_predictions(regression) # follow this example to save it to the grid

gen_model(
    data, # the data frame
    regression, # the regression
    grid, # the grid, must be generated oustide of the function for some reason
    "loess: y ~ I(x^2)", # a string to be used in labs
    val_names[start], # used for labs, should match the first file
    val_names[end], # used for labs should match the second file
    pdf="3", # if set it will save the pdf as that location, if not it will save as a raw
    smooth_comp=T, # will add a comparison to a geom_smooth
    bins = 10
)
#endregion

#region third graph
start <- 5
end <- 2

data <- get_tibble(files[start], files[end]) # running get tibles will join the files
regression <- lm(y ~ x, data=data) # the regression algorithm you want ot run
grid <- data %>%
    data_grid(x) %>%
    add_predictions(regression) # follow this example to save it to the grid

gen_model(
    data, # the data frame
    regression, # the regression
    grid, # the grid, must be generated oustide of the function for some reason
    "LM: y ~ x", # a string to be used in labs
    val_names[start], # used for labs, should match the first file
    val_names[end], # used for labs should match the second file
    pdf="4", # if set it will save the pdf as that location, if not it will save as a raw
    smooth_comp=T, # will add a comparison to a geom_smooth
    bins = 10
)
#endregion
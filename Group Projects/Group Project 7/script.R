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
            source(location)
        }, warning = function(e) {
            print(paste("Downloading ", location, sep= ""))
            source_url(paste(repo, location, sep=""))
        }, error = function(e) {
            print("must use the raw page ie raw.githubusercontent.com, instead of github.com")
        })
}

# for loop to grab additional scripts
for (i in c("funs.R", "regression.R")){
    smart_script_loader(i)
}

# all files present in the system
files <- c(
    "data/armed_forces_personnel.csv",
    "data/basic_water_access.csv",
    "data/earthquake.csv",
    "data/energy_production.csv",
    "data/income.csv",
    "data/life_expectancy.csv",
    "data/literacy_rate.csv",
    "data/refugee_diaspora.csv",
    "data/refugee_share.csv",
    "data/under_5_population.csv"
)

val_names <- c(NA)

# loads them in dynamicaly
for (i in 1:length(files)) {
    val_names[i] <- get_var_name(files[i])
}

# # linear
# lm(y ~ x, data=df)
# lm(y ~ I(x^2), df)
# lm(log(y) ~ sqrt(x) - 1, df)
# lm(y ~ I(x^2) + x - 1, df)

# loess
# loess(y ~ x, data=df)
# loess(y ~ I(x^2), df)
# loess(log(y) ~ sqrt(x) - 1, df)
# loess(y ~ I(x^2) + x - 1, df)
#endregion



data <- get_tibble(files[6], files[5]) # running get tibles will join the files
regression <- loess(y ~ x, data) # the regression algorithm you want ot run
grid <- data %>%
    data_grid(x) %>%
    add_predictions(regression) # follow this example to save it to the grid

gen_model(
    data, # the data frame
    regression, # the regression
    grid, # the grid, must be generated oustide of the function for some reason
    "Loess: log(y) ~ sqrt(x)", # a string to be used in labs
    val_names[6], # used for labs, should match the first file
    val_names[5], # used for labs should match the second file
    pdf="gamer", # if set it will save the pdf as that location, if not it will save as a raw
    smooth_comp=T, # will add a comparison to a geom_smooth
    bins = 25
)

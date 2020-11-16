#' Loads packages via strings if a package is not found it will install it from a given repo
#' @param package (string) the library that will be loaded in
#' @param repo (string) the mirror you wish to download to defaults to defualt R mirror
#' @export
smart_package_loader <- function(package, repo="http://cran.rstudio.com"){
    tryCatch({
        library(package, character.only=TRUE)
    },  error = function(e) {
        install.packages(package, repos = repo)
        tryCatch({
                library(package, character.only=TRUE)
            }, error = function(e) {
                print("packages have failed to install please run in interactive mode")        
            })  
    })
}

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

#' Loads csv, if not found will reach out to github
#' @param location (string) if the entire repo is present the file location 
#' @param repo (string) where the repo is hosted, defaulted to the repo where this is hosted
#' @export
smart_data_loader <- function(location, repo = "https://raw.githubusercontent.com/gadzygadz/R/master/Group%20Projects/Group%20Project%207/"){
    data <- 0
    tryCatch(
        {
            data <- read_csv(location)
        }, error = function(e) {
            print(paste("Downloading ", location, sep= ""))
            data <- read_csv(url(paste(repo, location, sep="")))
        }
    )
    return(data)
}

# for loop that installs the packages that are needed 
for (i in c("tidyverse", "devtools", "modelr")){
    smart_package_loader(i, "http://ftp.ussg.iu.edu/CRAN/") # on DeSales wifi this has been the best cran mirror to use
}

# for loop to grab additional scripts
for (i in c("funs.R", "regression.R")){
    smart_script_loader(i)
}

# all files present in the system
files <- c(
    "data/basic_water_access.csv", 
    "data/energy_production.csv",
    "data/income.csv",
    "data/life_expectancy.csv",
    "data/literacy_rate.csv",
    "data/under_5_population.csv"
    # Some Data is missing
)

data <- c(NA)
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


# example
df <- get_tibble(smart_data_loader(files[1]), smart_data_loader(files[2]))
gen_model(
    df,
    loess(log(y) ~ sqrt(x) - 1, df), 
    "Loess: log(y) ~ sqrt(x)", 
    val_names[1], 
    val_names[2], 
    pdf='example.pdf', 
    smooth_comp=T
)
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

smart_data_loader <- function(location, repo = "https://raw.githubusercontent.com/gadzygadz/R/master/Group%20Projects/Group%20Project%207/"){
    data <- 0
    tryCatch(
        {
            data <- read_csv(location)
        }, warning = function(e) {
            print(paste("Downloading ", location, sep= ""))
            data <- (paste(repo, location, sep=""))
        }
    )
    return(data)
}

for (i in c("tidyverse", "devtools", "modelr")){
    smart_package_loader(i, "http://ftp.ussg.iu.edu/CRAN/") # on DeSales wifi this has been the best cran mirror to use
}

for (i in c("funs.R")){
    smart_script_loader(i)
}

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

for (i in 1:length(files)) {
    data[i] <- smart_data_loader(files[i])
    val_names[i] <- get_var_name(files[i])
}


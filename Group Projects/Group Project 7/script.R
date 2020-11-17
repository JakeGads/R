#region Script and Library Loading
#' Loads packages via strings if a package is not found it will install it from a given repo
#' @param package (string) the library that will be loaded in
#' @param repo (string) the mirror you wish to download to defaults to defualt R mirror
#' @export
smart_package_loader <- function(package, repo="http://cran.rstudio.com"){
    tryCatch({ # try cath loop handles erros
        library(package, character.only=TRUE) # loads the library as a string
    },  error = function(e) { # if the above section returns an error it will run the following
        install.packages(package, repos = repo) # install the package, while forcing a specialilized repo
        # packages can't be installed if R is running as an Rscript command so this is to inform the users of that
        tryCatch({
                library(package, character.only=TRUE)
            }, error = function(e) {
                print("packages have failed to install please run in interactive mode")
                quit(status=0) # forces the script to exit and feeds the OS an error code        
            })  
    })
}

#' Loads script via strings, if the script is not present it will attempt to download them
#' @param location (string) if the entire project is loaded where it would stand
#' @param repo (string) the raw github link, defaults to the repo used by to host this project
#' @export
smart_script_loader <- function(location, repo = "https://raw.githubusercontent.com/gadzygadz/R/master/Group%20Projects/Group%20Project%207/"){
    tryCatch({
            source(location) # tries to load a local file
        }, warning = function(e) { # failing to find data returns a warning not an error
            # downloads the file
            print(paste("Downloading ", location, sep= ""))
            source_url(paste(repo, location, sep=""))
        }, error = function(e) {
            # informs the user if the scripts have failed for some reason
            print("must use the raw page ie raw.githubusercontent.com, instead of github.com")
            quit(status=0)
        })
}

# for loop that installs the packages that are needed 
for (i in c("tidyverse", "devtools", "modelr", "gridExtra")){
    smart_package_loader(i, "http://ftp.ussg.iu.edu/CRAN/") # on DeSales wifi this has been the best cran mirror to use
}

# for loop to grab additional scripts
for (i in c("funs.R", "regression.R")){
    smart_script_loader(i)
}
#endregion

#region File Information
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
# data as downloaded lazy (as needed) for RAM storage reasons

val_names <- c(NA)

# grabs all the file names to the graphs can look prety
for (i in 1:length(files)) {
    val_names[i] <- get_var_name(files[i])
}
#endregion


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


#region Example Run

df <- get_tibble(files[3], files[5]) # running get tibles will join the files
regression <- loess(y ~ x, df) # the regression algorithm you want ot run
grid <- data %>%
    data_grid(x) %>%
    add_predictions(regression) # follow this example to save it to the grid

gen_model(
    df, # the data frame
    regression, # the regression
    grid, # the grid, must be generated oustide of the function for some reason
    "Loess: log(y) ~ sqrt(x)", # a string to be used in labs
    val_names[3], # used for labs, should match the first file
    val_names[4], # used for labs should match the second file
    pdf='example', # if set it will save the pdf as that location, if not it will save as a raw
    smooth_comp=T # will add a comparison to a geom_smooth
)

#endregion
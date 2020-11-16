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

for (i in c("tidyverse", "ggplot2", "gridExtra","modelr")){
    smart_package_loader(i, "http://ftp.ussg.iu.edu/CRAN/") # on DeSales wifi this has been the best cran mirror to use
}

sim1a <- tibble(
  x = rep(1:10, each = 3),
  y = x * 1.5 + 6 + rt(length(x), df = 2)
)

gen_model <- function(regression, title, comp=F){
    pdf(paste(title, ".pdf", sep=""))
    
    print(sim1a)
    print(regression)

    grid <- sim1a %>%
    data_grid(x) %>%
    add_predictions(regression)

    plot <- ggplot(sim1a, aes(x)) + 
        geom_point(aes(y=y)) +
        geom_point(data = grid, aes(y=pred), color="blue") +
        ggtitle(title)

    if(comp){
        secondary <- ggplot(sim1a, aes(x)) + 
            geom_point(aes(y=y)) +
            geom_smooth(data = grid, aes(y=pred), color="blue") +
            ggtitle(title)
        
        plot <- grid.arrange(
            plot,
            secondary,
            nrow=1
        )
    }

    print(
        plot
    )

    sim1a <- sim1a %>%
    add_residuals(regression)

    plot <- ggplot(sim1a, aes(resid)) +
        geom_freqpoly(binwidth=0.5) +
        ggtitle(title)

    print(
       plot
    )
    

    plot <- ggplot(sim1a, aes(x,resid)) +
        geom_point() +
        geom_ref_line(h=0) +
        ggtitle(title)

    if(comp){
        secondary <- ggplot(sim1a, aes(x,resid)) +
        geom_smooth() + 
        geom_ref_line(h=0) +
        ggtitle(title)

        plot <- grid.arrange(
            plot,
            secondary,
            nrow=2
        )
    }

    print(
        plot
    )

    dev.off()
}

# linear
gen_model(lm(y ~ x, data=sim1a), "linear 1") 
gen_model(lm(y ~ I(x^2), sim1a), "linear 2")
gen_model(lm(log(y) ~ sqrt(x) - 1, sim1a), "linear 3")
gen_model(lm(y ~ I(x^2) + x - 1, sim1a), "linear 4")

# loess
gen_model(loess(y ~ x, data=sim1a), "loess 1", T) 
gen_model(loess(y ~ I(x^2), sim1a), "loess 2", T)
gen_model(loess(log(y) ~ sqrt(x) - 1, sim1a), "loess 3", T)
gen_model(loess(y ~ I(x^2) + x - 1, sim1a), "loess 4", T)

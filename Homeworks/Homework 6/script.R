library(tidyverse)
library(modelr)

sim1a <- tibble(
  x = rep(1:10, each = 3),
  y = x * 1.5 + 6 + rt(length(x), df = 2)
)

gen_model <- function(regression, title, comp=F){
    pdf(paste(title, ".pdf", sep=""))
    
    grid <- sim1a %>%
    data_grid(x) %>%
    add_predictions(regression)

    plot <- ggplot(sim1a, aes(x)) + 
        geom_point(aes(y=y)) +
        geom_point(data = grid, aes(y=pred), color="blue") +
        ggtitle(title)

    if(comp){
        plot <- multiplot(
            p1,
            ggplot(sim1a, aes(x)) + 
            geom_point(aes(y=y)) +
            geom_smooth(data = grid, aes(y=pred), color="blue") +
            ggtitle(title)
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
        ggplot(sim1a, aes(resid)) +
        geom_freqpoly(binwidth=0.5) +
        ggtitle(title)
    )
    
    print(
        ggplot(sim1a, aes(x,resid)) +
        geom_point() +
        geom_ref_line(h=0) +
        ggtitle(title)
    )

    dev.off()
}

# linear
gen_model(lm(y ~ x, data=sim1a), "linear 1") 
gen_model(lm(y ~ I(x^2), sim1a), "linear 2")
gen_model(lm(log(y) ~ sqrt(x) - 1, sim1a), "linear 3")
gen_model(lm(y ~ I(x^2) + x - 1, sim1a), "linear 4")

# loess
gen_model(loess(y ~ x, data=sim1a), "loess 1", true) 
gen_model(loess(y ~ I(x^2), sim1a), "loess 2")
gen_model(loess(log(y) ~ sqrt(x) - 1, sim1a), "loess 3")
gen_model(loess(y ~ I(x^2) + x - 1, sim1a), "loess 4")

library(tidyverse)
library(modelr)

sim1

ggplot(sim1, aes(x,y)) +
geom_point()

ggplot(sim1, aes(x,y)) +
geom_point() +
geom_abline(aes(intercept=3, slope=2))


models <- tibble(
    intercept = runif(10000, -5, 15),
    slope = runif(10000, 0, 4)
)

ggplot(sim1, aes(x,y)) +
geom_point() +
geom_abline(data= models, aes(intercept=intercept, slope=slope), alpha=1/4)

model_predictions <- function(a, data){
    a[1] + a[2] * data$x
}

model_errs <- function(a, data) {
    errs <- data$y - model_predictions(a,data)
    return(
        sqrt(
            mean(errs**2)
        )
    )
}

sim1_model_measure <- function(intercept, slope) {
    model_errs(c(intercept,slope), sim1)
}

models <- models %>%
mutate(err = map2_dbl(intercept, slope, sim1_model_measure))

ggplot(sim1, aes(x,y)) +
geom_point() +
geom_abline(data=filter(models, rank(err) <= 10), aes(intercept=intercept, slope=slope), alpha=1/4)

ggplot(models, aes(intercept,slope)) +
geom_point(aes=(color = err))
# geom_point(data=filter(models, rank(err) <= 10), color = "yellow")


sim1_model <- lm(y ~ x, data=sim1)
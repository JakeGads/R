library(tidyverse)
library(modelr)

# Observer a simulated data set. Notice a general "trend".
ggplot(sim1, aes(x,y)) + 
  geom_point()

# Try to draw a line (many lines?) that capture the "trend" we noticed.
ggplot(sim1, aes(x,y)) + 
  geom_point() +
  geom_abline(aes(intercept = 5, slope=2.5))

# Generate hundreds of options.
models <- tibble(
  intercept = runif(200,-5,15),
  slope = runif(200,0,4)
)

ggplot(sim1, aes(x,y)) + 
  geom_point() +
  geom_abline(data=models, aes(intercept = intercept, slope=slope), alpha=1/4)

# How do we measure "goodness of fit"?

# a = c(intercept, slope)
model_predictions <- function(a, data){
  a[1] + a[2]*data$x
}

model_errors <- function(a, data){
  errors <- data$y - model_predictions(a,data)
  sqrt(mean(errors^2))
}

sim1_model_measure <- function(intercept, slope){
  model_errors(c(intercept,slope),sim1)
}

models <- models %>%
  mutate(err = map2_dbl(intercept,slope, sim1_model_measure))


# Plot the 10 "best" lines.
ggplot(sim1,aes(x,y)) +
  geom_point() +
  geom_abline(data=filter(models,rank(err) <= 10), aes(intercept=intercept, slope=slope), alpha=1/4)

# Look at the "space" of models, i.e. the intercepts and slopes, highlight the "best".
ggplot(models, aes(intercept,slope)) +
  geom_point(aes(color = err)) +
  geom_point(data=filter(models, rank(err)<=1),color="red")

# Take a more methodical approach to "exploring" the "space" of models.
grid <- expand.grid(
  intercept = seq(-5,15, length = 40),
  slope = seq(0,4, length = 40)
) %>%
  mutate(err = map2_dbl(intercept,slope,sim1_model_measure))

# Plot the top 10.
ggplot(grid, aes(intercept,slope)) +
  geom_point(aes(color = err)) +
  geom_point(data=filter(grid, rank(err)<=10),color="red")

# R does it all! Find the "line of best fit" directly. Plot the result.
sim1_mod <- lm(y ~ x, data=sim1)

ggplot(sim1, aes(x,y)) +
  geom_point() +
  geom_abline(intercept=sim1_mod[[1]][[1]], slope=sim1_mod[[1]][[2]])

# We now examine what the line does, and _does not_, tell us. We distinguish between predictions
# and residuals (errors).

# Predictions
grid <- sim1 %>%
  data_grid(x) %>%
  add_predictions(sim1_mod)

ggplot(sim1, aes(x)) + 
  geom_point(aes(y=y)) +
  geom_point(data = grid, aes(y=pred), color="red")

# Residuals (errors)
sim1 <- sim1 %>%
  add_residuals(sim1_mod)

ggplot(sim1, aes(resid)) +
  geom_freqpoly(binwidth=0.5)

ggplot(sim1, aes(x,resid)) +
  geom_point() +
  geom_ref_line(h=0)


# Other models. Still using the "linear model" we can make functions that
# are "linear" in many different ways.

# Here is a quadratic model. We interpret this as y is linear in x^2.
sim1_qmod <- lm(y ~ I(x^2), sim1)

# Predictions
grid <- sim1 %>%
  data_grid(x) %>%
  add_predictions(sim1_qmod)

ggplot(sim1, aes(x)) + 
  geom_point(aes(y=y)) +
  geom_point(data = grid, aes(y=pred), color="red")

# Residuals (errors)
sim1 <- sim1 %>%
  add_residuals(sim1_qmod)

ggplot(sim1, aes(resid)) +
  geom_freqpoly(binwidth=0.5)

ggplot(sim1, aes(x,resid)) +
  geom_point() +
  geom_ref_line(h=0)



# Another quadratic model, now "linear" in x^2 and x but with no constant (intercept).
# Note, the "+" indicates that the two possibilities "x^2" and "x" should act independently.
# We could make the them interact with a "*", but for now that is not helpful.
sim1_qmod <- lm(y ~ I(x^2) + x - 1, sim1)

#predictions
grid <- sim1 %>%
  data_grid(x) %>%
  add_predictions(sim1_qmod)

ggplot(sim1, aes(x)) + 
  geom_point(aes(y=y)) +
  geom_point(data = grid, aes(y=pred), color="red")

# vs residuals (errors)
sim1 <- sim1 %>%
  add_residuals(sim1_qmod)

ggplot(sim1, aes(resid)) +
  geom_freqpoly(binwidth=0.5)

ggplot(sim1, aes(x,resid)) +
  geom_point() +
  geom_ref_line(h=0)



# Our models can get weird. Here is a linear connection between log(y) and sqrt(x).
sim1_wmod <- lm(log(y) ~ sqrt(x) - 1, sim1)

# Predictions
grid <- sim1 %>%
  data_grid(x) %>%
  add_predictions(sim1_wmod)

ggplot(sim1, aes(x)) + 
  geom_point(aes(y=y)) +
  geom_point(data = grid, aes(y=pred), color="red")

# Residuals (errors)
sim1 <- sim1 %>%
  add_residuals(sim1_wmod)

ggplot(sim1, aes(resid)) +
  geom_freqpoly(binwidth=0.1)

ggplot(sim1, aes(x,resid)) +
  geom_point() +
  geom_ref_line(h=0)
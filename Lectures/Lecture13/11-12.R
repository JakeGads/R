library(tidyverse)
library(modelr)

# Modeling with categorical data.
ggplot(sim2) + geom_point(aes(x,y))

mod2 <- lm(y ~ x, data=sim2)

grid <- sim2 %>%
  data_grid(x) %>%
  add_predictions(mod2)

ggplot(sim2, aes(x)) +
  geom_point(aes(y=y)) +
  geom_point(data=grid, aes(y=pred), size = 4, color="red")

# Two variable models.

# Two numerical variables.
# Independent (+)
mod1 <- lm(y ~ x1 + x2, data=sim4)
# Interacting (*)
mod2 <- lm(y ~ x1 * x2, data=sim4)

grid <- sim4 %>%
  data_grid(
    x1 = seq_range(x1, 10),
    x2 = seq_range(x2, 10)) %>%
  gather_predictions(mod1,mod2)

# View from "above"
ggplot(grid, aes(x1,x2)) +
  geom_tile(aes(fill=pred)) +
  facet_wrap(~ model)

# View from the "front"
ggplot(grid, aes(x1, pred, color=x2, group=x2)) +
  geom_line()+
  facet_wrap(~ model)

# View from the "side"
ggplot(grid, aes(x2, pred, color=x1, group=x1)) +
  geom_line() +
  facet_wrap(~ model)


# One numerical variable, one categorical variable.
ggplot(sim3, aes(x1,y)) +
  geom_point(aes(color=x2))

# Independent (+)
mod1 <- lm(y ~ x1 + x2, data=sim3)
# Independent (*)
mod2 <- lm(y ~ x1 * x2, data=sim3)

# Visualize predictions.
grid <- sim3 %>%
  data_grid(x1,x2) %>%
  gather_predictions(mod1,mod2)

ggplot(sim3, aes(x1,y,color=x2)) +
  geom_point() +
  geom_line(data=grid, aes(y=pred)) +
  facet_wrap(~ model)

# Visualize residuals.
sim3 <- sim3 %>%
  gather_residuals(mod1,mod2)

ggplot(sim3, aes(x1,resid, color=x2)) +
  geom_point() +
  facet_grid(model ~ x2)



# Modeling some real data.
full <- read_csv("life_expectancy.csv") %>%
  pivot_longer(colnames(.)[-1],names_to='year',values_to='lifex') %>%
  type_convert()

specific <- full %>%
  filter(country == "Russia", year <= 2020, year >= 1950)

ggplot(specific, aes(year, lifex)) +
  geom_line()

mod <- lm(lifex ~ year, data=specific)

specific %>%
  add_predictions(mod) %>%
  ggplot(aes(year, pred)) +
  geom_line()

specific %>%
  add_residuals(mod) %>%
  ggplot(aes(year, resid)) +
  geom_line() +
  geom_hline(yintercept = 0, color="white", size = 3)
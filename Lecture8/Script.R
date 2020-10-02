library(tidyverse)

library(viridis)
library(scales)

theme_set(theme_minimal())

options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")

# joining things

x <- tibble(
    key=c(1,2,3),
    val_x=c("x1", "x2", "x3")
)

y <- tibble(
    key=c(1,2,4),
    val_y=c("y1", "y2", "y4")
)

# join along key values, keys in x are 123 and y are 124

# inner join s only whats inbetween

inner_join(x,y)

# left_join fill in the left as much as possible

left_join(x,y)

# right join is reverse of left join

right_join(x,y)

# full_join join everything

full_join(x,y)

x %>% inner_join(y)

x <- tibble(
    key=c(1,2, 2 ,3),
    val_x=c("x1", "x2a", "x2b", "x3")
)

left_join(x,y)

y <- tibble(
    key=c(1,2, 2 ,4),
    val_y=c("y1", "y2a", "y2b", "y4")
)

full_join(x,y)

install.packages("nycflights13")
library(nycflights13)

flights
airlines
airports
planes
weather

left_join(flights, airports)
left_join(flights, airports, by=c("origin"="faa"))

left_join(flights, weather)

top_dest <- flights %>%
count(dest,sort=TRUE) %>%
head(5)

right_join(flights, top_dest)
left_join(top_dest, flights, by=c("dest"="origin"))
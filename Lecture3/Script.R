# Block 2
# playing with pictures and data

# install.packages("nycflights13")
# install.packages("tidyverse")

library(nycflights13)
library(tidyverse)
flights

head = ggplot(flights)

# God I hate being color blind
head + geom_point(map=aws(dep_delay, arr_delay, color=carrier))

head + 
geom_point(map=aws(dep_delay, arr_delay, color=carrier)) +
facet_wrap(~month)

# Might find there is a month or 2 that are particularily interesting
# Focus on one of the month we have decied that to be June

# Transformation Methods
# *transform*(data, specifics) -> generate a new dataset
# 1. filter -> pull out only opservations with specific values
head <- ggplot(filter(flights, month==1))

head +
geom_point(map=aws(dep_delay, arr_delay, color=carrier)) +
facet_wrap(~day)

# we can expand on a filter
head <- ggplot(filter(flights, month==1, day==13))

# Logical operators 
head <- ggplot(filter(flights, month <= 1, day==13))

# anding & oring
head <- ggplot(filter(flights, month <= 1 & month <= 12, day==13)) # and
head <- ggplot(filter(flights, month <= 1 | month <= 12, day==13)) # or
# you can "not" any operation using !



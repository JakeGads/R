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

# arrange(dataset, colum_orderby)
head <- ggplot(arrange(flights, year, month, day, hour, minute))
head <- ggplot(arrange(desc(flights), desc(year), desc(month), desc(day), desc(hour), desc(minute)))

ggplot(filter(flight, orgin=="JFK", distance > 4000, dep_delay > 1000)
arrange(flights, desc(dep_delay))
       
# Selecting
a <- select(flights. month, dep_delay, dest)       
arrange(a, dec(dep_delay))
       
# Removing
select(a, -dest)      
       
       
select(a, year:day) # parse the list
select(a, -(year:day))
       
select(flights, starts_with("dep"))
select(flights, ends_with("time"))
select(flights, contains("dep"))
       
mutate(flights, gain=dep_delay-arr_delay) # adds a new column to it all

# Transmute makes a new dataset from the math that you provide it
transmute(A, gain=dep_delay-arr_delay)
       
# Other Operations
# Can use logic to calculate booleans       
       

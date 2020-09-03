library(tidyverse)
library(nycflights13)
flights
filter(flights, dep_time<=600 | dep_time>=1800)

head <- ggplot(flights)

head + geom_point(mapping=aes(dep_time, dep_delay))

head + geom_point(mapping=aes(dep_time, dep_delay, color=carrier))

a <- filter(flights, dep_time > 500 & dep_time < 1500, dep_delay > 500) 

ggplot(a) + 
geom_point(mapping=aes(dep_time, dep_delay))

arrange(a, desc(dep_delay))

a

a <- select(a, month, day, dep_time, dep_delay)

arrange(a, desc(month), desc(dep_delay))

select(flights, contains("delay"))

select(flights, year:day)

flights

ggplot(flights) +
geom_point(mapping=aes(tailnum, arr_delay))

a <- filter(flights, arr_delay > 500)

ggplot(a) +
  geom_point(mapping=aes(tailnum, arr_delay, color=carrier))

arrange(a, carrier)
a <- select(a, arr_delay, tailnum, carrier)
a

ggplot(a) +
  geom_point(mapping=aes(carrier, arr_delay, color=carrier))


a <- mutate(flights, gain=dep_delay-arr_delay)
a <- select(flights, month, day, dep_delay, arr_delay)
a <- mutate(a, gain = dep_delay, arr_delay)

transmute(flights, gain=dep_delay - arr_delay)

# modulus %/%

mutate(a, next_delay=lead(dep_delay))
mutate(a, last_delay=lag(dep_delay))

a <- mutate(a, how_bad=min_rank(dep_delay))

arrange(a, how_bad)

filter(a, how_bad >= 100000 &how_bad<=200000)

filter(select(flights, month:day, contains("delay")), dep_delay<0)

a <- flights %>% 
  select(month:day, contains("delay")) %>% 
  filter(dep_delay<0) %>%
  mutate(gain= dep_delay-arr_delay) %>%
  filter(gain<60)
# Read as  Then

summarise(a, mean(gain), na.rm=TRUE)

# n() - number or count the number of rows
# n_distinct()- distinct values can be passed a col
# first, last, nth(col, position) pulls that specific col
# min(), max(), quartile(col, percentage)
# mean(), median()
# sd(), IQR()

group_by(flights, month,day)

flights %>%
  group_by(month,day)%>%
  summarise(mean_delay=mean(dep_delay,na.rm=TRUE))
# ungroup undoes the operation
library(tidyverse)
library(nycflights13)

flights
# month   day dep_time sched_dep_time dep_delay 
# <int> <int>    <int>          <int>     <dbl>    
  
# arr_time sched_arr_time arr_delay carrier flight tailnum origin dest  air_time
# <int>          <int>     <dbl> <chr>    <int> <chr>   <chr>  <chr>    <dbl>

# Had an arrival delay of two or more hours
flights %>%
  filter(arr_delay > (60 * 2))

# Flew to Houston (IAH or HOU)
flights %>%
  filter(dest == 'IAH' | dest == 'HOU')

# Were operated by United (UA), American (AA), or Delta (DL)
flights %>%
  filter(carrier == 'UA' | 
           carrier == 'AA' | 
           carrier == 'DL'
         )
# Departed in summer (July, August, and September)
flights %>%
  filter(month >= 7 & month <= 9)

# Arrived more than two hours late, but didn’t leave late
flights %>%
  filter(
    arr_delay > (60 * 2) &
      dep_delay <= 0
  )

# Were delayed by at least an hour, but made up over 30 minutes in flight
flights %>%
filter(dep_delay >= 60 & dep_delay - arr_delay > 30)

# Departed between midnight and 6am (inclusive)
flights %>%
  filter(
    dep_time < (6 * 100)
  )

# What happens if you include the name of a variable multiple times in a select() call?
flights %>%
  select(carrier, dep_time, carrier)

select(flights, contains("TIME"))

select(flights, -contains("TIME"))

flights %>% 
mutate(true_air = arr_time - dep_time) %>%
select(air_time, true_air)

flights %>%
select(sched_dep_time, dep_delay, dep_time,)

flights %>%
group_by(carrier) %>%
mutate(total_delay = dep_delay - arr_delay) %>%
summarise(mean_delay=mean(total_delay,na.rm=TRUE)) %>%
arrange(desc(mean_delay))

flights %>%
mutate(total_delay = dep_delay - arr_delay) %>%
mutate(approx_hour = floor(sched_dep_time / 60)) %>%
group_by(approx_hour) %>%
summarise(mean_delay=mean(total_delay,na.rm=TRUE)) %>%
arrange(mean_delay) %>%
select(approx_hour, mean_delay)

a <- flights %>%
mutate(hour = sched_dep_time / 60) %>%
select(hour)
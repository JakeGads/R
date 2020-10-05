install.packages('tidyverse')
install.packages('nycflights13')
suppressPackageStartupMessages(library("tidyverse"))

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)

stocks <- stocks %>% 
pivot_wider(names_from = year, values_from = return) 

stocks

stocks %>% 
pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

table4a

table4a %>% 
pivot_longer(c('1999', '2000'), names_to = "year", values_to = "cases")

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), fill = 'left')

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), fill = 'right')

library(nycflights13)
install.packages("maps")
colnames(weather)
colnames(flights)

airports %>%
right_join(flights, c("faa" = "dest")) %>%
group_by(faa) %>%
summarize(avg_delay = mean(dep_delay, na.rm = TRUE))

airports %>%
right_join(flights, c("faa" = "dest")) %>%
group_by(faa, .drop=FALSE) %>%
summarize(avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
filter(lon > -125) %>% # note I threw out al and hi 
ggplot(aes(lon, lat)) +
borders("state") +
geom_point(mapping=aes(color=avg_delay)) +
coord_quickmap()

a <- planes %>%
filter(year > 1980)

flights %>%
mutate(tot_delay = arr_delay + dep_delay) %>%
group_by(tailnum) %>%
summarize(avg_delay = mean(tot_delay, na.rm = TRUE)) %>%
left_join(select(a, tailnum, year, type), c("tailnum" = "tailnum")) %>%
ggplot(aes(year, avg_delay)) +
geom_point() +
geom_smooth()

flights %>%
summarize(total_flights = count(tailnum))
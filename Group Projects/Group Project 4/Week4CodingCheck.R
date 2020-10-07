#Andrew Chu
#code 1
a1 <- water %>% inner_join(life) %>% inner_join(energy)

ggplot(data = a1) + geom_point(mapping = aes(x = life_expectancy, y = energy))

a1 <- arrange(a1, life_expectancy) %>% filter(life_expectancy > 80)

ggplot(data = a1) + geom_point(mapping = aes(x = life_expectancy, y = energy), color = "blue") + geom_point(mapping = aes(x = life_expectancy, y = per_water_usage), color = "red")
#can't tell anything about water usage so it needs to be separated

ggplot(data = a1) + geom_point(mapping = aes(x = life_expectancy, y = energy), color = "blue")

a1 <- filter(a1, energy < 15000)

ggplot(data = a1) + geom_point(mapping = aes(x = life_expectancy, y = per_water_usage, color = country))
ggplot(data = a1) + geom_point(mapping = aes(x = life_expectancy, y = energy, color = country))

#conclusion: high life expectency seems to correlate with large access to drinking water and there seems to be no correlation with energy usage.


#code 2
b1 <- water %>% inner_join(life) %>% inner_join(literacy)

ggplot(data = b1) + geom_point(mapping = aes(x = life_expectancy, y = per_water_usage))
#large spread around the lower life expectancy. Correlations?

b1 <- filter(b1, life_expectancy < 45)
#dying by 45 is too young, maybe we can help identify some problems?

ggplot(data = b1) + geom_point(mapping = aes(x = life_expectancy, y = per_water_usage, color = country))
#clearly very low water supplies in these countries

ggplot(data = b1) + geom_point(mapping = aes(x = life_expectancy, y = lit_rate, color = country))
#unfortunately, not all countries have a literacy rate. Possibly because it is diificult enough to survive on a day to day basis in these countries.

ggplot(data = b1) + geom_smooth(mapping = aes(x = per_water_usage, y = life_expectancy))
#unusual dip in the graph. Why?

b1 <- filter(b1, life_expectancy < 35)

ggplot(data = b1) + geom_point(mapping = aes(x = per_water_usage, y = life_expectancy, color = country))
#Haiti is a massive outlyer with about a 33 year life expectancy.
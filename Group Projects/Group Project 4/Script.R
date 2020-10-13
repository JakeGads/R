setwd('~/source/repo/R/Group Projects/Group Project 4')
# install.packages("tidyverse")
# install.packages(c("viridis"))
library(tidyverse)

water <- read_csv('Data/basic_water_access.csv') %>%
pivot_longer(
    "2000":"2017", 
    names_to="year", 
    values_to="per_water_usage"
)
colnames(water)

energy <- read_csv('Data/energy_production.csv') %>%
pivot_longer(
    "1960":"2010", 
    names_to="year", 
    values_to="energy"
)
colnames(energy)

income <- read_csv("Data/income.csv") %>%
pivot_longer(
    "1800":"2040", 
    names_to="year", 
    values_to="avg_income"
)
colnames(income)

life <- read_csv("Data/life_expectancy.csv") %>%
pivot_longer(
    "1800":"2100", 
    names_to="year", 
    values_to="life_expectancy"
)
colnames(life)

literacy <- read_csv("Data/literacy_rate.csv") %>%
pivot_longer(
    "1975":"2011", 
    names_to="year", 
    values_to="lit_rate"
)
colnames(literacy)

pop <- read_csv("Data/under_5_population.csv") %>%
pivot_longer(
    "1950":"2100", 
    names_to="year", 
    values_to="population"
)
colnames(pop)

#region Andrew Chu
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
#endregion

#region Leandro
#region 1

#Average Income, Literacy Rate, and Population (Leandro Pares)
inner_join(income,literacy) %>% na.omit(lit_rate)
lp1<-inner_join(income,literacy) %>% na.omit(lit_rate)
lp1A<-inner_join(lp1,pop)
ggplot(data=lp1A) + geom_point(mapping=aes(avg_income,lit_rate, color=population))
lp1B<-filter(lp1A,population < 1.00e+08)
ggplot(data=lp1B) + geom_point(mapping=aes(avg_income,lit_rate, color=population))
ggplot(data=lp1B) + geom_point(mapping=aes(avg_income,lit_rate, color=population)) + facet_wrap(~year)
ggplot(data=lp1B) + geom_point(mapping=aes(avg_income,lit_rate, color=population)) + facet_wrap(~year) + labs(title="Average Income Compared to Literacy Rate", x="Average Income", y="Literacy Rate", color="Population")
#endregion

#region 2
#Average Income, Water Access, and Life Expectancy (Leandro Pares)
lp2<-inner_join(income, water)
lp2A<-inner_join(lp2,life)
ggplot(data=lp2A) + geom_point(mapping=aes(per_water_usage,life_expectancy,color=avg_income))
ggplot(data=lp2A) + geom_point(mapping=aes(per_water_usage,life_expectancy,color=avg_income)) + facet_wrap(~year)
ggplot(data=lp2A) + geom_point(mapping=aes(per_water_usage,life_expectancy,color=avg_income)) + facet_wrap(~year) + labs(title="Water Usage Compared to Life Expectancy", x="Water",y="Life Expectancy",color="Mean Income")
#endregion
#endregion

#region Jake

library(viridis)
library(scales)

theme_set(theme_minimal())

options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")

#region 1

j1 <- life %>%
inner_join(literacy) %>%
inner_join(pop) %>%
na.omit(lit_rate) %>%
na.omit(population)

j1 %>%
ggplot(mapping=aes(life_expectancy, lit_rate, color=population)) +
geom_point() +
geom_smooth(se=FALSE)

j1 %>%
ggplot(mapping=aes(life_expectancy, lit_rate, color=population)) +
geom_point() +
geom_smooth(se=FALSE) + 
facet_wrap(~year)

j1 %>%
filter(population < 10**7) %>%
ggplot(mapping=aes(life_expectancy, lit_rate, color=population)) +
geom_point() +
geom_smooth(se=FALSE) + 
facet_wrap(~year)

j1 %>%
filter(population < 10**7) %>%
ggplot(mapping=aes(life_expectancy, lit_rate, color=population)) +
geom_point() +
geom_smooth(se=FALSE) + 
facet_wrap(~year) +
labs(
    title = "Life Expectancy vs Literarcy Rate",
    subtitle = "colored by population\nwrapped by year",
    x="Life Expectancy",
    y="Literacy Rate",
    color="Population"
) +
theme(
    legend.position = "left"
)
#endregion

#region 2

j2 <- income %>%
group_by(country) %>%
inner_join(energy) %>%
inner_join(water) %>%
na.omit(energy) %>%
na.omit(per_water_usage) %>%
na.omit(avg_income)

j2 %>%
ggplot(aes(energy, per_water_usage, color=avg_income)) +
geom_point()


j2 <-j2 %>%
group_by(country) %>%
#                                                                       Reminder add that extra _
summarize(avg_energy = mean(energy), avg_water = mean(per_water_usage), avg_income_  = mean(avg_income))

j2 %>%
ggplot(aes(avg_energy, avg_water, color=avg_income_)) +
geom_point()

j2 %>%
filter(avg_energy < 1000000) %>%
ggplot(aes(avg_energy, avg_water, color=avg_income_)) +
geom_point() +
facet_wrap(~country)
# now I want to clear out some 

#endregion
#endregion
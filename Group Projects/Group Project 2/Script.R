# install.packages("tidyverse")
library(tidyverse)

# Making it color blind friendly
#region 

# uncomment as needed
# install.packages("viridis")
# install.packages("scales")

library(viridis)
library(scales)

theme_set(theme_minimal())

options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")
#endregion
midwest

# 1 Jake
#region

# lets first look to see if there is any realtionship between adults and poverity
# poppovertyknown <int>
# popadults <int>
# percollege <dbl>

ggplot(midwest) +
geom_point(mapping=aes(popadults, poppovertyknown, color=percollege)) +
ggtitle("orignal")

midwest %>%
filter(popadults >= 3e+6) %>%
arrange(desc(popdensity))

midwest %>%
filter(popadults >= 1e+6) %>%
arrange(desc(popdensity)) %>%
select(popdensity)

j1 <- midwest %>%
filter(popadults <= 1e+6)


ggplot(j1) +
geom_point(mapping=aes(popadults, poppovertyknown, color=popdensity)) +
ggtitle("Pop Density")

ggplot(j1) +
geom_point(mapping=aes(popadults, poppovertyknown, color=popdensity)) +
geom_smooth(mapping=aes(popadults, poppovertyknown)) +
ggtitle("Pop Density w/ regression line")

ggplot(midwest) +
geom_point(mapping=aes(popadults, poppovertyknown, color=popdensity)) +
geom_smooth(mapping=aes(popadults, poppovertyknown)) +
ggtitle("Pop Density w/ regression line")


# This really brings us to the shocking conclusion that the more people exist in a place the higher amount of poverty as well.
#endregion

# 2 Jake
#region
ggplot(midwest) +
geom_point(aes(popdensity, percbelowpoverty)) + 
ggtitle("Orginal\npopulation density vs percentage below poverty")

ggplot(midwest) +
geom_point(aes(popdensity, percbelowpoverty, color=inmetro == 1))

# Take note of really high non metro ones

j2 <- midwest %>%
filter(inmetro != 1)

ggplot(j2) +
geom_point(aes(popdensity, percbelowpoverty, color=poppovertyknown)) +
ggtitle("Trimed DataSet")

# clearing out some of the bottom values

j2 <- midwest %>%
filter(inmetro != 1) %>%
filter(percbelowpoverty > 12.5)

ggplot(j2) +
geom_point(aes(popdensity, percbelowpoverty, color=percollege)) +
ggtitle("density v poverty %\ncatagorized by college")

ggplot(j2) +
geom_point(aes(popdensity, percbelowpoverty, color=percollege)) +
geom_smooth(aes(popdensity, percbelowpoverty)) +
ggtitle("density v poverty %\ncatagorized by college")

# now we can see the percentage below poverty, really isn't impacted by population density or percentage that attended college
#endregion

# Cole 1
#region
c <- mutate(midwest, totperc_popother = percblack + percamerindan + percasian + percother)

ggplot(data=c) + geom_point(mapping=aes(x = state, y = totperc_popother,color = percbelowpoverty))

c1 <- filter(c, state == "WI", totperc_popother >= 75) 
#endregion 
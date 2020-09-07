# install.packages("tidyverse")
library(tidyverse)

#region 
# Making it color blind friendly

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

# lets first look to see if there is any realtionship between adults and poverity
# poppovertyknown <int>
# popadults <int>
# percollege <dbl>

# 1 Jake

ggplot(midwest) +
geom_point(mapping=aes(popadults, poppovertyknown, color=percollege)) +
ggtitle("orignal")

midwest %>%
filter(popadults >= 3e+6) %>%
arrange(descc(popdensity))

midwest %>%
filter(popadults >= 1e+6) %>%
arrange(desc(popdensity)) %>%
select(popdensity)

ggplot(midwest) +
geom_point(mapping=aes(popadults, poppovertyknown, color=popdensity)) +
gg_title("Pop Density")

ggplot(midwest) +
geom_point(mapping=aes(popadults, poppovertyknown, color=popdensity)) +
geom_smooth(mapping=aes(popadults, poppovertyknown)) +
gg_title("Pop Density w/ regression line")
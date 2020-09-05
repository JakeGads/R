library(tidyverse)

# #region Making it color blind friendly

# uncomment as needed
# install.packages("viridis")
# install.packages("scales")

library(viridis)
library(scales)

theme_set(theme_minimal())

options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")
# #endregion

midwest

# lets first look to see if there is any realtionship between adults and poverity
# poppovertyknown <int>
# popadults <int>
# percollege <dbl>

ggplot(midwest) +
geom_point(mapping=aes(popadults, poppovertyknown, color=percollege))
# install.packages("tidyverse")
library(tidyverse)

# Making it color blind friendly
#region 

# uncomment as needed
install.packages("viridis")
install.packages("scales")

library(viridis)
library(scales)

theme_set(theme_minimal())

options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")
#endregion

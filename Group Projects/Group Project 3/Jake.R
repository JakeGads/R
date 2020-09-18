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

getwd() # for error checking
airlines <- read_csv("airlines.csv")
drivers <- read_csv("drivers.csv")
states <- read_csv("states.csv")

colnames(airlines)
colnames(drivers)
colnames(states)
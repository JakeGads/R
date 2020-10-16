# install.packages("tidyverse")
library(tidyverse) # loads a library
# mpg # displays the head of the MPG file
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) # Makes an Rplot (saves as RPlots.pdf`)

#    manufacturer model    displ  year   cyl trans   drv     cty   hwy fl    class
ggplot(data = mpg) + geom_point(mapping = aes(x = manufacturer, y = hwy))
ggplot(data = mpg) + geom_point(mapping = aes(x = manufacturer, y = cty))
ggplot(data = mpg) + geom_point(mapping = aes(x = manufacturer, y = displ))
ggplot(data = mpg) + geom_point(mapping = aes(x = year, y = hwy))
ggplot(data = mpg) + geom_point(mapping = aes(x = cty, y = hwy))




print("Finished")
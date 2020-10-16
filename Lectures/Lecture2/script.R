library(tidyverse)

mpg

ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy))

# Color Codes
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, color=class))

# Sets all dots to the same color
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy), color="blue")

# aes (aestics)
# x, y required
# color (feed a member)
# size (feed an int)
# alpha (feed a float)
# shape (feed an member(inside) or an int(outside))
# stroke (outline)

ggplot(data=mpg) + 
geom_point(mapping=aes(x=displ, y=hwy, size=2, alpha=7, stroke=1))

## Mutiple color 
ggplot(data=mpg) + 
geom_point(mapping=aes(x=displ, y=hwy, color=cyl, size = 2)) + 
geom_point(mapping=aes(x=displ, y=hwy, color=year, size = 1))


ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, color=class))

# Facet will spilt when it generates
ggplot(data=mpg) + 
geom_point(mapping=aes(x=displ, y=hwy)) + 
facet_wrap(~class)

ggplot(data=mpg) + 
geom_point(mapping=aes(x=displ, y=hwy, color=cyl)) + 
facet_wrap(~class)

# grid forces it into a subset of cars
ggplot(data=mpg) + 
geom_point(mapping=aes(x=displ, y=hwy, color=cyl)) + 
facet_grid(drv~cyl)

ggplot(data=mpg) + 
geom_point(mapping=aes(x=year, y=hwy, color=cyl)) + 
facet_grid(year~hwy)

# Smooth makes it very smooth
ggplot(data = mpg) +
geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))

# Added LineType, Group to aes
# LineType is the shape

ggplot(data = mpg) +
geom_smooth(mapping = aes(x = displ, y = hwy, color = drv)) +
geom_point(mapping = aes(x=displ, y=hwy, color=drv))


ggplot(data = mpg) +
geom_smooth(mapping = aes(x = displ, y = hwy, group = drv)) +
geom_point(mapping = aes(x=displ, y=hwy, color=drv))

ggplot(data = mpg) +
geom_smooth(mapping = aes(x = displ, y = hwy, group = drv)) +
geom_point(mapping = aes(x=displ, y=hwy, color=drv)) + 
facet_wrap(~manufacturer)

## geom-bar
### Color Vs Fill

ggplot(data = mpg) +
geom_bar(mapping=aes(x=drv, fill=manufacturer))

# Finds percentage instead of exact value
ggplot(data = mpg) +
geom_bar(mapping=aes(x=drv, fill=manufacturer), position="fill")

# Makes it split based on each inpendent type
ggplot(data = mpg) +
geom_bar(mapping=aes(x=drv, fill=manufacturer), position="dodge")


# Makes it split based on each inpendent type
ggplot(data = mpg) +
geom_bar(mapping=aes(x=drv, fill=manufacturer), position="dodge")

# split by circle
ggplot(data = mpg) +
geom_bar(mapping=aes(x=drv, fill=manufacturer), position="dodge") +
coord_polar()

# flip

# Makes it split based on each inpendent type
ggplot(data = mpg) +
geom_bar(mapping=aes(x=drv, fill=manufacturer), position="dodge") +
coord_flip()

# Only God knows what happened here
ggplot(data = mpg) +
geom_bar(mapping=aes(x=drv, fill=manufacturer), position="jitter") +
coord_flip()

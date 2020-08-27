library(tidyverse) #loading the lib

storms

# name  |   year    |month  |day    |hour   |lat    
# <chr> |   <dbl>   |<dbl>  |<int>  |<dbl>  |<dbl>  

# |long   |status |category   |wind   |pressure
# |<dbl>  |<chr>  |<ord>      |<int>  |<int>

head = ggplot(data=storms) # we use head becuase it saves time during compile hence making testing faster

# 0.0 Playing Around
head +
geom_bar(mapping=aes(x=year,fill=category)) +
ggtitle("Years in the dataset [All]")

# 0.1 Playing Around
head +
geom_bar(mapping=aes(x=name)) +
ggtitle("Repeating names [All]")

# 1.0 Jake
head +  
geom_point(mapping=aes(x=lat, y=long, color=wind))  +
ggtitle("Lat v Long (Wind Edition) [Jake]")

# 1.1 Jake
head +  
geom_point(mapping=aes(x=lat, y=long, color=pressure)) +
ggtitle("Lat v Long (Pressure Edition) [Jake]")

# 1.2 Jake
head +  
geom_point(mapping=aes(x=lat, y=long, color=category)) +
ggtitle("lat v long (Category Edition) [Jake]")

# 2 Jake
head +  
geom_point(mapping=aes(x=wind, y=pressure, color=category)) +
geom_smooth(mapping = aes(x = wind, y = pressure)) +
ggtitle("Wind v Presure w/ category [Jake]")

# 3 Jake
head +  
geom_point(mapping=aes(x=month, y=year, color=hour)) +
ggtitle("What time storms happen every year [Jake]")
# This probablly really says something cool if I could see colors

# 4 Cam
head + 
geom_point(mapping = aes(x = year, y = pressure), color="blue") +
ggtitle("Year v Pressure [Cam]")

# 5 Cam
head + 
geom_point(mapping = aes(x = month, y = pressure, color = wind)) +
ggtitle("Month v Pressure [Cam]")
# The pressure in the storms did not have a trend from year to year, but there was a trend across months. 
# Typically, summer months had a much higher spread in pressure than winter months.


# 6 Cole
head + 
geom_bar(mapping=aes(x=status, fill=status)) + 
facet_wrap(~year) +
ggtitle("Status per year [Cole]")
# shows how many of the different types of storms over the years.

library(tidyverse) #loading the lib

storms

# name  |   year    |month  |day    |hour   |lat    
# <chr> |   <dbl>   |<dbl>  |<int>  |<dbl>  |<dbl>  

# |long   |status |category   |wind   |pressure
# |<dbl>  |<chr>  |<ord>      |<int>  |<int>

head = ggplot(data=storms)

# 0.0
geom_bar(mapping=aes(x=year))

# 0.1
head +
geom_bar(mapping=aes(x=name))

# 1
head +  
geom_point(mapping=aes(x=month, y=year, color=hour)) 
# This probablly really says something cool if I could see colors

# 2.0
head +  
geom_point(mapping=aes(x=lat, y=long, color=wind)) 

# 2.1
head +  
geom_point(mapping=aes(x=lat, y=long, color=pressure)) 

# 2.2
head +  
geom_point(mapping=aes(x=lat, y=long, color=category)) 

# 3
head +  
geom_point(mapping=aes(x=wind, y=pressure, color=category)) +
geom_smooth(mapping = aes(x = wind, y = pressure)) 


# 4
head + 
geom_point(mapping = aes(x = year, y = pressure))

# 5
head + 
geom_point(mapping = aes(x = month, y = pressure))

# The pressure in the storms did not have a trend from year to year, but there was a trend across months. 
# Typically, summer months had a much higher spread in pressure than winter months.
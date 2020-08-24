library(tidyverse) #loading the lib

storms

# name  |   year    |month  |day    |hour   |lat    
# <chr> |   <dbl>   |<dbl>  |<int>  |<dbl>  |<dbl>  

# |long   |status |category   |wind   |pressure
# |<dbl>  |<chr>  |<ord>      |<int>  |<int>

head = ggplot(data=storms)

# These 2 are examples the idea is that we see the spread of years alongside the names
head + 
geom_bar(mapping=aes(x=year))

head +
geom_bar(mapping=aes(x=name))

head +  
geom_point(mapping=aes(x=month, y=year, color=hour)) 
# This probablly really says something cool if I could see colors

# same graph different colors 0
head +  
geom_point(mapping=aes(x=lat, y=long, color=wind)) 

# same graph different colors 1
head +  
geom_point(mapping=aes(x=lat, y=long, color=pressure)) 

# same graph different colors 2
head +  
geom_point(mapping=aes(x=lat, y=long, color=category)) 


head +  
geom_point(mapping=aes(x=wind, y=pressure, color=category)) +
geom_smooth(mapping = aes(x = wind, y = pressure)) 

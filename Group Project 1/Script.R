library(tidyverse) #loading the lib

storms

# name  |   year    |month  |day    |hour   |lat    
# <chr> |   <dbl>   |<dbl>  |<int>  |<dbl>  |<dbl>  

# |long   |status |category   |wind   |pressure
# |<dbl>  |<chr>  |<ord>      |<int>  |<int>

head = ggplot(data=storms)

# 0.0 Playing Around
head +
geom_bar(mapping=aes(x=year)) +
ggtitle("Years in the dataset")

# 0.1 Playing Around
head +
geom_bar(mapping=aes(x=name)) +
ggtitle("Repeating names")

# 1.0 Jake
head +  
geom_point(mapping=aes(x=lat, y=long, color=wind))  +
ggtitle("Lat v Long (Wind Edition)")

<<<<<<< HEAD
# Graph 1
=======
# 1.1 Jake
>>>>>>> 4f6a13c9732b9c70e27446ba61c0387824fc1dd5
head +  
geom_point(mapping=aes(x=lat, y=long, color=pressure)) +
ggtitle("Lat v Long (Pressure Edition)")

<<<<<<< HEAD
=======
# 1.2 Jake
>>>>>>> 4f6a13c9732b9c70e27446ba61c0387824fc1dd5
head +  
geom_point(mapping=aes(x=lat, y=long, color=category)) +
ggtitle("lat v long (Category Edition)")

<<<<<<< HEAD
head +  
geom_point(mapping=aes(x=lat, y=long, color=category)) 

# graph 2
=======
# 2 Jake
head +  
geom_point(mapping=aes(x=wind, y=pressure, color=category)) +
geom_smooth(mapping = aes(x = wind, y = pressure)) +
ggtitle("Wind v Presure w/ category")

# 3 Jake
>>>>>>> 4f6a13c9732b9c70e27446ba61c0387824fc1dd5
head +  
geom_point(mapping=aes(x=month, y=year, color=hour)) +
ggtitle("What time storms happen every year")
# This probablly really says something cool if I could see colors

# 4 Cam
head + 
geom_point(mapping = aes(x = year, y = pressure), color="blue") +
ggtitle("Year v Pressure")

# 5 Cam
head + 
geom_point(mapping = aes(x = month, y = pressure), color="blue") + 
ggtitle("Month v Pressure")
# The pressure in the storms did not have a trend from year to year, but there was a trend across months. 
# Typically, summer months had a much higher spread in pressure than winter months.


# 6 Cole
head + 
geom_bar(mapping=aes(x=status, fill=status)) + 
facet_wrap(~year) +
ggtitle("Status per year")

# shows how many of the different types of storms over the years.

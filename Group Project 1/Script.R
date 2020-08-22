library(tidyverse) #loading the lib

storms

# name  |   year    |month  |day    |hour   |lat    
# <chr> |   <dbl>   |<dbl>  |<int>  |<dbl>  |<dbl>  

# |long   |status |category   |wind   |pressure
# |<dbl>  |<chr>  |<ord>      |<int>  |<int>

head = ggplot(data=storms)

head + 
geom_bar(mapping=aes(x=year))

head +
geom_bar(mapping=aes(x=name))
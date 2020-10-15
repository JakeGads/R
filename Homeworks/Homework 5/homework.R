library(tidyverse)

# 1. Compute the mean of every column in mtcars.

for (i in colnames(mtcars)){
    print(mean(mtcars[[i]]))
}

map(mtcars, mean)

# 2. Determine the type of each column in nycflights13::flights.

library(nycflights13)
for (i in colnames(flights)){
    print(typeof(flights[[i]]))
}

map(flights, typeof)

# 3. Compute the number of unique values in each column of iris.

for (i in colnames(iris)){
    print(length(unique(iris[[i]])))
}


x <- function(x){
    return(length(unique(x)))
}

map(iris, x)

# 4. Generate 10 random normals from distributions with means of -10, 0, 10, and 100.



fizzbuzz <- function(x){
    if(x%%3 == 0 && x%%5 == 0){
        return("FIZZBUZZ")
    }
    else if (x%%3 == 0) {
       return("FIZZ")
    }
    else if (x%%5 == 0){
        return("BUZZ")
    }
}
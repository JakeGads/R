# Jake Gadaleta | Homework 5
## Section 20.3.5: # 3

### 3. A logical vector can take 3 possible values. How many possible values can an integer vector take? How many possible values can a double take? Use google to do some research.

info found on [stack_overflow](https://stackoverflow.com/questions/18507920/largest-possible-values-in-r)

#### Integers

```R
> .Machine$integer.max
[1] 2147483647
```

that means we have to double that number when accounting for the negatives

#### Doubles 

```R
> .Machine$double.xmax
[1] 1.797693e+308
```

again double that to account for negatives

## Section 20.4.6: # 5 , 6

### 5. Why is x[-which(x > 0)] not the same as x[x <= 0]?

the second will store everything wether it is true or not where as the first will drop all columns that came up as True

### 6. What happens when you subset with a positive integer that’s bigger than the length of the vector? What happens when you subset with a name that doesn’t exist?

the rest of the data will fill with N/A's

```R
> c(1,2,3)[2:5]
[1] 2 3 NA NA
```

## Section 21.2.1: # 1 , 2

### 1.Write for loops to:    
1. Compute the mean of every column in mtcars.

```R
for (i in colnames(mtcars)){
    print(mean(mtcars[[i]]))
}
```

2. Determine the type of each column in nycflights13::flights.

```R
library(nycflights13)
for (i in colnames(flights)){
    print(typeof(flights[[i]]))
}
```

3. Compute the number of unique values in each column of iris.

```R
for (i in colnames(iris)){
    print(length(unique(iris[[i]])))
}
```

4. Generate 10 random normals from distributions with means of -10, 0, 10, and 100.

## Section 21.5.3: # 1 , 4

### 1. Write for maps to:    
1. Compute the mean of every column in mtcars.

```R
map(mtcars, mean)
```

2. Determine the type of each column in nycflights13::flights.

```R
map(flights, typeof)
```

3. Compute the number of unique values in each column of iris.

```map
x <- function(x){
    return(length(unique(x)))
}

map(iris, x)
```

4. Generate 10 random normals from distributions with means of -10, 0, 10, and 100.

### 4. What does map(-2:2, rnorm, n = 5) do? Why? What does map_dbl(-2:2, rnorm, n = 5) do? Why?

working backwords n: will set the number fo times that it will run the calculation

rnorm is a function that "Density, distribution function, quantile function and random generation for the normal distribution with mean equal to ‘mean’ and standard deviation equal to ‘sd’." which is played over the set

-2:2 is the set 

map runs it over the data set

the second function doesn't compile

## Section 19.2.1: # 4

### 4. write your own functions to compute the variance and skewness of a numeric vector. Variance is defined as 

![](Images/1.png)

```R
variance <- function(n, x){
    sum <- 0

    for(i in x){
        sum<- sum + (i - mean(x))
    }

    return(
        1/(n-1) * (sum * sum)
    )
}

skew <- function(n, x){
    sum <- 0

    for(i in x){
        sum<- sum + (i - mean(x))
    }

    return(
        ((1/(n-2)) * (sum * sum * sum)) / variance(n,x)
    )
}
```

## Section 19.4.4: # 3 

### 3. Implement a fizzbuzz function. It takes a single number as input. If the number is divisible by three, it returns “fizz”. If it’s divisible by five it returns “buzz”. If it’s divisible by three and five, it returns “fizzbuzz”. Otherwise, it returns the number. Make sure you first write working code before you create the function.

```R
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
```
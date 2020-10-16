library(tidyverse)

rescale <- function(x){
    r <- range(x)
    print(r)
    # note that you must include () on return
    return((x - r[1])/(r[2]-r[1]))
}

x <- rescale(c(10,20,40))

# multiple arguments
rescale <- function(x, upper){
    r <- range(x)
    return(
        upper * ((x-r[1])/(r[2]-r[1]))
    )
}

# default arguments
rescale <- function(x, upper=1) {
    r <- range(x)
    return(
        upper * ((x-r[1])/(r[2]-r[1]))
    )
}

# environment
rescale <- function(x, upper=1) {
    r <- range(x)
    return(
        upper * ((x-r[1])/(r[2]-r[1])) + shift
    )
}

shift <- 10

# variables are all pass by value

## TODO Remember this one JAKE

fun1 <- function(){
    fun2 <- function() {
        print("yes")
    }
    fun2()
    readline(prompt="Press [enter] to continue:")
}

# String concat

paste("string 1", "string 2")
paste("string 1", "string 2", sep='')

if (10 %% 3 == 0){
    print("10 is a multiple of 3")
} else if (10 %% 4 == 0) {
   print("10 is a multiple of 4")
} else {
   print("10 us not a multiple of 3 or 4")
}

for (i in 1:100){
    if(i %% 3 == 0){
        print(paste(i, "is divisable by 3"))
    } else if (i %% 3 == 1){
        print(paste(i, "has remander 1"))
    } else {
        print(paste(i, "has remander 2"))
    }
}

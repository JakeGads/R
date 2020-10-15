library(tidyverse)
library(viridis)
library(scales)
theme_set(theme_minimal())
options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")

# we are learning how to script

a <- c(1,2,3,4,5)
typeof(a)

b <- c(1L,2L,3L,4L,5L)
typeof(b)

c <- c(TRUE, FALSE, TRUE)
typeof(c)

# methods to create vectors

d <- 1:50
d
typeof(d)

e <- sample(100, 20, replace=TRUE)
e
typeof(e)
length(e)

f <- runif(10)

g <- rep("a", 10)

h <- 1:10 + 5
i <- 1:20 > 7

j1 <- 1:100 %% 3 == 1
typeof(j1)
j2 <- 1:100 %% 4 == 2

# combining vectors
k <- c(1:10, 20:30)
l <- c(20:30, 1:10)

m <- 1:10 + 1:10

n <- 1:10 * 1:10
n

n <- 1:10 * 1:8
n

o <- 1:10 + 1:5
o

p <- 1:10 * 1:2
p


j1 <- 1:50 %% 3 == 1
typeof(j1)
j2 <- 1:50 %% 4 == 2


q <- j1 & j2
q

r <- j1 | j2
r

s <- j1 * j2
s

# indexing

f <- runif(100)
f
f[3]
f[c(1,3,5)]
f[1:3]
f[j1]

u <- 1:100 %% 7 == 4
u

t <- 1:100
t

t[u]

v <- sample(100, 20)
q <- v[-10]
q

x <- list("a", 1, TRUE, 1:4)
x[1:3]
x[[1]]
x[[4]]
x[[4]][1]

y <- as.tibble(iris)
y[1:4]
y[-5]
y[[1]]

y[[1]][25]

# iteration for loops

z <- rep(0,4)
for (i in 1:4){
    z[[i]] <- median(y[[i]])
}
z

aa <- map(y[-5], median)
ab <- map_dbl(y[-5], median)
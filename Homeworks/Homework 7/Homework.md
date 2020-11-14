# Jake Gadaleta | Block 7 Check

## Section 23.2.1: # 1

## One downside of the linear model is that it is sensitive to unusual values because the distance incorporates a squared term. Fit a linear model to the simulated data below, and visualise the results. Rerun a few times to generate different simulated datasets. What do you notice about the model?

```R
library(tidyverse)
library(modelr)

sim1a <- tibble(
  x = rep(1:10, each = 3),
  y = x * 1.5 + 6 + rt(length(x), df = 2)
)

gen_model <- function(regression, title){
    pdf(paste(title, ".pdf"))
    
    grid <- sim1a %>%
    data_grid(x) %>%
    add_predictions(regression)

    print(
        ggplot(sim1a, aes(x)) + 
        geom_point(aes(y=y)) +
        geom_point(data = grid, aes(y=pred), color="blue")
    )

    sim1a <- sim1a %>%
    add_residuals(regression)

    print(
        ggplot(sim1a, aes(resid)) +
        geom_freqpoly(binwidth=0.5)
    )
    
    print(
        ggplot(sim1a, aes(x,resid)) +
        geom_point() +
        geom_ref_line(h=0)
    )
    
    dev.off()
}


gen_model(lm(y ~ x, data=sim1a), "1") 
gen_model(lm(y ~ I(x^2), sim1a), "2")
gen_model(lm(log(y) ~ sqrt(x) - 1, sim1a), "3")
gen_model(lm(y ~ I(x^2) + x - 1, sim1a), "4")

```

I tackled this the only way that I know how and that was just the program the hell out of it. using a simple function I took the basic setup that we used in class and just looped through each one from 11-10 and saved each to it's own pdf file I then just took like 3 seconds to look through to find which version allowed us to have the best fit.

```R
gen_model(lm(y ~ x, data=sim1a), "1") 
gen_model(lm(y ~ I(x^2), sim1a), "2")
gen_model(lm(log(y) ~ sqrt(x) - 1, sim1a), "3")
gen_model(lm(y ~ I(x^2) + x - 1, sim1a), "4")
```

### 1

While the intaial model for 1 looks good when checked against the residuls it does raise the question while not being super predicatable it could definatly be better

### 2

2 looks a lot like one except for the fact that I like the resudials a lot more

### 3 

3 is just bad in general that model doesn't even come close to properly fitting

### 4

4 looks pretty good but not as favored as 2

In th ened I belive that 2 is the best that we can get given these formulas


## Section 23.3.3: # 1

Instead of using `lm()` to fit a straight line, you can use `loess()` to fit a smooth curve. Repeat the process of model fitting, grid generation, predictions, and visualisation on sim1 using `loess()` instead of `lm()`. How does the result compare to `geom_smooth()`?
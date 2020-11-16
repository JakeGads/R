# linear
gen_model(lm(y ~ x, data=sim1a), "linear 1") 
gen_model(lm(y ~ I(x^2), sim1a), "linear 2")
gen_model(lm(log(y) ~ sqrt(x) - 1, sim1a), "linear 3")
gen_model(lm(y ~ I(x^2) + x - 1, sim1a), "linear 4")

# loess
gen_model(loess(y ~ x, data=sim1a), "loess 1", T) 
gen_model(loess(y ~ I(x^2), sim1a), "loess 2", T)
gen_model(loess(log(y) ~ sqrt(x) - 1, sim1a), "loess 3", T)
gen_model(loess(y ~ I(x^2) + x - 1, sim1a), "loess 4", T)

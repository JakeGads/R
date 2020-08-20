ggplot(data = mpg) +
geom_bar(mapping=aes(x=drv, color=manufacturer))
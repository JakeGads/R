library(tidyverse)

ggplot(data = mpg) + geom_point(mapping = aes(x = cty, y = hwy))

ggplot(data = mpg) + 
geom_point(mapping = aes(x = cty, y = hwy, color=class)) +
labs(
    title = "City MPG vs Highway MPG",
    subtitle = "Comparing the city mpg and the highway mpg for all points",
    caption = "I just wanted to prove that I can generate a caption",
    x="City MPG",
    y="Highway MPG",
    color="Car Type"
) +
theme(
    legend.position = "top"
) 

ggplot(data = mpg) + 
geom_point(mapping = aes(x = cty, y = hwy, color=class)) +
labs(
    title = "City MPG vs Highway MPG",
    subtitle = "Comparing the city mpg and the highway mpg for all points",
    caption = "I just wanted to prove that I can generate a caption",
    x="City MPG",
    y="Highway MPG",
    color="Car Type"
) +
theme(
    legend.position = "top"
) + 
geom_text(data=mpg, mapping=aes(x = cty, y = hwy, label=model))+
facet_wrap(~class)

yehaw <- mpg %>%
filter(class=="minivan")

ggplot(data = mpg) + 
geom_point(mapping = aes(x = cty, y = hwy, color=class)) +
labs(
    title = "City MPG vs Highway MPG",
    subtitle = "Comparing the city mpg and the highway mpg for all points",
    caption = "I just wanted to prove that I can generate a caption",
    x="City MPG",
    y="Highway MPG",
    color="Car Type"
) +
theme(
    legend.position = "top"
) + 
geom_text(data=yehaw, mapping=aes(x = cty, y = hwy, label=model))+
facet_wrap(~class)

presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    scale_x_date(NULL, breaks = presidential$start, date_labels = "'%y")


presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, colour = party)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    scale_colour_manual(values = c(Republican = "red", Democratic = "blue"))

presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, colour = party)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    scale_x_date(NULL, breaks = presidential$start, date_labels = "'%y") + 
    scale_colour_manual(values = c(Republican = "red", Democratic = "blue"))

presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, colour = party)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    geom_text(aes(x = start, y = id, label=name), position = position_nudge(y = 0.3)) + 
    scale_x_date(NULL, breaks = presidential$start, date_labels = "'%y") + 
    scale_colour_manual(values = c(Republican = "red", Democratic = "blue"))


parse_number("100.300.45", locale=locale(decimal_mark=","))


presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, colour = party)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    geom_text(aes(x = start, y = id, label=name), position = position_nudge(y = 0.3)) + 
    scale_x_date(NULL, breaks = presidential$start, date_labels = "'%y") + 
    scale_colour_manual(values = c(Republican = "red", Democratic = "blue")) +
    scale_y_continuous(breaks=seq(33, 44)) +
    labs(
      title="Years in office as Presdident",
      y = "President Number"
    )
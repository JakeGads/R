# install.packages("tidyverse")
library(tidyverse)

# Making it color blind friendly
#region 

# uncomment as needed
# install.packages("viridis")
# install.packages("scales")

library(viridis)
library(scales)

theme_set(theme_minimal())

options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")
#endregion

# we can make pretty pictures
# we can modify the data

# we are gonna make them more readable moving forward

ggplot(mpg) +
geom_point(mapping=aes(x=displ, y=hwy, color=class)) +
labs(
    title = "Displ vs Highway",
    subtitle = "subtitle",
    caption = "continuing labeling",
    x="Displacement",
    y="Highway",
    color="Car Type"
) +
theme(
    legend.position = "top"
)


best_in_class <- mpg %>%
group_by(class) %>%
filter(row_number(desc(hwy)) == 1)

best_in_class

ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) +
geom_point(mapping = aes(color=class)) +
geom_text(data = best_in_class, mapping=aes(label=model))


worst_in_class <- mpg %>%
group_by(class) %>%
filter(row_number(hwy) == 1)

ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) +
geom_point(mapping = aes(color=class)) +
geom_text(data = worst_in_class, mapping=aes(label=model)) +
labs(
    title = "Displacment vs Highway",
    caption = "Label is the worst car",
    x="Displacement",
    y="Highway",
    color="Car Type"
) +
theme(
    legend.position = "top"
)


ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) +
geom_point(mapping = aes(color=class)) +
geom_label(
    data = worst_in_class, 
    mapping=aes(label=model),
    alpha = .5,
    nudge_y = 1
) +
labs(
    title = "Displacment vs Highway",
    caption = "Label is the worst car",
    x="Displacement",
    y="Highway",
    color="Car Type"
) +
theme(
    legend.position = "top"
)

label <- mpg %>%
summarise(
    max_displ = max(displ),
    max_hwy = max(hwy),
    label="Big and Efficent"
)

ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) + 
geom_point() +
geom_text(
    label, 
    mapping= aes(x=max_displ, y=max_hwy, label=label),
    vjust="bottom", 
    hjust="right"
)

avg_label <- mpg %>%
summarise(
    avg_displ = mean(displ),
    avg_hwy = mean(hwy),
    label="Completley Average"
)

ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) + 
geom_point() +
geom_text(
    avg_label, 
    mapping= aes(x=avg_displ, y=avg_hwy, label=avg_label),
    vjust="bottom", 
    hjust="right"
)

label <- mpg %>%
summarise(
    avg_displ = min(displ),
    avg_hwy = min(hwy),
    label="dismal"
)

ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) + 
geom_point() + 
geom_point(
    data=label,
    shape=1,
    color="red"
) +
geom_text(
    label,
    mapping=aes(label=label),
    vjust="bottom",
    hjust=:"left"
)

ggplot(data=mpg, 
mapping=aes(displ, hwy)
) + 
geom_point() +
scale_y_continuous(
    breaks=seq(15,45,by=5)
)


ggplot(data=mpg, 
mapping=aes(displ, hwy)
) + 
geom_point() +
scale_y_continuous(
    breaks=c(15,30, 32, 41, 45)
)

mpg %>% 
filter(
    displ > 5,
    displ < 7,
    hwy >= 10,
    hwy <= 30
) %>%
ggplot(mapping=aes(x=displ, y=hwy)) +
geom_point(mapping=aes(color = class)) +
geom_smooth()

ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) +
geom_point(mapping=aes(color=class)) + 
geom_smooth() +
coord_cartesian(xlim=c(5,7), ylim=c(10,30))

suv <- mpg %>% 
filter(class=='suv')

compact <- mpg %>%
filter(class=='compact')

ggplot(
    suv,
    mapping=aes(x=dsipl, y=hwy)
) +
geom_point

ggplot(
    compact,
    mapping=aes(x=dsipl, y=hwy)
) +
geom_point

x_scale <- scale_x_continuous(limits=range(mpg$displ))
y_scale <- scale_y_continuous(limits=range(mpg$hwy))

ggplot(suv, mapping=aes(x=displ, y=hwy)) +
geom_point() + 
x_scale +
y_scale

ggplot(compact, mapping=aes(x=displ, y=hwy)) +
geom_point() + 
x_scale +
y_scale


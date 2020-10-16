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

# We are working with actual data set
getwd()
setwd("../Lecture6") # even windows users Unix file pathing
getwd()

a <- read_csv("sample1.csv")

ggplot(a)+
geom_point(mapping=aes(x,y))

a <- read_csv("sample1.csv", col_names=c("percentage", "date"), skip=1)

b <- read_csv("sample2.csv", skip=2, col_names=c("percentage", "date"))

b

read_csv("sample2.csv", skip=2, col_names=FALSE)

read_csv("sample3.csv", skip=1, comment="#")

# reading pacakages
# read_csv
# read_csv2 -> semicolon seperated
# read_tsv -> tab a seperated
# read_delimeter -> and delimeter

read_csv("sample2.csv", skip=1)

read_csv("sample4.csv")

parse_logical(c("True", "False", "NA"))

parse_integer(c("1", "2", "3"))

parse_integer(c("1", "2", ".", "3"), na=".")

parse_number(c("100", "$100", "100.2", "The cost is $100 and 52c"))

parse_number(c("100,000", "100_000", "100.000"), locale=locale(grouping_mark="."))

parse_number("100.300,45", locale=locale(decimal_mark=",", grouping_mark="."))

parse_date("1/12/1969")
parse_date("04/15/99", "%m/%d/%y")

guess_parser("1/12/1969")

guess_parser(c("1/12/1969", 10, 'f'))

read_csv("sample4.csv", col_types=cols(x=col_double(), y=col_date()))

A <- read_csv("sample4.csv", col_types= cols(.default=col_character()))

tail(A$y)

type_convert(
    A, 
    col_types= cols(
        x=col_double(), 
        y=col_date()
    )
)
library(tidyverse)

library(viridis)
library(scales)

theme_set(theme_minimal())

options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")

# we learning how to find datasets

# whats a tidy dataset

table1
# this is neat becuase every value is filled with unique data

table2

# Piviot
# Table 2

table2

table2 %>% pivot_wider(
    names_from=type, 
    values_from=count
)

table4a

a <- table4a %>%
pivot_longer(
    c('1999', '2000'), 
    names_to="year", 
    values_to="cases"
)

table4b

b <- table4b %>%
pivot_longer(
    c('1999', '2000'), 
    names_to="year", 
    values_to="population"
)

merge(a, b, by=c("country", "year"))
left_join(a,b)

table3

table3 %>% 
separate(
    rate,
    into=c("cases", "population")
) # looks for the first non alphanumeric

table3 %>% 
separate(
    rate,
    into=c("cases", "population"),
    sep=c("/", ".")
) # looks for the first non alphanumeric

table3 %>% 
separate(
    rate,
    into=c("cases", "population"),
    sep=c("/", "."),
    convert=TRUE
) # looks for the first non alphanumeric

c <- table3 %>% 
separate(
    year,
    into=c("millenium", "rest"),
    sep = 1
)

c %>%
unite(
    year,
    millenium,
    rest,
    sep=''
)

# missig data
who

who1 <- who %>%
pivot_longer(
    cols = new_sp_m014:newrel_f65,
    names_to = "key",
    values_to = "return", 
    values_drop_na=TRUE
)

who2 <- who1 %>% 
mutate(
    new_key = str_replace(key,  
        "newrel", 
        "new_rel"
    )
) %>% 
separate(
    new_key,
    c("new", "type", "sexage"),
    sep="_"
)

who3 <- who2 %>%
separate(sexage, c("sex", "age"), sep=1)

who4 <- who3 %>% select(-key, -iso2, -iso3) 
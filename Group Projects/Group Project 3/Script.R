# install.packages("tidyverse")
library(tidyverse)

setwd('~/source/repo/R/Group Projects/Group Project 3') # For Jake

getwd() # for error checking

#region Data Parsing

# Loading in data
# Load the data into R from the given csv file. In this step, you must make sure every column of data is appropriately labeled and has the correct data type associated. This must be done every column, even if you do not plan on using a specific column for your subsequent analysis.
# no skips but col names need to be overridden

airlines <- read_csv("airlines.csv")

drivers <- read_csv(
    "drivers.csv",
    col_names =  c(
        "state", 
        "num_drivers_in_fatal_per_billion", 
        "per_speeding",
        "per_alcohol",
        "per_not_distracted",
        "per_not_invlolved_previous",
        "car_insurances_cost",
        "insurance_company_losses_per_driver"
    ),
    skip=1
)

states <- read_csv(
    "states.csv",
    col_names = c(
        "state",
        "pop_18",
        "travel_time",
        "income",
        "area",
        "pop_per_square_mile",
        "error_catch"
    ),
    col_types=cols(
        income=col_number()
    ),
    skip=1
 ) %>%
select(-error_catch)



megastate <- merge(drivers, states, by="state")
colnames(airlines)
colnames(drivers)
colnames(states) 
colnames(megastate)

#endregion

#region Airlines 1 (Moses)

# total_fatalites X total_incidents

A<-read_csv("airlines.csv")

B<-A %>%  mutate(total_fatal_accidents = fatal_accidents_85_99 + fatal_accidents_00_14) %>%  mutate(total_fatalities = fatalities_85_99 + fatalities_00_14)

ggplot(data=B) + geom_count(mapping= aes(x=incidents_85_99, y= fatalities_85_99)) + labs(title = "Fatalities vs. Incidents", subtitle = "The fatalities of airline vs. the number of incidents", x= "Airline incidents", y="Airline fatalities")

G <-  B %>% filter( 0 < incidents_85_99) %>% filter(400 <fatalities_85_99)

ggplot(data=G) + geom_count(mapping= aes(x=incidents_85_99, y= fatalities_85_99)) + labs(title = "Fatalities vs. Incidents", subtitle = "The fatalities of airline vs. the number of incidents", x= "Airline incidents", y="Airline fatalities")
#endregion

#region Airlines 2 (Cam)

# something that changes per year

ggplot(data = airlines) + geom_point(mapping = aes(x = airline, y = incidents_00_14, color = airline)) + labs(x = "Airline", y = "Incidents in Recent Years", title = "Incidents for Various Airlines")


airlinesComparison <- mutate(airlines, difference = incidents_85_99 - incidents_00_14)


ggplot(data = select(airlinesComparison, airline, difference)) + geom_point(mapping = aes(x = airline, y = difference, color = airline)) + labs(y = "Improvement in Incidents", title = "Improvement in Occurences of Incidents") + scale_y_continuous(breaks = seq(-15, 75, 5))

#endregion

#region Drivers 2 (Moses)

# Districted x per_not_distracted

P <- read_csv(
    "drivers.csv",
    col_names =  c(
        "state", 
        "num_drivers_in_fatal_per_billion", 
        "Per_speeding",
        "Per_alcohol",
        "Per_not_distracted",
        "per_not_invlolved_previous",
        "car_insurances_cost",
        "insurance_company_losses_per_driver"
    ),
    skip=1
)

T <- P %>% mutate(Total_distracted = Per_speeding + Per_alcohol, Per_not_distracted)

ggplot(data= T) + geom_point(mapping = aes(x= Per_not_distracted, y= Total_distracted))

R <- T %>% mutate(Most_reckless = Total_distracted/Per_not_distracted)

ggplot(data= R) + geom_point(mapping = aes(x= Most_reckless, y= Total_distracted))

# Made looked at the data and saw an outlier. Then realized that my I was showing the data wrong of what I wanted. After doing the correct mutation, I saw that there was a particular outlier, Wisconsin.

R <- T %>% mutate(Most_reckless = Total_distracted-Per_not_distracted)

# Correct code. 

ggplot(data= R) + geom_point(mapping = aes(x= Most_reckless, y= Total_distracted))

P <-R %>% filter( 0 < Most_reckless)

ggplot(data= P) + geom_point(mapping = aes(x= Most_reckless, y= Total_distracted))

# This shows the top 3

#endregion

#region States 1 (Cam)

# pop_per_square_mile x income

states <- read_csv("states.csv", col_names = c("state", "pop_18", "travel_time", "income", "area", "pop_per_square_mile", "error_catch"), col_types = cols(income = col_number()), skip = 1) %>%
select(-error_catch)



ggplot(data = states) + geom_point(mapping = aes(x = pop_per_square_mile, y = income, color = state)) + labs(x = "Population per Square Mile", y = "Per Capita Income", title = "Population Density v. Per Capita Income")


statesOnly <- filter(states, state != "District of Columbia", state != "Puerto Rico")


ggplot(data = select(statesOnly, state, income, pop_per_square_mile)) + geom_point(mapping = aes(x = pop_per_square_mile, y = income, color = state)) + labs(x = "Population per Square Mile", y = "Per Capita Income", title = "Population Density v. Per Capita Income")

#endregion

#region Color Correction

# uncomment as needed
# install.packages("viridis")
# install.packages("scales")

library(viridis)
library(scales)

theme_set(theme_minimal())

options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")
#endregion

#region Drivers 1 (Jake)

# "num_drivers_in_fatal_per_billion" x "insurance_company_losses_per_driver"

# lets start by taking a look 

ggplot(data = drivers, aes(num_drivers_in_fatal_per_billion, insurance_company_losses_per_driver)) +
geom_point(mapping=aes(color=car_insurances_cost))

# we will trim down a little bit 
drivers_1_a <- drivers %>%
filter(car_insurances_cost > 900)

ggplot(data = drivers_1_a, aes(num_drivers_in_fatal_per_billion, insurance_company_losses_per_driver)) +
geom_point(mapping=aes(color=car_insurances_cost)) +
geom_smooth()

# now lets take the time to find out what states have the highestest > 1250

drivers_1_b <- drivers_1_a %>%
filter(car_insurances_cost > 1250)

ggplot(data = drivers_1_a, aes(num_drivers_in_fatal_per_billion, insurance_company_losses_per_driver)) +
geom_point(mapping=aes(color=car_insurances_cost)) +
geom_smooth() +
geom_text(aes(label = state), data = drivers_1_b, nudge_y = 2, nudge_x = 2)


# makeing her pretty
ggplot(data = drivers_1_a, aes(num_drivers_in_fatal_per_billion, insurance_company_losses_per_driver)) +
geom_point(mapping=aes(color=car_insurances_cost)) +
geom_smooth() + 
geom_label(
    data = drivers_1_b, 
    mapping=aes(label=state),
    alpha = .5,
    nudge_y = 2.5,
    nudge_x = 1.5
) +
labs(
    title = "Drivers in Fatal Accidents (Per Billion) vs Insurances Company Costs",
    subtitle = "colored by Insurance Cost",
    caption = "Label denotes the highest costs",
    x="Drivers in Fatal Accidents (Per Billion)",
    y="Insurances Company Costs",
    color="Insurance Cost"
) +
theme(
    legend.position = "top"
)

# so the question is, why is DC so expensive, I asked my cousin (who lived there for like 6 years) and she told me it boils down to 2 primary reasons
# one the entire "state" (its not a state technically) is just a single city which comes with increased prices and
# two there isn't really that much driving, its a metro (and yes trains this time @moses) city, becuase there are not a lot of native drivers they increase the prices of insurance
# three as a side not DC does sometimes have like horiffic crime rates but they flux so often and there isn't years in the data set so I can't confirm

#endregion

#region States 2 (Jake)

# Travel_time vs income

ggplot(data = states, mapping=aes(travel_time)) +
geom_histogram(aes(color=income))

states_2_a <- states %>%
mutate(average_income=income %/% 1000)

states_2_a %>%
select(average_income)

ggplot(data = states_2_a, mapping=aes(travel_time, average_income)) +
geom_jitter(aes(color=pop_per_square_mile)) +
geom_smooth()

# lets try and find who is making those fat stacks with a 30 min communite
# abd those tgat gave like no travel time
states_2_b <- states_2_a %>%
filter(average_income >= 50)

states_2_b %>%
select(state,average_income)

states_2_c <- states_2_a %>%
filter(travel_time < 18)

states_2_c %>%
select(state, travel_time)

ggplot(data = states_2_a, mapping=aes(travel_time, average_income)) +
geom_jitter(aes(color=pop_per_square_mile)) +
geom_smooth() +
geom_label(
    data = states_2_b, 
    mapping=aes(label=state),
    alpha = .5,
    nudge_y = 2.5,
    nudge_x = -3
) +
geom_label(
    data = states_2_c, 
    mapping=aes(label=state),
    alpha = .5,
    nudge_y = -2.5,
    nudge_x = 2
) +
labs(
    title = "Commute Time vs Average Income",
    subtitle = "colored by population",
    caption = "Labels denote short commute / highest earning potential \n\nSouth Dakota Overlaps Montana",
    x="Commute Time",
    y="Insurances Company Costs",
    color="Average Income"
) +
theme(
    legend.position = "bottom"
)

# so I asked my cousin again and she just said that large money from dc is senetors which is like disgusting
# and I guess if you live in North Dakota, South Dakota, or Montana your live is sad enough without a commute I don't have any cousins who live there


#endregion
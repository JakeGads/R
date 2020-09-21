mw9147

# Carl's Instructions

## Block 3 Group Project Details:

Data Set: For this project, you'll use the `"Airlines"`, `"Drivers"`, and `"States"` datasets found in the folder below.

### Requirements: 

For this project, you will focus on the entire workflow from data in an external csv, through data analysis/transformation, to a nice presentation-quality figure.

For EACH of the THREE datasets, you will need to do the following:

- Load the data into R from the given csv file. In this step, you must make sure every column of data is appropriately labeled and has the correct data type associated. This must be done every column, even if you do not plan on using a specific column for your subsequent analysis.
- Find TWO interesting observations. For each of these observations, you will need to submit code/analysis containing at least:
  - An initial figure, constructed with ggplot and using at least two geometries/facets/coordinates, from the untransformed dataset. In this figure, you should be able to see/describe/analyze some "interesting behavior" that you argue is worth further investigation.
  - An extensive transformation of the dataset, using at least two transformations (at least one of which is not 'select' or 'arrange') to focus on the identified "interesting behavior". This must use "the pipe" method of nesting operations.
  - A follow-up figure, again using at least two relevant geometries/facets/coordinates, that digs further into the "interesting behavior" and sheds some new light that you explain in your analysis. This figure should also make use of additional aesthetics as appropriate and must have meaningful/informative titles, labels, annotations, scales, zooms, etc. (the ideas of chapter 28).

    
Please include discussions of any "dead ends" you might find during your analysis as well as explanations for why you chose the particular transformations and plotting used.

Finally, you should feel free to go "outside" the dataset and use sources like Wikipedia, <b> your friend Steve that knows weird stuff </b>, or generally the whole (school appropriate part) of the internet, if you feel that they help to explain your neat thing.

# Col Names

## Airline

```R
[1] "airline"                "avail_seat_km_per_week" "incidents_85_99"       
[4] "fatal_accidents_85_99"  "fatalities_85_99"       "incidents_00_14"       
[7] "fatal_accidents_00_14"  "fatalities_00_14"
```

## Drivers

### Original

```R
[1] "State"           
[2] "Number of drivers involved in fatal collisions per billion miles"                                      
[3] "Percentage Of Drivers Involved In Fatal Collisions Who Were Speeding"                                  
[4] "Percentage Of Drivers Involved In Fatal Collisions Who Were Alcohol-Impaired"                          
[5] "Percentage Of Drivers Involved In Fatal Collisions Who Were Not Distracted"                            
[6] "Percentage Of Drivers Involved In Fatal Collisions Who Had Not Been Involved In Any Previous Accidents"
[7] "Car Insurance Premiums ($)"                    
[8] "Losses incurred by insurance companies for collisions per insured driver ($)"
```

### Tweaked

```R
[1] "state"                               "num_drivers_in_fatal_per_billion"   
[3] "per_speeding"                        "per_alcohol"                        
[5] "per_not_distracted"                  "per_not_invlolved_previous"         
[7] "car_insurances_cost"                 "insurance_company_losses_per_driver"
```

## States

### Original

```R
[1] "State"
[2] "Population July 2018"
[3] "Mean Travel Time to Work (minutes), workers age 16 years +, 2013-2017"
[4] "Per Capita Income in past 12 months (in 2017 dollars), 2013-17" 
[5] "Land Area in Square Miles 2010"
[6] "Population per Square Mile"
```

### Tweaked
```R
[1] "state"               "pop_18"              "travel_time"        
[4] "income"              "area"                "pop_per_square_mile"
[7] "error_catch" 
```

Note the addition of the 7th header `error_catch` R was really not a fan of the trailing `,` so we make it and then just drop in.

I also noticed a similar column called states between two of the data sets so I called the `merge(by='states')` and it combined them into one dataset
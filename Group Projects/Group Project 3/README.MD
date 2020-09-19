mw9147

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

Note the addition of the 7th header `error_catch` R was really not a fan of the trailing `,` so we make it and then just drop in
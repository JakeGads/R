words = ''' 
    popasian <int>,
    popother <int>, 
    percwhite <dbl>, 
    percblack <dbl>, 
    percamerindan <dbl>, 
    percasian <dbl>, 
    percother <dbl>, 
    popadults <int>, 
    perchsd <dbl>, 
    percollege <dbl>, 
    percprof <dbl>, 
    poppovertyknown <int>, 
    percpovertyknown <dbl>, 
    percbelowpoverty <dbl>, 
    percchildbelowpovert <dbl>, 
    percadultpoverty <dbl>, 
    percelderlypoverty <dbl>, 
    inmetro <int>, 
    category <chr>,
    PID <int>,
    county <chr>,
    state <chr>,  
    area <dbl>,    
    poptotal <int>,      
    popdensity <dbl>,    
    popwhite <int>,    
    popblack <int>, 
    popamerindian  <int>
'''
words = words.split(',')
words.sort()

for i in words:
    i = i.replace('\n', '').replace('\t', '').replace(' ', '')
    print(i)
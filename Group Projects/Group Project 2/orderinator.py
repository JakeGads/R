words = ''' 
PID<int>
county<chr>
popother<int>
state<chr>
category<chr>
inmetro<int>
percadultpoverty<dbl>
percamerindan<dbl>
percasian<dbl>
percbelowpoverty<dbl>
percblack<dbl>
percchildbelowpovert<dbl>
percelderlypoverty<dbl>
perchsd<dbl>
percollege<dbl>
percother<dbl>
percpovertyknown<dbl>
percprof<dbl>
percwhite<dbl>
popadults<int>
popamerindian<int>
popasian<int>
poppovertyknown<int>
area<dbl>
popblack<int>
poptotal<int>
popwhite<int>
popdensity<dbl>
'''
words = words.split('>')
words.sort()

for i in words:
    i = i.replace('\n', '').replace('\t', '').replace(' ', '').lower()
    print(i)
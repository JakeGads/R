# Jake Gadaleta | Homework 2

## 5.2.4

### Find all flights that

All answers also available in [Script.R](Script.R)

1. Had an arrival delay of two or more hours

```R
flights %>% 
filter(arr_delay > (60 * 2))
```

2. Flew to Houston (IAH or HOU)

```R
flights %>% 
filter(dest == 'IAH' | dest == 'HOU')
```

3. Were operated by United, American, or Delta

```R
flights %>% 
filter(carrier == 'UA' |carrier == 'AA' | carrier == 'DL')
```
4. Departed in summer (July, August, and September)

```R
flights %>% 
filter(month >= 7 & month <= 9)
```

5. Arrived more than two hours late, but didn’t leave late

```
flights %>% 
filter( arr_delay > (60 * 2) & dep_delay <= 0)
```

6. Were delayed by at least an hour, but made up over 30 minutes in flight

```dotnetcli
TODO @CARL is this delayed > 1 hour at dep and then arrived dep - arr > 30 
```

7. Departed between midnight and 6am (inclusive)

```r
flights %>% filter(dep_time < (6 * 60))
```

## 5.4.1
### 2. What happens if you include the name of a variable multiple times in a select() call?
    The second call is dropped
### 4. Does the result of running the following code surprise you? How do the select helpers deal with cases by default? How can you change that default?
```r
select(flights, contains("TIME"))
```

## 5.5.2

### 2. Compare air_time with arr_time - dep_time. What do you expect to see? What do you see? What do you need to do to fix it?

### 3. Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?

## 5.6.7

### 5. Which carrier has the worst delays?

## 5.7.1

### 3. What time of day should you fly if you want to avoid delays as much as possible?

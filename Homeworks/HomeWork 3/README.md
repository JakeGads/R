#
# Section 28.2.1 

## 3. Take an exploratory graphic that you’ve created in the last month, and add informative titles to make it easier for others to understand.

#
# Section 28.3.1 

## 3. How do labels with geom_text() interact with faceting? How can you add a label to a single facet? How can you put a different label in each facet? (Hint: think about the underlying data.)

#
# Section 28.4.4 

## 3. Change the display of the presidential terms by:

```R
presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, colour = party)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    scale_colour_manual(values = c(Republican = "red", Democratic = "blue")
```

### 1. Combining the two variants shown above.

### 2. Improving the display of the y axis.

### 3 Labelling each term with the name of the president.

#
# Section 11.2.2: 

## 2. Apart from file, skip, and comment, what other arguments do read_csv() and read_tsv() have in common?

#
# Section 11.3.5: 

## 2. What happens if you try and set `decimal_mark` and `grouping_mark` to the same character? What happens to the default value of `grouping_mark` when you set `decimal_mark` to “,”? What happens to the default value of `decimal_mark` when you set the `grouping_mark` to “.”?

## 7. Generate the correct format string to parse each of the following dates and times:
 
```R 
d1 <- "January 1, 2010"

d2 <- "2015-Mar-07"

d3 <- "06-Jun-2017"

d4 <- c("August 19 (2015)", "July 1 (2015)")

d5 <- "12/30/14" # Dec 30, 2014

```

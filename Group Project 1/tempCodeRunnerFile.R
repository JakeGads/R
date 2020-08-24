# 6
head + 
geom_bar(mapping=aes(x=status, fill=status)) + 
facet_wrap(~year) +
ggtitle("Status per year")

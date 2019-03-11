
library(ggplot2)

p = ggplot(gradData[gradData$Major_category == "Humanities & Liberal Arts",], aes(x=Median, y=Unemployment_rate))
p + geom_point(aes(color = factor(Major_category)))
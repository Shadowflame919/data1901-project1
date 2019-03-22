gradData = read.csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/college-majors/recent-grads.csv")
library(ggplot2)
library(plotly)

# Exclude Food Science, as it has missing data.
# total_grads = sum(gradTotalData$Total)
# Order our data by the total number of graduates
gradTotalData = gradData[!(gradData$Major=="FOOD SCIENCE") & !(gradData$Major=="MILITARY TECHNOLOGIES") ,]

gradTotalData = gradTotalData[order(gradTotalData$Total),]

bottom_ten_by_total = head(gradTotalData, 10)
top_ten_by_total = tail(gradTotalData, 10)

gradTotal_topbottom = rbind(top_ten_by_total, bottom_ten_by_total)




ggplotly(ggplot(gradTotal_topbottom, aes(x=Median, fill=Major, y=Total)) + geom_point() + theme(legend.position = "none") +
           xlab("Median Income") + ylab("Popularity") + labs(title="Popularity vs Median Income"))


ggplotly(ggplot(gradTotalData, aes(x=Employed/Total, fill=Major_category)) + geom_histogram(bins = 15) + theme(legend.position = "none") +
           xlab("Employment Rate") + ylab("Density") + labs(title="Popularity vs Median Income"))


ggplotly(ggplot(gradTotalData, aes(x=Median, fill=Major_category)) + geom_histogram(bins = 15) + theme(legend.position = "none") +
           xlab("Median Income") + ylab("Density") + labs(title="Popularity vs Median Income"))


ggscatterhist(
  gradTotal_topbottom, x = "Median", y = "Total",
  color = "Major", size = 3, alpha = 0.6,
  palette = c("#00AFBB", "#E7B800", "#FC4E07"),
  margin.params = list(fill = "Major", color = "black", size = 0.2)
)


employmentMean = mean((gradTotalData$Employed/gradTotalData$Total))
employmentSd = sd((gradTotalData$Employed/gradTotalData$Total))
# Get all employment rates of engineering, then sort them in increasing order, and take the first element to get the lowest.
lowestEmployment = sort((gradTotalData$Employed/gradTotalData$Total)[gradTotalData$Major_category=="Engineering"], decreasing=FALSE)[1]
distance = ((employmentMean - lowestEmployment)/employmentSd)
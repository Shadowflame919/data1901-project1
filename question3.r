gradData = read.csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/college-majors/recent-grads.csv")
library(ggplot2)
library(plotly)

# Exclude Food Science, as it has missing data.
gradTotalData = gradData[!(gradData$Major=="FOOD SCIENCE") & !(gradData$Major=="MILITARY TECHNOLOGIES") ,]

# Order our data by the total number of graduates
gradTotalData = gradTotalData[order(gradTotalData$Total),]

total_grads = sum(gradTotalData$Total)

bottom_ten_by_total = head(gradTotalData, 10)
top_ten_by_total = tail(gradTotalData, 10)

gradTotal_topbottom = rbind(top_ten_by_total, bottom_ten_by_total)

plotAllMedianVsPop = ggplot(gradTotalData, aes(x=Median, y=Total))
plotAllMedianVsPop + geom_point()

plotTopMedianVsPop = ggplot(gradTotal_topbottom, aes(x=Median, y=Total, color=Major))
plotTopMedianVsPop + geom_point()

plotAllEmployedVsPop = ggplot(gradTotalData, aes(x=Employed/Total, y=Total))
plotAllEmployedVsPop + geom_point()

plotTopEmployedVsPop = ggplot(gradTotal_topbottom, aes(x=Employed/Total, y=Total, color=Major))
plotTopEmployedVsPop + geom_point()






#PROBLEMS:
#"Graduates" isn't necessarily a metric of popularity. 
# i.e. 'Psychology' could be considered an easier course and therefore recieve more graduates
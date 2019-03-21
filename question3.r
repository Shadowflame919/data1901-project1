gradData = read.csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/college-majors/recent-grads.csv")
library(ggplot2)
library(plotly)

# Exclude Food Science, as it has missing data.
gradTotalData = gradData[!(gradData$Major=="FOOD SCIENCE") & !(gradData$Major=="MILITARY TECHNOLOGIES") ,]

# Order our data by the total number of graduates
gradTotalData = gradTotalData[order(gradTotalData$Total),]

total_grads = sum(gradTotalData$Total)

bottom_ten_majors_by_total = data.frame("Major" = gradTotalData$Major[1:10])
top_ten_majors_by_total = data.frame("Major" = gradTotalData$Major[(length(gradTotalData$Major) - 9):length(gradTotalData$Major)])
bottom_ten_totals = data.frame("Total" = gradTotalData$Total[1:10])
top_ten_totals = data.frame("Total" =  gradTotalData$Total[(length(gradTotalData$Median) - 9):length(gradTotalData$Median)])
bottom_ten_incomes = data.frame("Median" = gradTotalData$Median[1:10])
top_ten_incomes = data.frame("Median" =  gradTotalData$Median[(length(gradTotalData$Median) - 9):length(gradTotalData$Median)])
bottom_ten_employed = data.frame("Employed" = gradTotalData$Employed[1:10])
top_ten_employed = data.frame("Employed" =  gradTotalData$Employed[(length(gradTotalData$Median) - 9):length(gradTotalData$Median)])


combined_employed = rbind(top_ten_employed, bottom_ten_employed, stringsAsFactors=FALSE)
combined_incomes_by_total = rbind(top_ten_incomes, bottom_ten_incomes, stringsAsFactors=FALSE)
combined_majors_by_total = rbind(top_ten_majors_by_total, bottom_ten_majors_by_total, stringsAsFactors=FALSE)
combined_totals = rbind(top_ten_totals, bottom_ten_totals, stringsAsFactors=FALSE)
gradMajorTotalPairs = data.frame(combined_majors_by_total, combined_totals, combined_incomes_by_total, combined_employed)

plotAllMedianVsPop = ggplot(gradTotalData, aes(x=Median, y=Total))
plotAllMedianVsPop + geom_point()

plotTopMedianVsPop = ggplot(gradMajorTotalPairs, aes(x=Median, y=Total, color=Major))
plotTopMedianVsPop + geom_point()

plotAllEmployedVsPop = ggplot(gradTotalData, aes(x=Employed/Total, y=Total))
plotAllEmployedVsPop + geom_point()

plotTopEmployedVsPop = ggplot(gradMajorTotalPairs, aes(x=Employed/Total, y=Total, color=Major))
plotTopEmployedVsPop + geom_point()






#PROBLEMS:
#"Graduates" isn't necessarily a metric of popularity. 
# i.e. 'Psychology' could be considered an easier course and therefore recieve more graduates
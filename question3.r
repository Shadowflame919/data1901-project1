gradData = read.csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/college-majors/recent-grads.csv")
library(ggplot2)

# Exclude Food Science, as it has missing data.
gradTotalData = gradData[!(gradData$Major=="FOOD SCIENCE"),]

# Order our data by the total number of graduates
gradTotalData = gradTotalData[order(gradTotalData$Total),]

total_grads = sum(gradTotalData$Total)

bottom_ten_majors_by_total = data.frame("Major" = gradTotalData$Major[1:10])


top_ten_majors_by_total = data.frame("Major" = gradTotalData$Major[(length(gradTotalData$Major) - 9):length(gradTotalData$Major)])

combined_majors_by_total = rbind(top_ten_majors_by_total, bottom_ten_majors_by_total, by="Major")

major_popularity_data = data.frame(top_ten_majors_by_total, bottom_ten_majors_by_total)
#plot = ggplot(gradTotalData, aes(x=Median, y=Unemployment_rate, color=Major))
#plot + geom_point()









#PROBLEMS:
#"Graduates" isn't necessarily a metric of popularity. 
# i.e. 'Psychology' could be considered an easier course and therefore recieve more graduates
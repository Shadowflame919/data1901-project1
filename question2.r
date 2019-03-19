
# Remove some majors which have missing data for employment
# Military services has missing data for employment?

## Part 1
# Plot unemployment rate as boxplot
hline <- function(y = 0) {
  list(
    type = "line", 
    x0 = 0, 
    x1 = 1, 
    xref = "paper",
    y0 = y, 
    y1 = y, 
    line = list(color = "red", width=1)
  )
}
plot_ly(gradData, y=~Unemployment_rate*100, color=~Major_category, type="box") %>% 
  layout(    
    yaxis = list(title = "Unemploment Rate (%)"),
    xaxis = list(showticklabels = FALSE),
    title = "Unemployment Rate per Major Category"
    #shapes = list(hline(36))
  )
# There is a large variety of unemployment 
# While Engineering dominates in terms of income, Unemployment shows a different story, with 4 seperate major categories beating it...
# Education with a median of 4.88%


## Part 2
# Plot % of jobs requiring degree as boxplot
gradData2 = gradData

jobRatio = 100*gradData$College_jobs / (gradData$Non_college_jobs + gradData$College_jobs)
gradData2["Job_ratio"] = jobRatio

plot_ly(
  gradData2,
  y = ~jobRatio,
  color=~Major_category,
  type = "box"
)
# One would expect there to be some correlation between employment and college degree requirements, 
# yet this graph seems to reveal majors from both sides. 
# Education has very low unemployment, but also requires college degree
# Other jobs however, like IACS, have low unemployment rate and low requirements for college degree
# Can be further analysed when we compare both side by side


## Part 3
# Plot unemployment rate VS chance of requiring college degree
# Should make plot nice, and have colours representing major category
plot(jobRatio, gradData$Unemployment_rate)
# Scatter plot reveals a correlation between jobs that require a college degree, and their chances of leaving people unemployed.
# This is perhaps because jobs that require college degrees have less supply, and thus are unlikely to leave potential employees unemployed.
# Conclusion: Having a college degree will make finding a job easier :O

# Attempts at making a nice scatter plot
line.fmt = list(dash="solid", width = 1.5, color=NULL)
ks1 = ksmooth(gradData2$Unemployment_rate, gradData2$Job_ratio, "normal", 20, x.points=gradData2$Unemployment_rate)
p = add_lines(p, x=ks1$x, y=ks1$y)

p = plot_ly(
  gradData2, 
  x=~Job_ratio, 
  y=~Unemployment_rate
  #color=~Major_category
)
p = add_lines(p, y=~fitted(loess(gradData2$Unemployment_rate ~ gradData2$Job_ratio)))
print(p)



## Part 4
# Lastly plot some of the extreme individual majors (most/least unemployment/jobRatio) 
# Probably though double bar plots with seperate scales for employability and jobRatio
# Compare these majors and determine some good picks





# NOT INCLUDED
jobComparison = data.frame(gradData$College_jobs, gradData$Non_college_jobs)
jobComparison = t(jobComparison) # Rotate data matrix
barplot(jobComparison, beside=T)




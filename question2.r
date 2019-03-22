#
# Begin by stating importance of considering further variables, as they are factors that are 
# often overlooked and should not be ignored. Teach the ppl a lesson :)
#
# The reason for this data is to give insight through comparing various factors in major degrees.
# However, this should not be taken at face value, and we use this data to reveal that just by looking 
# at one variable, such as income, as many often do, you are often leaving out key factors that should
# influence your choices.


# Clean data of majors which are missing unemployment data
gradData = gradData[!(gradData$Major=="MILITARY TECHNOLOGIES"),]

# Define a function to return nice looking horizontal lines
hline = function(y) {
  list(
    type = "line", 
    x0 = 0, 
    x1 = 1, 
    xref = "paper",
    y0 = y, 
    y1 = y, 
    line = list(color = "red", width=0.5)
  )
}

## Part 1: Unemployment Rate between major categories

# Calculate median unemployment to display on graph
medianUnemployment = 100*median(gradData$Unemployment_rate)

# Plot unemployment rate as boxplot
plot_ly(
  gradData, 
  y=~Unemployment_rate*100, 
  color=~Major_category, 
  type="box"
) %>% layout(    
  yaxis = list(title = "Unemploment Rate (%)"),
  xaxis = list(showticklabels = FALSE),
  title = "Unemployment Rate per Major Category",
  shapes = hline(medianUnemployment)
)

# There is a large variety of unemployment, something worth considering when selecting majors.
# Law degrees typically have income skewed relatively high, yet you will often have trouble finding employment.
# While Engineering dominates in terms of income, Unemployment shows a different story, 
# with 4 seperate major categories beating it...
# Education with a median of 4.88%


## Part 2: Degree requirement betwen major categories
# Plot % of jobs requiring degree as boxplot

# Create a new field which stores the percentage of requiring the college job
gradData["Job_ratio"] = 100*gradData$College_jobs / (gradData$Non_college_jobs + gradData$College_jobs)

plot_ly(
  gradData,
  y = ~Job_ratio,
  color=~Major_category,
  type = "box"
) %>% layout(
  title = "Requirement of College Degree per Major Category",
  yaxis = list(title = "Chance of Requiring Degree (%)"),
  xaxis = list(showticklabels = FALSE),
  shapes = hline(median(gradData$Job_ratio))
)
# One could argue that this graph essentially rates the usefulness of a degree.
# One would expect there to be positive correlation between employment and college degree requirements, 
# yet this graph seems to reveal majors from both sides. 
# Education has very low unemployment, but also requires college degree
# Other jobs however, like IACS, have low unemployment rate and low requirements for college degree
# Does this suggest that the degree is not very useful.
# Can be further analysed when we compare both side by side


## Part 3
# Plot unemployment rate VS chance of requiring college degree
# Should make plot nice, and have colours representing major category
plot(jobRatio, gradData$Unemployment_rate)
# Scatter plot reveals a correlation between jobs that require a college degree, and their chances of leaving people unemployed.
# This is perhaps because jobs that require college degrees have less supply, and thus are unlikely to leave potential employees unemployed.
# Conclusion: Having a college degree will make finding a job easier :O

# Attempts at making a nice scatter plot
plot_ly(
  gradData, 
  type='scatter',
  x=~Job_ratio, 
  y=~Unemployment_rate * 100
  #color=~Major_category
) %>% add_lines(
  y = ~fitted(lm(gradData$Unemployment_rate*100 ~ gradData$Job_ratio)),
  line = list(color = '#07A4B5'),
  name = "Linear Trend Line", showlegend = FALSE
) %>% layout(
  title = "Unemployment Rate VS Requirement of Degree",
  yaxis = list(title = "Unemployment Rate (%)"),
  xaxis = list(title = "Chance of Requiring Degree (%)")
)


## Part 4
# Lastly plot some of the extreme individual majors (most/least unemployment/jobRatio) 
# Probably though double bar plots with seperate scales for employability and jobRatio
# Compare these majors and determine some good picks
# Selects top 10
top10 = head(gradData[order(-gradData$Median),], 10)

plot_ly(
  top10, 
  type='bar',
  y=~Unemployment_rate * 100,
  #x=~Major,
  name = 'Unemployment',
  opacity = 0.4
  #color=~Major_category
) %>% add_trace(
  y = ~Job_ratio,
  type='bar',
  #x=~Major,
  yaxis = 'y2',
  name = 'Job Ratio',
  opacity = 0.4
) %>% layout(
  autosize = T,
  title = "Unemployment Rate VS Requirement of Degree",
  yaxis = list(title = "Unemployment Rate (%)", side = 'left'),
  yaxis2 = list(title = "Job Ratio", overlaying = 'y', side = 'right'),
  barmode = 'group'
)







plot_ly(
  top10, 
  type='bar',
  y=~Unemployment_rate * 100,
  #x=~Major,
  name = 'Unemployment',
  opacity = 0.4
  #color=~Major_category
) %>% add_trace(
  y = ~Job_ratio,
  type='bar',
  #x=~Major,
  yaxis = 'y2',
  name = 'Job Ratio',
  opacity = 0.4
) %>% layout(
  autosize = T,
  title = "Unemployment Rate VS Requirement of Degree",
  yaxis = list(title = "Unemployment Rate (%)", side = 'left'),
  yaxis2 = list(title = "Job Ratio", overlaying = 'y', side = 'right'),
  barmode = 'group'
)


# NOT INCLUDED
jobComparison = data.frame(gradData$College_jobs, gradData$Non_college_jobs)
jobComparison = t(jobComparison) # Rotate data matrix
barplot(jobComparison, beside=T)




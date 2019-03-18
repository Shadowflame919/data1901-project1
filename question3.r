# 
# Write a script that searches for simpsons paradox
# 
# Compare 
#


#plot = ggplot(majors, aes(x=Median, y=Unemployment_rate))

eng = majors[majors$Major_category=="Engineering",]
art = majors[majors$Major_category=="Industrial Arts & Consumer Services",]

com = majors[majors$Major_category=="Engineering" | majors$Major_category=="Humanities & Liberal Arts",]

plot = ggplot(com, aes(x=Median, y=Unemployment_rate, color=Major_category))
plot + geom_point()
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- subset(NEI, fips=="24510")

library(plyr)
library(ggplot2)

Balt_OnRoad <- subset(Baltimore, type=="ON-ROAD")
data_graph5 <- ddply(Balt_OnRoad, c("year"), summarize, total=sum(Emissions))
qplot(year, total, data=data_graph5) + geom_line() + ggtitle("Total Emissions from vehicles, Baltimore 99-08, in kTons")
dev.copy(png, file="Plot5.png")
dev.off()




NEI <- readRDS("summarySCC_PM25.rds")
library(plyr)
library(ggplot2)

Baltimore <- subset(NEI, fips=="24510")
data_graph3 <- ddply(Baltimore, c("year","type"), summarize, 
                     total=sum(Emissions))

g <- ggplot(data_graph3, aes(year, total, color=type))
g+ggtitle("Total Emissions Baltimore 99-08")+geom_line()

dev.copy(png, file="Plot3.png")
dev.off()


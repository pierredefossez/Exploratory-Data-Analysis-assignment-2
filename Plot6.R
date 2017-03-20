NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)


LA_Balt <- subset(NEI, fips %in% c("24510", "06037") & type=="ON-ROAD")

data_graph6 <- ddply(LA_Balt, c("year","fips"), summarize, 
                     total=sum(Emissions))

data_graph6$fips <- gsub("06037", "LA", data_graph6$fips)
data_graph6$fips <-gsub("24510", "Baltimore", data_graph6$fips)

g <- ggplot(data_graph6, aes(year, total, color=fips))
g+ggtitle("Vehicle Emissions LA/Baltimore 99-08")+geom_line()

dev.copy(png, file="Plot6.png")
dev.off()


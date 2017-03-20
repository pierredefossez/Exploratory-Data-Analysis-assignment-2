NEI <- readRDS("summarySCC_PM25.rds")

library(dplyr)


Baltimore <- subset(NEI, fips=="24510")
outputB <- Baltimore%>% group_by(year) %>% summarise(Total_Emissions=sum(Emissions))

plot2 <- barplot(outputB$Total_Emissions, names.arg=outputB$year, main="Total Emissions Baltimore", ylab="Tons of PM25", xlab="Year", col="blue")
dev.copy(png, file=("Plot2.png"))
dev.off()


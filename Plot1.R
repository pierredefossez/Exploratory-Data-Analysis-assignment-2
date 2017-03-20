NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

output <- NEI%>% group_by(year) %>% summarise(Total_Emissions=sum(Emissions))

plot1 <- barplot(output$Total_Emissions, names.arg=output$year, main="Total Emissions", ylab="Tons of PM25", xlab="Year", col="blue")

dev.copy(png, file=("Plot1.png"))
dev.off()

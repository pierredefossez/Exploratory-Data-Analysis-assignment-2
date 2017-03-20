NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)

coal_subset <- SCC[grep("Coal", SCC$SCC.Level.Three), ]
coal_index <- droplevels(coal_subset$SCC)
US_Coal <- NEI[NEI$SCC %in% coal_index,]

data_graph4 <- ddply(US_Coal, c("year"), summarize, total=sum(Emissions))
plot4 <- barplot(data_graph4$total, names.arg=data_graph4$year, main="Total US Emissions from Coal", ylab="Tons of PM25", xlab="Year", col="blue")

dev.copy(png, file="Plot4.png")
dev.off()


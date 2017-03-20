## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

output <- NEI%>% group_by(year) %>% summarise(Total_Emissions=sum(Emissions))

plot1 <- barplot(output$Total_Emissions, names.arg=output$year, main="Total Emissions", ylab="Tons of PM25", xlab="Year", col="blue")

dev.copy(png, file=("Plot1.png"))
dev.off()

Baltimore <- subset(NEI, fips=="24510")
outputB <- Baltimore%>% group_by(year) %>% summarise(Total_Emissions=sum(Emissions))

plot2 <- barplot(outputB$Total_Emissions, names.arg=outputB$year, main="Total Emissions Baltimore", ylab="Tons of PM25", xlab="Year", col="blue")
dev.copy(png, file=("Plot2.png"))
dev.off()

outputC <- Baltimore%>% group_by(type)

##Graph3
library(plyr)
library(ggplot2)
data_graph3 <- ddply(Baltimore, c("year","type"), summarize, 
                     total=sum(Emissions))

g <- ggplot(data_graph3, aes(year, total, color=type))
g+ggtitle("Total Emissions Baltimore 99-08")+geom_line()

dev.copy(png, file="Plot3.png")
dev.off()

#Graph4
library(plyr)

coal_subset <- SCC[grep("Coal", SCC$SCC.Level.Three), ]
coal_index <- droplevels(coal_subset$SCC)
US_Coal <- NEI[NEI$SCC %in% coal_index,]

data_graph4 <- ddply(US_Coal, c("year"), summarize, total=sum(Emissions))
plot4 <- barplot(data_graph4$total, names.arg=data_graph4$year, main="Total US Emissions from Coal", ylab="Tons of PM25", xlab="Year", col="blue")

dev.copy(png, file="Plot4.png")
dev.off()

#Graph5
library(plyr)
library(ggplot2)

Balt_OnRoad <- subset(Baltimore, type=="ON-ROAD")
data_graph5 <- ddply(Balt_OnRoad, c("year"), summarize, total=sum(Emissions))
qplot(year, total, data=data_graph5) + geom_line() + ggtitle("Total Emissions from vehicles, Baltimore 99-08, in kTons")
dev.copy(png, file="Plot5.png")
dev.off()

#Graph6
LA_Balt <- subset(NEI, fips %in% c("24510", "06037") & type=="ON-ROAD")

data_graph6 <- ddply(LA_Balt, c("year","fips"), summarize, 
                     total=sum(Emissions))

data_graph6$fips <- gsub("06037", "LA", data_graph6$fips)
data_graph6$fips <-gsub("24510", "Baltimore", data_graph6$fips)

g <- ggplot(data_graph6, aes(year, total, color=fips))
g+ggtitle("Vehicle Emissions LA/Baltimore 99-08")+geom_line()

dev.copy(png, file="Plot6.png")
dev.off()


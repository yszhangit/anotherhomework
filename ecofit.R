library(tidyr)
library(dplyr)
library(plotly)

data <- read.csv('data.csv', as.is=T)
# remove unwanted columns
data <- data[,-c(2,3,4)]
# clean up column names
colnames(data) <- c("country",seq(from=1995, to=2015))
# reshape DF and convert data type
data <- gather(data=data, year, value, -country)
data$value <- as.numeric(data$value)
# top 10 countries as of 2015
top10countries <- data %>% filter(year==2015) %>% arrange(value) %>% top_n(10) %>% select(country)
# filter top country history
top10 <- data %>% filter(country %in% top10countries$country)
# plot
plot_ly(top10, x=~year, y=~value) %>% add_lines(color = ~country, alpha = 0.5)
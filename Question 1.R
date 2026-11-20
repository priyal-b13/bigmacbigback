# Big Mac prices in US dollars across countries, most recent year
library(dplyr)
library(ggplot2)

bm <- read.csv("big-mac-full-index.csv")
bm$date <- as.Date(bm$date)

# Most recent year in the data (may contain more than one survey round)
latest_year <- max(format(bm$date, "%Y"))
latest <- bm %>% filter(format(date, "%Y") == latest_year)

# If a year has two rounds (Jan and Jul), keep each country's latest observation
latest <- latest %>%
  group_by(name) %>%
  filter(date == max(date)) %>%
  ungroup()

# Summary statistics
summary(latest$dollar_price)
sd(latest$dollar_price)

# Cheapest and most expensive
latest %>% arrange(dollar_price) %>% select(name, dollar_price) %>% head(5)
latest %>% arrange(desc(dollar_price)) %>% select(name, dollar_price) %>% head(5)

# US price for reference
us_price <- latest$dollar_price[latest$iso_a3 == "USA"]

# Histogram
ggplot(latest, aes(x = dollar_price)) +
  geom_histogram(binwidth = 0.5, boundary = 0, fill = "steelblue", colour = "white") +
  geom_vline(xintercept = us_price, linetype = "dashed", colour = "red") +
  annotate("text", x = us_price, y = Inf, label = "United States",
           vjust = 1.5, hjust = -0.1, colour = "red") +
  labs(title = paste("Big Mac prices in US dollars,", latest_year),
       subtitle = paste(nrow(latest), "countries"),
       x = "Price (USD)", y = "Number of countries") +
  theme_minimal()

ggsave("big_mac_histogram.png", width = 7, height = 4.5, dpi = 150)

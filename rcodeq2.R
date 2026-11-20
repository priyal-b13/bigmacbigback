library(readr)
library(dplyr)
library(ggplot2)

big_mac <- readr::read_csv(
  "C:/Users/Piyu/OneDrive - Imperial College London/Documents/$ ~ PRIYAL ~ $/UNI/year 3/big data/tutorials/tutorial 6 BIG MAC/bigmacbigback/big-mac-full-index.csv"
)

# Check the column names first
names(big_mac)

uk_prices <- big_mac %>%
  filter(iso_a3 == "GBR") %>%
  mutate(date = as.Date(date)) %>%
  arrange(date)

ggplot(uk_prices, aes(x = date, y = dollar_price)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Big Mac price in the UK over time",
    x = "Date",
    y = "Price (US dollars)"
  ) +
  theme_minimal()
library(tidytuesdayR)
library(tidyverse)
library(janitor) # new library--what stuff does this do?
install.packages("leaflet") # This library is really cool! It lets you add data onto maps! 
library(leaflet)
library(maps)

# Manually read in data
transit_cost <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-05/transit_cost.csv')

# get the data from the package
tuesdata <- tidytuesdayR::tt_load(2021, week = 2)
transit_cost <- tuesdata$transit_cost

# Script for cleaning the data from tidytuesday github
# unclear how this is different from the data manually read in??
raw_df <- transit_cost %>% 
  janitor::clean_names() %>% 
  filter(real_cost != "MAX")

# Filter the data just for the US projects
raw_US <- raw_df %>% 
  filter(country == 'US') %>%
  arrange(desc(cost_km_millions))



# 3 Goals for plots
# 1 plot pins on a map
# Average project cost per KM by City
# Project Timelines

# Total Costs per city bar chart
raw_US %>% group_by(city) %>%
  mutate(total_length = sum(length), total_cost=sum(cost), total_city_cost=total_length/total_cost)



# Make a map of the US and color it
mapStates = map("state", fill = TRUE, plot = TRUE)
leaflet(data = mapStates) %>% addTiles() %>%
  addPolygons(fillColor = topo.colors(5, alpha = NULL), stroke = FALSE)

m = leaflet(df) %>% addTiles()
# m  %>% addCircleMarkers(radius = ~size, color = ~color, fill = FALSE)
m %>% addCircleMarkers(radius = runif(100, 4, 10), color = c('red'))



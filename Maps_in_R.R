# Работа с картами:



# Загрузим необходимые библиотеки:
library(tidyverse)
library(ggplot2)

# create data for world coordinates using 
# map_data() function
world_coordinates <- map_data("world")

# create world map using ggplot() function
ggplot() +
  
  # geom_map() function takes world coordinates 
  # as input to plot world map
  geom_map(
    data = world_coordinates, map = world_coordinates,
    aes(long, lat, map_id = region)
  )


library(sf)
  
# Import a geojson or shapefile
map <- read_sf("https://raw.githubusercontent.com/R-CoderDotCom/data/main/shapefile_spain/spain.geojson")
  
ggplot(map) +
  geom_sf(color = "white", aes(fill = unemp_rate)) +
  theme(legend.position = "none")
  
  
  
library(plotly)
  
# Import a geojson or shapefile
map <- read_sf("https://raw.githubusercontent.com/R-CoderDotCom/data/main/shapefile_spain/spain.geojson")
  
p <- ggplot(map) +
  geom_sf(color = "white", aes(fill = unemp_rate)) +
  theme(legend.position = "none")
  
# Make the map interactive
ggplotly(p)
  
  
  

#####CREATE GALICIAN MAPS#######

if (!require("pacman")) install.packages("pacman")
pacman::p_load(
  sf, # vector data operations
  dplyr, # data wrangling
  data.table, # data wrangling
  ggplot2, # for map creation
  tmap # for map creation
)

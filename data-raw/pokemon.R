## code to prepare `pokemon` dataset goes here
# data-raw/pokemon.R
pokemon <- read.csv("data-raw/pokemon.csv")

usethis::use_data(pokemon, overwrite = TRUE)

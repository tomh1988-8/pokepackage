########################## FUNCTION 1: pokehack ##########################
#' Boost Pokémon Stats
#'
#' This function takes a Pokémon's name from the "name" column of a data frame
#' and increases the specified attributes (defense, sp_attack, sp_defense, speed)
#' by 10%.
#'
#' @param pokemon_name Character. Name of the Pokémon to boost.
#' @param data A data frame containing Pokémon data with columns:
#'   "name", "defense", "sp_attack", "sp_defense", and "speed".
#'
#' @return A modified data frame with the updated stats for the specified Pokémon.
#' @examples
#' pokedata <- pokehack("Bulbasaur", pokedata)
pokehack <- function(pokemon_name, data) {
  # Validate input: Check if the Pokémon name exists
  if (!pokemon_name %in% data$name) {
    stop("The specified Pokémon name does not exist in the dataset.")
  }
  
  # Update the stats using tidyverse functions
  data <- data %>%
    dplyr::mutate(
      defense = ifelse(name == pokemon_name, defense * 1.1, defense),
      sp_attack = ifelse(name == pokemon_name, sp_attack * 1.1, sp_attack),
      sp_defense = ifelse(name == pokemon_name, sp_defense * 1.1, sp_defense),
      speed = ifelse(name == pokemon_name, speed * 1.1, speed)
    )
  
  return(data)
}
# All clear!
rm(list = ls())

# Libraries
library(tidyverse)



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



########################## FUNCTION 2: poketrain ##########################
#' Train Pokémon for a Battle
#'
#' This function allows a user to select 6 Pokémon for training before a battle.
#' The selected Pokémon lose 10% of their body weight (`weight_kg`) and gain 5% experience (`experience_growth`).
#'
#' @param selected_pokemon Character vector. Names of the 6 Pokémon to train.
#' @param data A data frame containing Pokémon data with at least the following columns:
#'   "name", "weight_kg", and "experience_growth".
#'
#' @return A modified data frame with updated `weight_kg` and `experience_growth` for the selected Pokémon.
#' @examples
#' trained_pokedata <- poketrain(
#'   selected_pokemon = c("Bulbasaur", "Charmander", "Squirtle", "Pikachu", "Jigglypuff", "Meowth"),
#'   data = pokedata
#' )
poketrain <- function(selected_pokemon, data) {
  # Validate input: Ensure exactly 6 Pokémon are selected
  if (length(selected_pokemon) != 6) {
    stop("You must select exactly 6 Pokémon for training.")
  }

  # Validate input: Ensure all selected Pokémon exist in the dataset
  missing_pokemon <- setdiff(selected_pokemon, data$name)
  if (length(missing_pokemon) > 0) {
    stop(paste("The following Pokémon are not in the dataset:", paste(missing_pokemon, collapse = ", ")))
  }

  # Update the stats for the selected Pokémon
  data <- data %>%
    dplyr::mutate(
      weight_kg = ifelse(name %in% selected_pokemon, weight_kg * 0.9, weight_kg),
      experience_growth = ifelse(name %in% selected_pokemon, experience_growth * 1.05, experience_growth)
    )

  return(data)
}


########################## FUNCTION 3 ##########################
#' Update Pokémon Abilities
#'
#' This function allows the user to add new abilities to one or more Pokémon in the dataset.
#'
#' @param pokemon A character vector of Pokémon names to update.
#' @param new_skills A character vector of skills to add to the Pokémon's abilities.
#' @param data A data frame containing Pokémon data, including the `abilities` column.
#'
#' @return A modified data frame with the updated abilities for the specified Pokémon.
#' @examples
#' pokedata <- pokeskill(
#'   pokemon = c("Bulbasaur", "Charmander"),
#'   new_skills = c("Solar Beam", "Inferno"),
#'   data = pokedata
#' )
pokeskill <- function(pokemon, new_skills, data) {
  # Validate input: Ensure Pokémon exist in the dataset
  missing_pokemon <- setdiff(pokemon, data$name)
  if (length(missing_pokemon) > 0) {
    stop(paste("The following Pokémon are not in the dataset:", paste(missing_pokemon, collapse = ", ")))
  }

  # Update the abilities for the specified Pokémon
  data <- data %>%
    dplyr::mutate(
      abilities = ifelse(
        name %in% pokemon,
        paste0(abilities, ", ", paste(new_skills, collapse = ", ")),
        abilities
      )
    )

  return(data)
}

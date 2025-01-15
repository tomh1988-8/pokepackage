# All clear!
rm(list =ls())

# Libraries
library(tidyverse)
library(testthat)

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

# Define the unit tests
test_that("pokehack works correctly for valid Pokémon", {
  # Create dummy data
  dummy_data <- tibble(
    name = c("Bulbasaur", "Charmander", "Squirtle"),
    defense = c(49, 43, 65),
    sp_attack = c(65, 60, 50),
    sp_defense = c(65, 50, 64),
    speed = c(45, 65, 43)
  )
  
  # Apply the function to boost stats for Bulbasaur
  updated_data <- pokehack("Bulbasaur", dummy_data)
  
  # Check that only Bulbasaur's stats are boosted
  expect_equal(updated_data$defense[updated_data$name == "Bulbasaur"], 49 * 1.1)
  expect_equal(updated_data$sp_attack[updated_data$name == "Bulbasaur"], 65 * 1.1)
  expect_equal(updated_data$sp_defense[updated_data$name == "Bulbasaur"], 65 * 1.1)
  expect_equal(updated_data$speed[updated_data$name == "Bulbasaur"], 45 * 1.1)
  
  # Check that other Pokémon's stats remain unchanged
  expect_equal(updated_data$defense[updated_data$name == "Charmander"], 43)
  expect_equal(updated_data$sp_attack[updated_data$name == "Squirtle"], 50)
})

test_that("pokehack throws an error for invalid Pokémon", {
  # Create dummy data
  dummy_data <- tibble(
    name = c("Bulbasaur", "Charmander", "Squirtle"),
    defense = c(49, 43, 65),
    sp_attack = c(65, 60, 50),
    sp_defense = c(65, 50, 64),
    speed = c(45, 65, 43)
  )
  
  # Expect an error when the Pokémon name does not exist
  expect_error(
    pokehack("Pikachu", dummy_data),
    "The specified Pokémon name does not exist in the dataset."
  )
})

test_that("pokehack handles empty datasets", {
  # Create empty dummy data
  empty_data <- tibble(
    name = character(),
    defense = integer(),
    sp_attack = integer(),
    sp_defense = integer(),
    speed = integer()
  )
  
  # Expect an error when the dataset is empty
  expect_error(
    pokehack("Bulbasaur", empty_data),
    "The specified Pokémon name does not exist in the dataset."
  )
})

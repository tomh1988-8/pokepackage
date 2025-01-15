# Libraries
library(tidyverse)
library(testthat)


########################## FUNCTION 1: boost_pokemon_stats ##########################
# Define the unit tests
test_that("boost_pokemon_stats works correctly for valid Pokémon", {
  # Create dummy data
  dummy_data <- tibble(
    name = c("Bulbasaur", "Charmander", "Squirtle"),
    defense = c(49, 43, 65),
    sp_attack = c(65, 60, 50),
    sp_defense = c(65, 50, 64),
    speed = c(45, 65, 43)
  )
  
  # Apply the function to boost stats for Bulbasaur
  updated_data <- boost_pokemon_stats("Bulbasaur", dummy_data)
  
  # Check that only Bulbasaur's stats are boosted
  expect_equal(updated_data$defense[updated_data$name == "Bulbasaur"], 49 * 1.1)
  expect_equal(updated_data$sp_attack[updated_data$name == "Bulbasaur"], 65 * 1.1)
  expect_equal(updated_data$sp_defense[updated_data$name == "Bulbasaur"], 65 * 1.1)
  expect_equal(updated_data$speed[updated_data$name == "Bulbasaur"], 45 * 1.1)
  
  # Check that other Pokémon's stats remain unchanged
  expect_equal(updated_data$defense[updated_data$name == "Charmander"], 43)
  expect_equal(updated_data$sp_attack[updated_data$name == "Squirtle"], 50)
})

test_that("boost_pokemon_stats throws an error for invalid Pokémon", {
  # Create dummy data
  dummy_data <- tibble(
    name = c("Bulbasaur", "Charmander", "Squirtle"),
    defense = c(49, 43, 65),
    sp_attack = c(65, 60, 50),
    sp_defense = c(65, 50, 64),
    speed = c(45, 65, 43)
  )
  
  # Expect an error when the Pokémon name does not exist
  expect_error(boost_pokemon_stats("Pikachu", dummy_data), 
               "The specified Pokémon name does not exist in the dataset.")
})

test_that("boost_pokemon_stats handles empty datasets", {
  # Create empty dummy data
  empty_data <- tibble(
    name = character(),
    defense = integer(),
    sp_attack = integer(),
    sp_defense = integer(),
    speed = integer()
  )
  
  # Expect an error when the dataset is empty
  expect_error(boost_pokemon_stats("Bulbasaur", empty_data), 
               "The specified Pokémon name does not exist in the dataset.")
})


########################## FUNCTION 2 ##########################



















########################## FUNCTION 3 ##########################




















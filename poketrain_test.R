# All clear!
rm(list =ls())

# Libraries
library(tidyverse)
library(testthat)

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

# begin tests
test_that("poketrain correctly updates stats for selected Pokémon", {
  # Create dummy data
  dummy_data <- tibble(
    name = c("Bulbasaur", "Charmander", "Squirtle", "Ivysaur", "Pikachu", "Meowth", "Jigglypuff"),
    weight_kg = c(6.9, 8.5, 9.0, 13.0, 6.0, 4.2, 5.5),
    experience_growth = c(1000000, 1050000, 950000, 1100000, 1200000, 800000, 600000)
  )
  
  # Define the Pokémon to train
  selected_pokemon <- c("Bulbasaur", "Charmander", "Squirtle", "Ivysaur", "Pikachu", "Meowth")
  
  # Apply the function
  trained_data <- poketrain(selected_pokemon, dummy_data)
  
  # Verify weight reduction and experience gain for selected Pokémon
  for (pokemon in selected_pokemon) {
    expect_equal(
      trained_data$weight_kg[trained_data$name == pokemon],
      dummy_data$weight_kg[dummy_data$name == pokemon] * 0.9
    )
    expect_equal(
      trained_data$experience_growth[trained_data$name == pokemon],
      dummy_data$experience_growth[dummy_data$name == pokemon] * 1.05
    )
  }
  
  # Verify stats remain unchanged for unselected Pokémon
  unselected_pokemon <- setdiff(dummy_data$name, selected_pokemon)
  for (pokemon in unselected_pokemon) {
    expect_equal(
      trained_data$weight_kg[trained_data$name == pokemon],
      dummy_data$weight_kg[dummy_data$name == pokemon]
    )
    expect_equal(
      trained_data$experience_growth[trained_data$name == pokemon],
      dummy_data$experience_growth[dummy_data$name == pokemon]
    )
  }
})

test_that("poketrain throws an error if not exactly 6 Pokémon are selected", {
  # Create dummy data
  dummy_data <- tibble(
    name = c("Bulbasaur", "Charmander", "Squirtle", "Ivysaur", "Pikachu", "Meowth"),
    weight_kg = c(6.9, 8.5, 9.0, 13.0, 6.0, 4.2),
    experience_growth = c(1000000, 1050000, 950000, 1100000, 1200000, 800000)
  )
  
  # Select fewer than 6 Pokémon
  too_few <- c("Bulbasaur", "Charmander", "Squirtle")
  expect_error(
    poketrain(too_few, dummy_data),
    "You must select exactly 6 Pokémon for training."
  )
  
  # Select more than 6 Pokémon
  too_many <- c("Bulbasaur", "Charmander", "Squirtle", "Ivysaur", "Pikachu", "Meowth", "Jigglypuff")
  expect_error(
    poketrain(too_many, dummy_data),
    "You must select exactly 6 Pokémon for training."
  )
})

test_that("poketrain throws an error if selected Pokémon do not exist", {
  # Create dummy data
  dummy_data <- tibble(
    name = c("Bulbasaur", "Charmander", "Squirtle"),
    weight_kg = c(6.9, 8.5, 9.0),
    experience_growth = c(1000000, 1050000, 950000)
  )
  
  # Select a nonexistent Pokémon
  nonexistent <- c("Pikachu", "Charmander", "Squirtle", "Ivysaur", "Meowth", "Jigglypuff")
  expect_error(
    poketrain(nonexistent, dummy_data),
    "The following Pokémon are not in the dataset: Pikachu, Ivysaur, Meowth, Jigglypuff"
  )
})

test_that("poketrain handles an empty dataset gracefully", {
  # Create empty dummy data
  empty_data <- tibble(
    name = character(),
    weight_kg = numeric(),
    experience_growth = numeric()
  )
  
  # Select Pokémon (irrelevant because the dataset is empty)
  selected_pokemon <- c("Bulbasaur", "Charmander", "Squirtle", "Ivysaur", "Pikachu", "Meowth")
  
  # Expect an error
  expect_error(
    poketrain(selected_pokemon, empty_data),
    "The following Pokémon are not in the dataset: Bulbasaur, Charmander, Squirtle, Ivysaur, Pikachu, Meowth"
  )
})
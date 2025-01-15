# All clear!
rm(list =ls())

# Libraries
library(tidyverse)
library(testthat)

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
        # Properly format the abilities to include new skills
        paste0(
          sub("\\]$", "", abilities), # Remove the closing bracket
          ifelse(nchar(new_skills) > 0, paste0(", '", paste(new_skills, collapse = "', '"), "'"), ""), # Add new skills
          "]" # Re-add the closing bracket
        ),
        abilities
      )
    )
  
  return(data)
}

# begin tests
test_that("pokeskill correctly updates abilities for valid Pokémon", {
  # Create dummy data
  dummy_data <- tibble(
    name = c("Bulbasaur", "Charmander", "Squirtle"),
    abilities = c("['Overgrow']", "['Blaze']", "['Torrent']")
  )
  
  # Apply the function
  updated_data <- pokeskill(
    pokemon = c("Bulbasaur", "Charmander"),
    new_skills = c("Solar Beam", "Inferno"),
    data = dummy_data
  )
  
  # Check updated abilities for Bulbasaur
  expect_equal(
    updated_data$abilities[updated_data$name == "Bulbasaur"],
    "['Overgrow', 'Solar Beam', 'Inferno']"
  )
  
  # Check updated abilities for Charmander
  expect_equal(
    updated_data$abilities[updated_data$name == "Charmander"],
    "['Blaze', 'Solar Beam', 'Inferno']"
  )
  
  # Check unchanged abilities for Squirtle
  expect_equal(
    updated_data$abilities[updated_data$name == "Squirtle"],
    "['Torrent']"
  )
})

test_that("pokeskill throws an error for nonexistent Pokémon", {
  # Create dummy data
  dummy_data <- tibble(
    name = c("Bulbasaur", "Charmander", "Squirtle"),
    abilities = c("['Overgrow']", "['Blaze']", "['Torrent']")
  )
  
  # Check for error with invalid Pokémon
  expect_error(
    pokeskill(
      pokemon = c("Pikachu", "Eevee"),
      new_skills = c("Thunderbolt"),
      data = dummy_data
    ),
    "The following Pokémon are not in the dataset: Pikachu, Eevee"
  )
})

test_that("pokeskill correctly handles empty skills", {
  # Create dummy data
  dummy_data <- tibble(
    name = c("Bulbasaur", "Charmander", "Squirtle"),
    abilities = c("['Overgrow']", "['Blaze']", "['Torrent']")
  )
  
  # Apply the function with empty skills
  updated_data <- pokeskill(
    pokemon = c("Bulbasaur"),
    new_skills = character(0),
    data = dummy_data
  )
  
  # Check that abilities remain unchanged
  expect_equal(
    updated_data$abilities[updated_data$name == "Bulbasaur"],
    "['Overgrow']"
  )
})

test_that("pokeskill throws an error for an empty dataset", {
  # Create empty dummy data
  empty_data <- tibble(
    name = character(),
    abilities = character()
  )
  
  # Expect an error when using an empty dataset
  expect_error(
    pokeskill(
      pokemon = c("Bulbasaur"),
      new_skills = c("Solar Beam"),
      data = empty_data
    ),
    "The following Pokémon are not in the dataset: Bulbasaur"
  )
})

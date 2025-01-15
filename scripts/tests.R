# Libraries
library(tidyverse)
library(testthat)


########################## FUNCTION 1: pokehack ##########################
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


########################## FUNCTION 2: poketrain ##########################
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


########################## FUNCTION 3 ##########################
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

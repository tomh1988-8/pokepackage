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
#' @export
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

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

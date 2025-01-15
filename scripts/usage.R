# Libraries
library(tidyverse)
library(here)

# Read in data
pokedata <- read.csv(here("data", "pokemon.csv"))

########################## FUNCTION 1: pokehack ##########################
cat("\n### Testing pokehack ###\n")

# Example: Boost Bulbasaur's stats by 10%
cat("Boosting Bulbasaur's stats:\n")

# Print Bulbasaur's stats before boosting
cat("Bulbasaur's stats BEFORE boosting:\n")
print(pokedata %>% filter(name == "Bulbasaur") %>% select(name, defense, sp_attack, sp_defense, speed))

# Apply the pokehack function
pokedata <- pokehack("Bulbasaur", pokedata)

# Print Bulbasaur's stats after boosting
cat("Bulbasaur's stats AFTER boosting:\n")
print(pokedata %>% filter(name == "Bulbasaur") %>% select(name, defense, sp_attack, sp_defense, speed))


########################## FUNCTION 2: poketrain ##########################
cat("\n### Testing poketrain ###\n")

# Example: Select 6 Pokémon for training
selected_pokemon <- c("Bulbasaur", "Charmander", "Squirtle", "Ivysaur", "Pikachu", "Meowth")

# Print stats before training
cat("Stats BEFORE training:\n")
print(pokedata %>% filter(name %in% selected_pokemon) %>% select(name, weight_kg, experience_growth))

# Apply the poketrain function
cat("Training Pokémon...\n")
pokedata <- poketrain(selected_pokemon, pokedata)

# Print stats after training
cat("Stats AFTER training:\n")
print(pokedata %>% filter(name %in% selected_pokemon) %>% select(name, weight_kg, experience_growth))


########################## FUNCTION 3: pokeskill ##########################
cat("\n### Testing pokeskill ###\n")

# Example: Add new skills to selected Pokémon
selected_pokemon <- c("Bulbasaur", "Charmander")
skills_to_add <- c("Solar Beam", "Inferno")

# Print abilities before adding new skills
cat("Abilities BEFORE adding new skills:\n")
print(pokedata %>% filter(name %in% selected_pokemon) %>% select(name, abilities))

# Apply the pokeskill function
cat("Adding new skills to selected Pokémon...\n")
pokedata <- pokeskill(selected_pokemon, skills_to_add, pokedata)

# Print abilities after adding new skills
cat("Abilities AFTER adding new skills:\n")
print(pokedata %>% filter(name %in% selected_pokemon) %>% select(name, abilities))




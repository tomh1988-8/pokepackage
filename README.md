
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pokepackage

<!-- badges: start -->
<!-- badges: end -->

The goal of pokepackage is to provide tools to enhance Pokémon data,
including boosting stats, updating abilities, and preparing for battles.

## Installation

You can install the development version of pokepackage from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("tomh1988-8/pokepackage")
```

## Example

Below are examples demonstrating the main functionality of pokepackage:

### Boost Pokémon Stats with pokehack

This function boosts the stats of a specified Pokémon by 10%:

``` r
library(pokepackage)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

# Example Pokémon data
pokemon <- data.frame(
  name = c("Bulbasaur", "Charmander", "Squirtle"),
  defense = c(49, 43, 65),
  sp_attack = c(65, 60, 50),
  sp_defense = c(65, 50, 64),
  speed = c(45, 65, 43)
)

# Boost Bulbasaur's stats
pokemon <- pokehack("Bulbasaur", pokemon)
print(pokemon)
#>         name defense sp_attack sp_defense speed
#> 1  Bulbasaur    53.9      71.5       71.5  49.5
#> 2 Charmander    43.0      60.0       50.0  65.0
#> 3   Squirtle    65.0      50.0       64.0  43.0
```

### Update Pokémon Abilities with pokeskill

This function allows updating or adding new abilities to one or more
Pokémon:

``` r
library(pokepackage)
library(dplyr)

# Add abilities to Bulbasaur and Charmander
pokemon <- data.frame(
  name = c("Bulbasaur", "Charmander", "Squirtle"),
  abilities = c("[Overgrow]", "[Blaze]", "[Torrent]")
)

pokemon <- pokeskill(
  pokemon = c("Bulbasaur", "Charmander"),
  new_skills = c("Solar Beam", "Inferno"),
  data = pokemon
)
print(pokemon)
#>         name                           abilities
#> 1  Bulbasaur [Overgrow, 'Solar Beam', 'Inferno']
#> 2 Charmander    [Blaze, 'Solar Beam', 'Inferno']
#> 3   Squirtle                           [Torrent]
```

### Train Pokémon with poketrain

This function trains six selected Pokémon, decreasing their weight and
increasing their experience growth:

``` r
library(pokepackage)
library(dplyr)

# Train six Pokémon
pokemon <- data.frame(
  name = c("Bulbasaur", "Charmander", "Squirtle", "Pikachu", "Jigglypuff", "Meowth"),
  weight_kg = c(6.9, 8.5, 9.0, 6.0, 5.5, 4.2),
  experience_growth = c(100, 120, 110, 95, 85, 80)
)

trained_pokemon <- poketrain(
  selected_pokemon = c("Bulbasaur", "Charmander", "Squirtle", "Pikachu", "Jigglypuff", "Meowth"),
  data = pokemon
)
print(trained_pokemon)
#>         name weight_kg experience_growth
#> 1  Bulbasaur      6.21            105.00
#> 2 Charmander      7.65            126.00
#> 3   Squirtle      8.10            115.50
#> 4    Pikachu      5.40             99.75
#> 5 Jigglypuff      4.95             89.25
#> 6     Meowth      3.78             84.00
```

### Notes

Ensure all required libraries (dplyr, etc.) are loaded within the
package or session. Handle input errors gracefully. For example, invalid
Pokémon names will result in error messages.

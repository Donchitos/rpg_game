# Base Character class
class_name GeneralStats

# Common attributes for all characters
extends Resource

# Define variable types and add comments for clarity
@export var Max_Health = 100   # Maximum health points
@export var Max_Stamina  = 100    # Maximum stamina points
@export var Max_Mana = 100         # Maximum mana points

@export var Health  = 100           # Current health points
@export var Stamina = 100        # Current stamina points
@export var Mana = 100           # Current mana points

# Combat style attributes
@export var Melee_Level : int = 1                   # Level specific to Melee combat
@export var Attack : int = 1                  # Melee attack attribute
@export var Strength : int = 1                # Melee strength attribute
@export var Defense : int = 1                 # Melee defense attribute

@export var Ranged_Level : int = 1                  # Level specific to Ranged combat
@export var Ranged_Proficiancy : int = 1                # Ranged archery attribute

@export var Magic_Level : int = 1                   # Level specific to Magic combat
@export var Magic_Knowledge : int = 1               # Magic knowledge attribute
@export var Magic_Proficiency : int = 1             # Magic proficiency attribute
@export var Magic_Defense : int = 1                 # Magic defense attribute

# Additional skills for the playable character
@export var Agility_Level : int = 1                 # Level specific to Agility
@export var Agility_Evasion : int = 1               # Agility evasion attribute
@export var Agility_Critical_Chance : int = 1       # Agility critical chance attribute

@export var Overall_Level : int = 1                 # Overall level considering all combat styles and additional skills

@export var Health_Regen_Rate = 0.5         # Health regeneration rate
@export var Stamina_Regen_Rate = 5.0        # Stamina regeneration rate
@export var Mana_Regen_Rate = 1.0           # Mana regeneration rate

@export var Knockback_Strength : int = 10           # Strength of knockback effect

# Custom setters for clamping values



# Additional attributes for character movement
@export var Speed : float         # Movement speed
@export var Acceleration : float   # Acceleration rate
@export var Friction : float     # Friction to slow down movement

# Custom functions for regenerating health, stamina, and mana
func regenerate_health(delta):
	var updated_health = min(Health + Health_Regen_Rate * delta, Max_Health)
	if updated_health != Health:
		Health = updated_health


func regenerate_stamina(delta: float):
	Stamina = min(Stamina + Stamina_Regen_Rate * delta, Max_Stamina)

func regenerate_mana(delta: float):
	Mana = min(Mana + Mana_Regen_Rate * delta, Max_Mana)
	




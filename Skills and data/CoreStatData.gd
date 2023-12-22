extends Stats
class_name CoreStatData

@export var Max_Health = 100   # Maximum health points
@export var Max_Stamina  = 100    # Maximum stamina points
@export var Max_Mana = 100         # Maximum mana points

@export var Health  = 100           # Current health points
@export var Stamina = 100        # Current stamina points
@export var Mana = 100   


@export var Health_Regen_Rate = 0.5         # Health regeneration rate
@export var Stamina_Regen_Rate = 5.0        # Stamina regeneration rate
@export var Mana_Regen_Rate = 1.0           # Mana regeneration rate




func regenerate_health(delta):
	var updated_health = min(Health + Health_Regen_Rate * delta, Max_Health)
	if updated_health != Health:
		Health = updated_health


func regenerate_stamina(delta: float):
	Stamina = min(Stamina + Stamina_Regen_Rate * delta, Max_Stamina)

func regenerate_mana(delta: float):
	Mana = min(Mana + Mana_Regen_Rate * delta, Max_Mana)

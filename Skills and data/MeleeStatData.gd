extends Stats
class_name MeleeStatData

@export var attack : int = 1
@export var strength: int = 1
@export var defence: int = 1
@export var melee_xp: int = 0
var meleecombatmanager : MeleeCombatManager
var min_stat_value: int = 0
@export var max_stat_value: int = 100  # You can set this based on the max cap



func _ready():
	meleecombatmanager.meleedamagedeal.connect(_on_melee_damage_dealt)


func _on_melee_damage_dealt(damage_dealt):
	print("Received Damage Dealt (XP Gained):", damage_dealt)
	# Update XP in MeleeStatData or perform other actions...
	melee_xp += damage_dealt
	print("Updated Melee XP:", melee_xp)
	# Other logic related to handling the gained XP, if needed







func clamp_stats():
	attack = clamp(attack, min_stat_value, max_stat_value)
	strength = clamp(strength, min_stat_value, max_stat_value)
	defence = clamp(defence, min_stat_value, max_stat_value)

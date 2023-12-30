extends Stats
class_name MeleeStatData

@export var attack : int = 1
@export var strength: int = 1
@export var defence: int = 1
@export var melee_xp: int = 0
var meleecombatmanager : MeleeCombatManager
var min_stat_value: int = 0
@export var max_stat_value: int = 100  # You can set this based on the max cap
var currentLevel: int = 1
var hasLevels: bool = true


func clamp_stats():
	attack = clamp(attack, min_stat_value, max_stat_value)
	strength = clamp(strength, min_stat_value, max_stat_value)
	defence = clamp(defence, min_stat_value, max_stat_value)



func checkForLevelUp():
	var xpThreshold = calculateXPNeededForNextLevel(currentLevel, hasLevels)
	if melee_xp >= xpThreshold:
		print("Player has enough XP to level up!")
		currentLevel += 1
		melee_xp -= xpThreshold  # Reset XP to 0 for the next level
		increaseStatsOnLevelUp()  # Call function to increase stats


func increaseStatsOnLevelUp():
	# Define how stats increase on level up
	attack += 1
	strength += 1
	defence += 1

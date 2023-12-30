extends Resource
class_name Stats

@export var core_stats: CoreStatData
@export var melee_stats: MeleeStatData
@export var ranged_stats:RangedStatData
@export var magic_stats: MagicStatData
@export var agility_stats: AgilityStatData
@export var skilling_stats: SkillingStatData
@export var movement_stats: MovementData
var Knockback_Strength: int = 0
var xpCalculationX: float = 0.1
var xpCalculationY: float = 2.0

signal xp_gained(stat_type: String, xp_gained: int, xp_needed: int)




func calculateXPNeededForNextLevel(currentLevel: int, hasLevels: bool) -> int:
	if hasLevels:
		return int(pow(currentLevel / xpCalculationX, xpCalculationY))
	else:
		return 0  # No XP needed for skills without levels

# Function to handle XP gain for a specific skill

func gainXP(statType: String, xpGained: int):
	match statType:
		"melee":
			melee_stats.melee_xp += xpGained
			melee_stats.checkForLevelUp()
			var currentXP = melee_stats.melee_xp
			xp_gained.emit(statType, currentXP, calculateXPNeededForNextLevel(melee_stats.currentLevel, melee_stats.hasLevels))
			print("Signal emitted for melee XP gained:", xpGained)
		"ranged":
			ranged_stats.ranged_xp += xpGained
			ranged_stats.checkForLevelUp()
		"magic":
			magic_stats.magic_xp += xpGained
			magic_stats.checkForLevelUp()
		"agility":
			agility_stats.agility_xp += xpGained
			agility_stats.checkForLevelUp()
		"skilling":
			# Handle the skilling stats that contain nested skills directly
			skilling_stats.Artisan_Skill.artisan_xp += xpGained
			skilling_stats.Artisan_Skill.checkForArtisanLevelUp()
			skilling_stats.Sustenance_Skill.sustenance_xp += xpGained
			skilling_stats.Sustenance_Skill.checkForSustenanceLevelUp()
			skilling_stats.Arcane_Proficiency.arcane_xp += xpGained
			skilling_stats.Arcane_Proficiency.checkForArcaneLevelUp()


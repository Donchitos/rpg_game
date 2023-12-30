extends Stats
class_name MagicStatData

@export var Magic_xp: int = 0
@export var Magic_Knowledge: int = 1
@export var Magic_Proficiency: int = 1
@export var Magic_Defense: int = 1
var currentLevel: int = 1
var hasLevels: bool = true
var min_stat_value: int = 0
@export var max_stat_value: int = 100  # Set the maximum cap for stats


func clamp_stats():
	Magic_Knowledge = clamp(Magic_Knowledge, min_stat_value, max_stat_value)
	Magic_Proficiency = clamp(Magic_Proficiency, min_stat_value, max_stat_value)
	Magic_Defense = clamp(Magic_Defense, min_stat_value, max_stat_value)

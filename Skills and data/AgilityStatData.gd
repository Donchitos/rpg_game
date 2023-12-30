extends Stats
class_name AgilityStatData

@export var agility_xp: int = 0
@export var evasion: int = 1
@export var critical_chance: int = 1
var currentLevel: int = 1
var hasLevels: bool = true
var min_stat_value: int = 0
@export var max_stat_value: int = 100

func clamp_stats():
	evasion = clamp(evasion, min_stat_value, max_stat_value)
	critical_chance = clamp(critical_chance, min_stat_value, max_stat_value)

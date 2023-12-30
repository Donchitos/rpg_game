extends CanvasLayer

@onready var player = get_parent().get_node("Player")
@onready var health_bar = $HBoxContainer/VBoxContainer/HealthBar
@onready var stamina_bar = $HBoxContainer/VBoxContainer/StaminaBar
@onready var magic_bar = $HBoxContainer/VBoxContainer/MagicBar
@onready var xp_drop = $XpDrop
@onready var xp_drop_icon = $XpDrop/PanelContainer/MarginContainer/XpDropIcon
@onready var xp_bar = $XpDrop/XPBar
@onready var timer = $XpDrop/Timer


var currentXPSkill: String = ""  # To keep track of the current skill gaining XP
var currentXPGained: int = 0
var currentXPNeeded: int = 0

func _ready():
	# Connect the player's signals to update the bars
	player.health_changed.connect(_on_player_health_changed)
	player.stamina_changed.connect(_on_player_stamina_changed)
	player.mana_changed.connect(_on_player_mana_changed)
	player.player_stats.xp_gained.connect(_on_xp_gained)
	print("Signal connected: player_stats.xp_gained")
	# Update the bars initially with the player's current values
	_on_player_health_changed(player.player_stats.core_stats.Health)
	_on_player_stamina_changed(player.player_stats.core_stats.Stamina)
	_on_player_mana_changed(player.player_stats.core_stats.Mana)
	timer.timeout.connect(_on_timer_timeout)
	
	

func _on_xp_gained(statType, xpGained, xpNeeded):
	xp_drop.visible = true
	currentXPSkill = statType  # Update the current skill gaining XP
	currentXPGained = xpGained
	currentXPNeeded = xpNeeded
	# Update the XP bar for the skill that gained XP
	update_xp_bar(statType,currentXPGained, currentXPNeeded)
	timer.start()

func _on_player_health_changed(new_health):
	# Update the health bar value
	health_bar.value = new_health

func _on_player_stamina_changed(new_stamina):
	# Update the stamina bar value
	stamina_bar.value = new_stamina

func _on_player_mana_changed(new_mana):
	pass

func update_xp_bar(statType, currentXP, xpNeeded):
	print("Updating XP bar for statType:", statType)
	print("Received current XP:", currentXP, "xpNeeded:", xpNeeded)
	var progress_ratio = float(currentXP) / float(xpNeeded) if xpNeeded != 0 else 0.0
	print("Calculated progress ratio:", progress_ratio)

	match currentXPSkill:
		"melee":
			xp_bar.value = progress_ratio * 100  # Assuming XP bar uses a 0-100 range
			print("Updated XP bar for melee skill. Progress ratio:", progress_ratio)
			# Update other relevant UI elements for melee XP...
		"ranged":
				xp_bar.value = progress_ratio * 100  # Assuming XP bar uses a 0-100 range
			# Update other relevant UI elements for ranged XP...
		"magic":
				xp_bar.value = progress_ratio * 100  # Assuming XP bar uses a 0-100 range
			# Update other relevant UI elements for magic XP...
		"agility":
				xp_bar.value = progress_ratio * 100  # Assuming XP bar uses a 0-100 range
			# Update other relevant UI elements for agility XP...
		"skilling":
				xp_bar.value = progress_ratio * 100  # Assuming XP bar uses a 0-100 range
			# Update other relevant UI elements for skilling XP...





func _on_timer_timeout():
	xp_drop.visible = false

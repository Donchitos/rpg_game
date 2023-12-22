extends CanvasLayer

@onready var player = get_parent().get_node("Player")
@onready var health_bar = $HealthBar  # Assuming the health bar node is named "TextureProgressBar"
@onready var stamina_bar = $StaminaBar
@onready var magic_bar = $MagicBarBar


func _ready():
	# Connect the player's signals to update the bars
	player.health_changed.connect(_on_player_health_changed)
	player.stamina_changed.connect(_on_player_stamina_changed)
	player.mana_changed.connect(_on_player_mana_changed)
	
	# Update the bars initially with the player's current values
	_on_player_health_changed(player.player_stats.Health)
	_on_player_stamina_changed(player.player_stats.Stamina)
	_on_player_mana_changed(player.player_stats.Mana)

func _on_player_health_changed(new_health):
	# Update the health bar value
	health_bar.value = new_health

func _on_player_stamina_changed(new_stamina):
	# Update the stamina bar value
	stamina_bar.value = new_stamina

func _on_player_mana_changed(new_mana):
	pass



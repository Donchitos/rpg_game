extends Control

@onready var player = $"../../Player"




func _ready() -> void:
	player.toggle_menu.connect(_on_toggle_menu)





func _on_toggle_menu() -> void:
	visible = not visible

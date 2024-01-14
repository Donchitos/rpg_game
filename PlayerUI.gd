extends Control

@onready var player = $"../../Player"

signal equipItemAdded


func _ready() -> void:
	player.toggle_menu.connect(_on_toggle_menu)


func _on_item_equipped(item_data):
	# Some logic to handle the equipped item and gather necessary data
	emit_signal("equipItemAdded", item_data)


func _on_toggle_menu() -> void:
	visible = not visible

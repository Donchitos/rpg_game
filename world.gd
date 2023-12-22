extends Node2D

@onready var player = $Player
@onready var inventory_interface = $InventoryUI/InventoryInterface
var enemy = Enemy

func _ready() -> void:
	inventory_interface.set_player_inventory_data(player.inventory_data)
	inventory_interface.set_equip_inventory_data(player.equip_inventory_data)
	player.toggle_inventory.connect(toggle_inventory_interface)
	for child in get_children():
		if child is Enemy:  # Check if the node is an instance of the Enemy class
			child.enemy_death.connect(_on_enemy_death)

func toggle_inventory_interface() -> void:
	inventory_interface.visible = not inventory_interface.visible
	

func _on_enemy_death(enemy, drop_table: DropTable) -> void:
	var dropped_items = drop_table.roll_for_drops()

	for item_data in dropped_items:
		var slot_data = SlotData.new()
		slot_data.item_data = item_data
		
		var item_drop_scene = preload("res://Items/item_drop.tscn").instantiate()
		item_drop_scene.slot_data = slot_data
		item_drop_scene.global_position = enemy.global_position
		if item_drop_scene.has_method("launch"):
			var launch_direction = Vector2(randf() * 2.0 - 1.0, randf() * 2.0 - 1.0).normalized()
			item_drop_scene.launch(launch_direction * randf_range(150, 200), 0.2) # Adjust the velocity range as needed

		
		
		add_child(item_drop_scene)


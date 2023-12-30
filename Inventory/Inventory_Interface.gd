extends Control

@onready var grabbed_slot = $GrabbedSlot



@onready var equip_inventory = $MarginContainer/HBoxContainer/PanelContainer/VBoxContainer/EquipBox/VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/EquipInventory
@onready var player_inventory = $MarginContainer/HBoxContainer/PanelContainer2/Inventories/General/MarginContainer/PlayerInventory





func _physics_process(delta:float)-> void:
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)


var grabbed_slot_data: SlotData

func set_player_inventory_data(inventory_data: InventoryData) -> void:
	player_inventory.set_inventory_data(inventory_data)
	inventory_data.inventory_interact.connect(on_inventory_interact)

func set_equip_inventory_data(inventory_data: InventoryData) -> void:
	equip_inventory.set_inventory_data(inventory_data)
	inventory_data.inventory_interact.connect(on_inventory_interact)

func on_inventory_interact(inventory_data: InventoryData, index:int, button:int) -> void:
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data,index)
		[null, MOUSE_BUTTON_RIGHT]:
			inventory_data.use_slot_data(index)
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data,index)



	update_grabbed_slot()

func update_grabbed_slot() -> void:
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()

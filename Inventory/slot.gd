extends PanelContainer

@onready var quantity = $Quantity
@onready var texture_rect: TextureRect = $TextureRect/MarginContainer/TextureRect


signal slot_clicked(index: int, button: int)

func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	if item_data and "texture" in item_data:
		texture_rect.texture = item_data.texture
		# Set tooltip text if item data and its properties exist
		tooltip_text = "%s\n%s" % [item_data.name, item_data.description]
	else:
		print("Item data or texture not available")

	if slot_data.quantity > 1:
		quantity.text = "x%s" % slot_data.quantity
		quantity.show()
	else:
		quantity.hide()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)

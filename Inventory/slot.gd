extends PanelContainer

@onready var quantity = $Quantity
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect


signal slot_clicked(index: int, button: int)

func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	if item_data and "texture" in item_data:
		texture_rect.texture = item_data.texture
		var stats_text = ""
		if item_data is ItemDataEquip:
			var equip_data = item_data
			# Check each stat and only display if it's non-zero
			if equip_data.weapon_attack != 0:
				stats_text += "Attack: %d\n" % equip_data.weapon_attack
			if equip_data.weapon_strength != 0:
				stats_text += "Strength: %d\n" % equip_data.weapon_strength
			if equip_data.weapon_ranged_strength != 0:
				stats_text += "Ranged Strength: %d\n" % equip_data.weapon_ranged_strength
			if equip_data.weapon_ranged_precision != 0:
				stats_text += "Ranged Precision: %d\n" % equip_data.weapon_ranged_precision
			if equip_data.weapon_magic_proficiency != 0:
				stats_text += "Magic Proficiency: %d\n" % equip_data.weapon_magic_proficiency
			if equip_data.melee_defence != 0:
				stats_text += "Melee Defence: %d\n" % equip_data.melee_defence
			if equip_data.magic_defence != 0:
				stats_text += "Magic Defence: %d\n" % equip_data.magic_defence
			if equip_data.ranged_defence != 0:
				stats_text += "Ranged Defence: %d\n" % equip_data.ranged_defence
			if equip_data.evasion != 0:
				stats_text += "Evasion: %d\n" % equip_data.evasion
			if equip_data.critical_bonus != 0:
				stats_text += "Critical Bonus: %d\n" % equip_data.critical_bonus

			# Set tooltip text including the stats that are non-zero
			tooltip_text = "%s\n%s\n\nStats:\n%s" % [equip_data.name, equip_data.description, stats_text]
		else:
			# Set tooltip text for non-equipment items
			tooltip_text = "%s\n%s" % [item_data.name, item_data.description]

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

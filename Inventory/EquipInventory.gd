extends PanelContainer
class_name EquipInventory

const Slot = preload("res://Inventory/slot.tscn")

signal inventory_updated(inventory_data: InventoryData)
signal equipItemAdded(item_data: ItemDataEquip)



@onready var quiver_slot = $GridContainer/QuiverSlot
@onready var head_slot = $GridContainer/HeadSlot
@onready var amulet_slot = $GridContainer/AmuletSlot
@onready var weapon_slot = $GridContainer/WeaponSlot
@onready var body_slot = $GridContainer/BodySlot
@onready var offhand_slot = $GridContainer/OffhandSlot
@onready var ring_slot = $GridContainer/RingSlot
@onready var legs_slot = $GridContainer/LegsSlot
@onready var bracelet_slot = $GridContainer/BraceletSlot
@onready var hands_slot = $GridContainer/HandsSlot
@onready var boots_slot = $GridContainer/BootsSlot

@onready var item_slots = $MarginContainer/GridContainer


func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)

func populate_item_grid(inventory_data: InventoryData) -> void:
	for child in item_slots.get_children():
		child.queue_free()

	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_slots.add_child(slot)

		slot.slot_clicked.connect(inventory_data.on_slot_clicked)

		if slot_data:
			slot.set_slot_data(slot_data)

			# Debugging the SlotData and its ItemData
			var item_data = slot_data.item_data
			if item_data is ItemDataEquip:
				if item_data is ItemDataEquip:
					emit_signal("equipItemAdded", item_data,)

	emit_signal("inventory_updated", inventory_data) # Emit the inventory_updated signal after updating the inventory

func equip_item(item_data: ItemDataEquip) -> void:
	# Your logic to equip the item goes here
	emit_signal("equipItemAdded", item_data)

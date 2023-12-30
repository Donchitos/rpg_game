extends PanelContainer


@onready var equip_inventory = $VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/EquipInventory


func _ready():
	equip_inventory.equipItemAdded.connect(_onEquipItemAdded)



func _onEquipItemAdded(item_data: ItemDataEquip):
	print("Item added to inventory:", item_data)
# Your code for handling ItemDataEquip instances
	if item_data.equip_type == ItemDataEquip.Weapon:
	# Access attributes specific to the WeaponType enumeration
		print("Weapon stats: Attack =", item_data.Attack, ", Strength =", item_data.Strength)

extends Sprite2D
class_name EquipedWeapon

@export var equipped_weapon: Weapon

func _ready():
	# Assign the default texture when the script is ready
	update_weapon_texture()

# Function to update the weapon's texture
func update_weapon_texture():
	if equipped_weapon:
		texture = equipped_weapon.texture
	else:
		# Set a default texture when no weapon is equipped
		texture = null

# Connect to the EquipInventory's signal for item changes
func _on_EquipInventory_equipItemChanged(item_data: ItemDataEquip):
	equipped_weapon = item_data
	update_weapon_texture()

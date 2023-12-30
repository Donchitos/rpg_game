extends PanelContainer
class_name EquipBox








@onready var equip_inventory = $VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/EquipInventory
@onready var melee_attack_bonus = $"VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/GearInterface/Gear Stats/PanelContainer/MarginContainer/GridContainer/MeleeAttackLabel"
@onready var melee_strength_bonus = $"VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/GearInterface/Gear Stats/PanelContainer/MarginContainer/GridContainer/MeleeStrengthLabel"
@onready var melee_defence_bonus = $"VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/GearInterface/Gear Stats/PanelContainer/MarginContainer/GridContainer/MeleeDefenceLabel"
@onready var ranged_precision_bonus = $"VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/GearInterface/Gear Stats/PanelContainer/MarginContainer/GridContainer/RangedPrecisionLabel"
@onready var ranged_strength_bonus = $"VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/GearInterface/Gear Stats/PanelContainer/MarginContainer/GridContainer/RangedStrengthLabel"
@onready var ranged_defence_bonus = $"VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/GearInterface/Gear Stats/PanelContainer/MarginContainer/GridContainer/RangedDefenceLabel2"
@onready var magic_proficiancy_bonus = $"VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/GearInterface/Gear Stats/PanelContainer/MarginContainer/GridContainer/MagicProficiancyLabel"
@onready var magic_defence_bonus = $"VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/GearInterface/Gear Stats/PanelContainer/MarginContainer/GridContainer/MagicDefenceLabel2"
@onready var evasion_bonus = $"VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/GearInterface/Gear Stats/PanelContainer/MarginContainer/GridContainer/EvasionLabel"
@onready var critical_bonus = $"VBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/GearInterface/Gear Stats/PanelContainer/MarginContainer/GridContainer/CriticalBonusLabel"
# Add other UI elements as needed...

var total_attack = 0
var total_strength = 0
var total_melee_defence = 0
var total_ranged_precision = 0
var total_ranged_strength = 0
var total_ranged_defence = 0
var total_magic_proficiency = 0
var total_magic_defence = 0
var total_evasion = 0
var total_critical_bonus = 0

func _ready():
	equip_inventory.equipItemAdded.connect(_onEquipItemAdded)
	equip_inventory.inventory_updated.connect(_onInventoryUpdated)

	# Other setup code...

func _onEquipItemAdded(item_data: ItemDataEquip):
	# Update individual stat labels when a new item is equipped
	total_attack += item_data.weapon_attack
	total_strength += item_data.weapon_strength
	total_melee_defence += item_data.melee_defence
	total_ranged_precision += item_data.weapon_ranged_precision
	total_ranged_strength += item_data.weapon_ranged_strength
	total_ranged_defence += item_data.ranged_defence
	total_magic_proficiency += item_data.weapon_magic_proficiency
	total_magic_defence += item_data.magic_defence
	total_evasion += item_data.evasion
	total_critical_bonus += item_data.critical_bonus

	# Optionally, perform any necessary handling or computations here

	# Update UI labels with individual stat values
	update_stat_labels()

func _onInventoryUpdated(inventory_data: InventoryData):
	# Update total stats when the inventory changes
	calculateTotalStats(inventory_data)

func calculateTotalStats(inventory_data: InventoryData):
	# Reset total stats to zero before recalculating
	total_attack = 0
	total_strength = 0
	total_melee_defence = 0
	total_ranged_precision = 0
	total_ranged_strength = 0
	total_ranged_defence = 0
	total_magic_proficiency = 0
	total_magic_defence = 0
	total_evasion = 0
	total_critical_bonus = 0

	# Iterate through inventory and calculate total stats
	for slot_data in inventory_data.slot_datas:
		if slot_data and slot_data.item_data:
			var item_data = slot_data.item_data
			if item_data is ItemDataEquip:
				total_attack += item_data.weapon_attack
				total_strength += item_data.weapon_strength
				total_melee_defence += item_data.melee_defence
				total_ranged_precision += item_data.weapon_ranged_precision
				total_ranged_strength += item_data.weapon_ranged_strength
				total_ranged_defence += item_data.ranged_defence
				total_magic_proficiency += item_data.weapon_magic_proficiency
				total_magic_defence += item_data.magic_defence
				total_evasion += item_data.evasion
				total_critical_bonus += item_data.critical_bonus

	# Update UI labels with total stat values
	update_stat_labels()

func update_stat_labels():
	# Update UI labels with total stat values (only numerical values)
	melee_attack_bonus.text = str(total_attack)
	melee_strength_bonus.text = str(total_strength)
	melee_defence_bonus.text = str(total_melee_defence)
	ranged_precision_bonus.text = str(total_ranged_precision)
	ranged_strength_bonus.text = str(total_ranged_strength)
	ranged_defence_bonus.text = str(total_ranged_defence)
	magic_proficiancy_bonus.text = str(total_magic_proficiency)
	magic_defence_bonus.text = str(total_magic_defence)
	evasion_bonus.text = str(total_evasion)
	critical_bonus.text = str(total_critical_bonus)

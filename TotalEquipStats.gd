extends Resource
class_name TotalEquipStats

var total_attack : int = 0
var total_strength : int = 0
var total_melee_defence : int = 0
var total_ranged_precision : int = 0
var total_ranged_strength : int = 0
var total_ranged_defence : int = 0
var total_magic_proficiency : int = 0
var total_magic_defence : int = 0
var total_evasion : int = 0
var total_critical_bonus : int = 0

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

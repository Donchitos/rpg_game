extends InventoryData
class_name InventoryDataEquip



func drop_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	if not grabbed_slot_data.item_data is ItemDataEquip:
		return grabbed_slot_data

	var equip_type = grabbed_slot_data.item_data.equip_type
	
	if index == equip_type:
		return super.drop_slot_data(grabbed_slot_data, index)
	else:
		return grabbed_slot_data

func drop_single_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	if not grabbed_slot_data.item_data is ItemDataEquip:
		return grabbed_slot_data

	var equip_type = grabbed_slot_data.item_data.equip_type
	
	if index == equip_type:
		return super.drop_single_slot_data(grabbed_slot_data, index)
	else:
		return grabbed_slot_data





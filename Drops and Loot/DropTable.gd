extends Resource
class_name DropTable


# Array of DropTableItem resources for an enemy's drop table
@export var drop_table_items : Array[DropTableItem]


func roll_for_drops() -> Array[ItemData]:
	var dropped_items: Array[ItemData] = []

	for item in drop_table_items:
		if item.should_drop():
			dropped_items.append(item.item_data)

	return dropped_items

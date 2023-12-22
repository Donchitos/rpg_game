extends Resource
class_name DropTableItem

@export var item_data: ItemData

# Properties for a single drop item
@export var chance : float = 0.0
@export var min_quantity : int = 0
@export var max_quantity : int = 0



func should_drop() -> bool:
	if chance >= 1.0:  # If chance is 1.0 or greater, always drop the item
		return true
	else:
		var chance_value = randf()  # Generate a random number between 0 and 1
		return chance_value <= chance  # Compare the random number with the drop chance

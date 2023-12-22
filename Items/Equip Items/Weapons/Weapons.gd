extends ItemDataEquip
class_name Weapon


@export_enum("Sword","Dagger","Bow","Spear","Staff","Battle Axe") var WeaponType

# Define attributes for a weapon
@export var Attack : int = 0
@export var Strength : int = 0
@export var Ranged_Proficiancy : int = 0
@export var Magic_Proficiency : int = 0
@export var Attack_Speed : float = 0


extends StaticBody2D

@export var slot_data: SlotData
@onready var sprite_2d = $Sprite2D
@export var item_data: ItemData
var launch_velocity : Vector2 = Vector2.ZERO
var move_duration : float = 0
var time_since_launch:float = 0
var launching : bool = false
var collectable: bool = true



func _ready() -> void:
	if slot_data:
		sprite_2d.texture = slot_data.item_data.texture
func _on_pickable_zone_body_entered(body) -> void:
	if body.name == "Player" and collectable:
		if body.inventory_data.pick_up_slot_data(slot_data):
			queue_free()


func _process(delta):
	if (launching):
		position += launch_velocity * delta
		time_since_launch += delta
		
		if (time_since_launch >= move_duration):
			launching = false
			collectable = true


func launch(velocity: Vector2, duration : float):
	launch_velocity = velocity
	move_duration = duration
	time_since_launch = 0
	launching = true
	collectable = false

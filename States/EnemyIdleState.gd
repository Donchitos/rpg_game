extends State
class_name IdleState
@export var actor: enemy
@onready var player = get_node("Player")
@export var vision : RayCast2D
@onready var animTree: AnimationTree = $AnimationTree  # Replace with your actual reference
signal found_player


func enter_state() -> void:
	animTree.set("parameters/Idle/blend_position", actor.mov_direction)  # Set Idle animation blend position to 
	animTree.get("parameters/playback").travel("Idle")  # Play the Idle animation

func exit_state() -> void:
	# Put any cleanup logic here when exiting idle state
		if not vision.is_colliding():
			found_player.emit()

class_name EnemyChaseState extends State

@export var actor: enemy
@export var animTree: AnimationTree
@export var vision_cast: RayCast2D

signal lost_player

func _ready() -> void:
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animTree.get("parameters/playback").travel("Walk")  # Play the "move" animation

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	animTree.scale.x = -sign(actor.velocity.x)
	if animTree.scale.x == 0.0:
		animTree.scale.x = 1.0
	
	var direction = Vector2.ZERO.direction_to(actor.get_local_mouse_position())
	actor.velocity = actor.velocity.move_toward(direction * actor.Speed, actor.Acceleration * delta)
	actor.move_and_slide()
	
	if vision_cast.is_colliding():
		lost_player.emit()

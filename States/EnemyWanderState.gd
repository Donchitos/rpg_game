class_name EnemyWanderState extends State

@export var actor: enemy
@export var animTree: AnimationTree
@export var vision_cast: RayCast2D

signal found_player

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animTree.get("parameters/playback").travel("Walk")
	if actor.velocity == Vector2.ZERO:
		actor.velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * actor.Speed

func _exit_state() -> void:
	set_physics_process(false)
	animTree.get("parameters/playback").travel("Idle")  # Stop the animation when exiting the state

func _physics_process(delta):
	animTree.scale.x = -sign(actor.velocity.x)
	if animTree.scale.x == 0.0: animTree.scale.x = 1.0
	
	actor.velocity = actor.velocity.move_toward(actor.velocity.normalized() * actor.Speed, actor.Acceleration * delta)
	var collision = actor.move_and_collide(actor.velocity * delta)
	if collision:
		var bounce_velocity = actor.velocity.bounce(collision.get_normal())
		actor.velocity = bounce_velocity
	if not vision_cast.is_colliding():
		found_player.emit()

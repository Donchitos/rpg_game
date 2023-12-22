extends CharacterBody2D
class_name Enemy

@onready var animTree = $AnimationTree
var knockback_dir = Vector2.ZERO
var knockback = Vector2.ZERO
var mov_direction = Vector2()
var see_player = false
var is_attacking_player = false
var enemy_stats
var MeleeCombat = preload("res://MeleeCombatManager.gd").new()
var chase_detector_area
var attack_detector_area
var wander_radius = 100
var is_wandering = true
var is_chasing = false
var wander_target = Vector2.ZERO
var time_to_idle_min = 1.0
var time_to_idle_max = 3.0
var idle_time = 0.0
var attack_cooldown = 1.0
var time_since_last_attack = 0.0
@export var drop_table: DropTable

signal enemy_death(enemy,drop_table)



func _ready():
	var player = get_parent().get_node("Player")
	animTree.active = true
	enemy_stats = preload("res://Enemy/Lowly Slime/LowlySlimeStats.tres").duplicate() 
	chase_detector_area = $ChaseDetectorArea
	attack_detector_area = $AttackDetectorArea
	set_idle()
	
	
	if drop_table:
		print("Enemy has drop table assigned:", drop_table)
	else:
		print("Enemy's drop table is not assigned!")

func _physics_process(delta):
	if enemy_stats.Health <= 0:
		Death()
	time_since_last_attack += delta
	var player = get_parent().get_node("Player")
	if is_chasing:
		set_chasing(player)
	elif is_wandering:
		handle_wandering(delta)
	else:
		handle_idle(delta)
	if is_attacking_player and time_since_last_attack >= attack_cooldown:
		attack_player()
		time_since_last_attack = 0.0

	knockback_dir = mov_direction
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)


# Function to handle wandering behavior
func handle_wandering(delta):
	if is_near_wander_target():
		set_idle()
	else:
		var direction = (wander_target - position).normalized()
		velocity = direction * enemy_stats.Speed
		mov_direction = direction  # Update the mov_direction
		move_and_slide()

# Function to handle idle behavior
func handle_idle(delta):
	idle_time -= delta
	if idle_time <= 0:
		set_wandering()
		animTree.set("parameters/Idle/blend_position", mov_direction)

# Function to set the enemy in idle state
func set_idle():
	idle_time = randf_range(time_to_idle_min, time_to_idle_max)
	is_wandering = false
	animTree.get("parameters/playback").travel("Idle")
	animTree.set("parameters/Idle/blend_position", mov_direction)

# Function to set the enemy in wandering state
func set_wandering():
	wander_target = position + Vector2(randf_range(-wander_radius, wander_radius), randf_range(-wander_radius, wander_radius))
	is_wandering = true
	animTree.get("parameters/playback").travel("Walk")
	var direction = (wander_target - position).normalized()
	animTree.set("parameters/Walk/blend_position", direction)  # Set blend_position for wandering direction


# Function to move towards the wander target
func move_towards_wander_target(delta):
	var direction = (wander_target - position).normalized()
	velocity = direction * enemy_stats.Speed
	move_and_slide()

# Function to check if the enemy is near the wander target
func is_near_wander_target():
	return position.distance_to(wander_target) < 10

# Function to set the enemy in chasing state
func set_chasing(player):
	is_chasing = true
	is_wandering = false
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * enemy_stats.Speed
	mov_direction = direction
	move_and_slide()
	animTree.get("parameters/playback").travel("Walk")
	animTree.set("parameters/Walk/blend_position", direction)

# Function to attack the player
func attack_player():
	# Perform attack logic and animations
	animTree.get("parameters/playback").travel("Attack")
	animTree.set("parameters/Attack/blend_position", mov_direction)


func Death():
	enemy_death.emit(self,drop_table)
	queue_free()




func _on_chase_detector_body_entered(body):
	if body.name == "Player":
		set_chasing(body)

func _on_chase_detector_body_exited(body):
	if body.name == "Player":
		set_idle()
		is_chasing = false


func _on_attack_box_area_entered(area):
	if area.is_in_group("PlayerHurt"):  # Assuming the player's hitbox area is in the 'PlayerHurt' group
		var player = area.get_parent()  # Assuming the area's parent node is the player
		var accuracy = MeleeCombat.calculate_hit(enemy_stats, player.player_stats)
		var damage = MeleeCombat.calculate_damage(enemy_stats, player.player_stats)
		MeleeCombat.handle_damage(player.player_stats, damage)



func _on_hurt_box_area_entered(area):
	if area.is_in_group("PlayerAttack"):  # Assuming the player's attack box area is in the 'PlayerAttack' group
		var player = area.get_parent().get_parent().get_parent()  # Assuming the area's grandparent node is the player
		var accuracy = MeleeCombat.calculate_hit(player.player_stats, enemy_stats)
		var damage = MeleeCombat.calculate_damage(player.player_stats, enemy_stats)
		MeleeCombat.handle_damage(enemy_stats, damage)
		knockback = knockback.move_toward(Vector2.ZERO, 100)
		knockback = player.knockback_dir * player.player_stats.Knockback_Strength



func _on_attack_detector_body_entered(body):
	if body.name == "Player":
		is_chasing = false
		is_attacking_player = true
		is_wandering = false
		attack_player()



func _on_attack_detector_body_exited(body):
	if body.name == "Player":
		set_chasing(body)
		is_attacking_player = false



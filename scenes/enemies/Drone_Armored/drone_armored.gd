extends CharacterBody3D

@export var baseSpeed  : float = 1

var currentSpeed : float
var direction : Vector3 = Vector3.ZERO
var hitPoints : float = 30.0
var spawnLocation : Vector3
var collisionDamage : float = 35.0

const EXPLOSION = preload("res://scenes/FX/Explosions/DroneArmored/explosion_drone_armored.tscn")

@onready var navigator: NavigationAgent3D = $Navigator
@onready var main : Node3D = get_tree().get_root().get_node("Main")

func _ready() -> void:
	currentSpeed = baseSpeed
	global_position = spawnLocation

func _physics_process(delta: float) -> void:
	handle_pathfinding(delta)
	handle_movement_and_collision()

func handle_pathfinding(delta):
	if NavigationServer3D.map_get_iteration_id(navigator.get_navigation_map()) == 0:
	# Navigation map isn't ready; skip pathfinding this frame
		return
	var target : CharacterBody3D = get_tree().get_first_node_in_group("player")
	if target:
		navigator.target_position = target.global_position
		direction =  navigator.get_next_path_position() - global_position.normalized()
	if navigator.is_navigation_finished() == false:
		var next_position : Vector3 = navigator.get_next_path_position()
		direction = (next_position - global_position).normalized()
		velocity.x = direction.x * currentSpeed * delta
		velocity.z = direction.z * currentSpeed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, currentSpeed * delta)
		velocity.z = move_toward(velocity.z, 0, currentSpeed * delta)

func handle_movement_and_collision():
	var collision : KinematicCollision3D = move_and_collide(velocity)
	if collision:
		var collider : Node3D = collision.get_collider()
		if collider.is_in_group("player"):
			collider.take_damage(collisionDamage)
			handleDeath()

func take_damage(damageTaken : float):
	hitPoints -= damageTaken
	if hitPoints <= 0:
		handleDeath()

func handleDeath():
	ProgressionManager.increase_score(ProgressionManager.droneArmoredReward)
	spawnExplosion()
	queue_free()

func spawnExplosion():
	var instance = EXPLOSION.instantiate()
	instance.spawnPosition = global_position
	main.add_child.call_deferred(instance)

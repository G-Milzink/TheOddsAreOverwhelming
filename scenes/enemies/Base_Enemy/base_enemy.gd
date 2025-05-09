extends CharacterBody3D

@export var baseSpeed  : float = 1
@export var baseHitPoints : float = 10.0
@export var baseCollisionDamage : float = 15.0


var collisionDamage : float
var hitPoints : float
var currentSpeed : float
var direction : Vector3
var spawnLocation : Vector3

const EXPLOSION = preload("res://scenes/FX/Explosions/Drone/explosion_drone.tscn")

@onready var navigator: NavigationAgent3D = $Navigator
@onready var collider: CollisionShape3D = $Collider
@onready var main : Node3D = get_tree().get_root().get_node("Main")

func _ready() -> void:
	currentSpeed = baseSpeed * ProgressionManager.enemySpeedMultiplier
	collisionDamage = baseCollisionDamage * ProgressionManager.enemyDamageMultiplier
	hitPoints = baseHitPoints
	
	global_position = spawnLocation

func _physics_process(delta: float) -> void:
	handle_pathfinding(delta)
	handle_movement_and_collision()

func _process(_delta: float) -> void:
	if collider.disabled:
		collider.disabled = false

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
		var collisionObject : Node3D = collision.get_collider()
		if collisionObject.is_in_group("player"):
			collisionObject.takeDamage(collisionDamage)
			handleDeath()

func take_damage(damageTaken : float):
	hitPoints -= damageTaken
	if hitPoints <= 0:
		handleDeath()

func handleDeath():
	ProgressionManager.increase_score(ProgressionManager.droneReward)
	spawnExplosion()
	JuiceInjector.shakeCamera(0.2)
	queue_free()

func spawnExplosion():
	var instance = EXPLOSION.instantiate()
	instance.spawnPosition = global_position
	main.add_child.call_deferred(instance)

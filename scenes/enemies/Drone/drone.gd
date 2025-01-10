extends CharacterBody3D

@export var baseSpeed  : float = 1

var currentSpeed : float
var direction : Vector3 = Vector3.ZERO
var health : float = 10.0
var spawnLocation : Vector3

@onready var navigator: NavigationAgent3D = $Navigator
@onready var target : CharacterBody3D = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	currentSpeed = baseSpeed
	global_position = spawnLocation

func _physics_process(delta: float) -> void:
	handle_pathfinding_and_movement(delta)

func handle_pathfinding_and_movement(delta):
	if NavigationServer3D.map_get_iteration_id(navigator.get_navigation_map()) == 0:
	# Navigation map isn't ready; skip pathfinding this frame
		return
	if target:
		navigator.target_position = target.global_position
		direction =  navigator.get_next_path_position() - global_position.normalized()
	if navigator.is_navigation_finished() == false:
		var next_position = navigator.get_next_path_position()
		direction = (next_position - global_position).normalized()
		velocity.x = direction.x * currentSpeed * delta
		velocity.z = direction.z * currentSpeed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, currentSpeed * delta)
		velocity.z = move_toward(velocity.z, 0, currentSpeed * delta)
	move_and_collide(velocity)

func takeDamage(damageTaken : float):
	health -= damageTaken
	if health <= 0:
		queue_free()

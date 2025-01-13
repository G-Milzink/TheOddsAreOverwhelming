extends CharacterBody3D

@export var baseSpeed  : float = 1

var currentSpeed : float
var direction : Vector3 = Vector3.ZERO
var hitPoints : float = 10.0
var spawnLocation : Vector3
var collisionDamage : float = 35.0

@onready var navigator: NavigationAgent3D = $Navigator


func _ready() -> void:
	currentSpeed = baseSpeed
	global_position = spawnLocation

func _physics_process(delta: float) -> void:
	handle_pathfinding(delta)
	handle_rotation(delta)
	handle_movement_and_collision()
	
	

func handle_pathfinding(delta):
	if NavigationServer3D.map_get_iteration_id(navigator.get_navigation_map()) == 0:
		return
		
	var target : CharacterBody3D = get_tree().get_first_node_in_group("player")
	
	if target:
		navigator.target_position = target.global_position
		direction =  navigator.get_next_path_position() - global_position.normalized()
	if !navigator.is_navigation_finished():
		var next_position : Vector3 = navigator.get_next_path_position()
		direction = (next_position - global_position).normalized()
		velocity.x = direction.x * currentSpeed * delta
		velocity.z = direction.z * currentSpeed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, currentSpeed * delta)
		velocity.z = move_toward(velocity.z, 0, currentSpeed * delta)

func handle_rotation(delta):
	if direction.length() > 0.01: # Avoid jittering when the direction is too small
		var target_rotation: Vector3 = global_transform.basis.z.cross(Vector3.UP).normalized()
		rotation.y = lerp_angle(rotation.y, atan2(direction.x, direction.z), 3.5 * delta)

func handle_movement_and_collision():
	var collision : KinematicCollision3D = move_and_collide(velocity)
	if collision:
		var collider : Node3D = collision.get_collider()
		if collider.is_in_group("player"):
			collider.take_damage(collisionDamage)
			handle_death()

func take_damage(damageTaken : float):
	hitPoints -= damageTaken
	if hitPoints <= 0:
		handle_death()

func handle_death():
	queue_free()
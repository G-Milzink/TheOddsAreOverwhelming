extends CharacterBody3D

@export var  baseSpeed : float = 7.5

@onready var turret: Node3D = $Turret
@onready var camera: Camera3D = get_tree().get_first_node_in_group("camera")

var rayOrigin = Vector3()
var rayEnd = Vector3()
var mousePosition = Vector3()
var spaceState : PhysicsDirectSpaceState3D
var query :PhysicsRayQueryParameters3D
var intersection : Dictionary
var lookAtPosition = Vector3()

var currentSpeed : float

func _ready():
	currentSpeed = baseSpeed

func _process(_delta):
	pass

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	rotate_turret()



func handle_movement(delta):
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * currentSpeed * delta
		velocity.z = direction.z * currentSpeed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, currentSpeed * delta)
		velocity.z = move_toward(velocity.z, 0, currentSpeed * delta)
	move_and_collide(velocity)

func rotate_turret():
	spaceState = get_world_3d().direct_space_state
	mousePosition = get_viewport().get_mouse_position()
	
	rayOrigin = camera.project_ray_origin(mousePosition)
	rayEnd = rayOrigin + camera.project_ray_normal(mousePosition) * 2000
	query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	intersection = spaceState.intersect_ray(query)
	
	if intersection:
		lookAtPosition = intersection.position
		turret.look_at(Vector3(lookAtPosition.x,position.y,lookAtPosition.z), Vector3.UP)

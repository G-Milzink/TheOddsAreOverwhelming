extends CharacterBody3D

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var camera: Camera3D = get_tree().get_first_node_in_group("camera")
@onready var turret: Node3D = $Turret
@onready var projectileSpawn: Node3D = $Turret/projectile_spawn
@onready var projectileTimer: Timer = $ProjectileTimer

#RayCast variables:
var rayOrigin = Vector3()
var rayEnd = Vector3()
var mousePosition = Vector3()
var spaceState : PhysicsDirectSpaceState3D
var query :PhysicsRayQueryParameters3D
var intersection : Dictionary
var lookAtPosition = Vector3()
#Player variables:
var currentHitpoints : float
var currentSpeed : float
#Projectile variables:
var can_shoot : bool = true
var projectile : PackedScene 
var projectileInterval : float
#Shield  variables:
var hasShield : bool = false

const BULLET : PackedScene = preload("res://scenes/projectiles/player/player_bullet.tscn")
const TEMP_SHIELD = preload("res://scenes/shields/temp_shield/temp_shield.tscn")
#-------------------------------------------------------------------------------

func _ready():
	currentSpeed = PlayerData.baseSpeed
	currentHitpoints = PlayerData.maxHitpoints
	projectile = BULLET
	projectileInterval = PlayerData.projectileInterval

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	rotate_turret()

func _process(_delta):
	if Input.is_action_pressed("fire_weapon"):
		fire_projectile()

#-------------------------------------------------------------------------------

func handle_movement(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Calculate velocity based on input
	if direction:
		velocity.x = direction.x * currentSpeed
		velocity.z = direction.z * currentSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, currentSpeed * delta)
		velocity.z = move_toward(velocity.z, 0, currentSpeed * delta)

	# Perform movement
	var collision = move_and_collide(velocity * delta)

	if collision:
		# Get the collision normal and slide the velocity along it
		var collision_normal = collision.get_normal()
		velocity = velocity.slide(collision_normal)

		# Apply the adjusted velocity to continue sliding
		move_and_collide(velocity * delta)

func rotate_turret():
	spaceState = get_world_3d().direct_space_state
	mousePosition = get_viewport().get_mouse_position()
	
	rayOrigin = camera.project_ray_origin(mousePosition)
	rayEnd = rayOrigin + camera.project_ray_normal(mousePosition) * 2000
	
	query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	intersection = spaceState.intersect_ray(query)
	
	if intersection && !main.menu_is_open:
		lookAtPosition = intersection.position
		lookAtPosition.y = projectileSpawn.global_transform.origin.y  # Use global position for accuracy
		var direction = (lookAtPosition - turret.global_transform.origin).normalized()
		direction.y = 0
		turret.rotation.y = atan2(direction.x, direction.z)  # Rotate only on the Y-axis

func fire_projectile():
	if can_shoot && !main.menu_is_open :
		can_shoot = false
		var instance = projectile.instantiate()
		instance.spawnPosition = projectileSpawn.global_position
		instance.direction = (lookAtPosition - projectileSpawn.global_position).normalized()
		main.add_child.call_deferred(instance)
		projectileTimer.start(projectileInterval)

func _on_projectile_timer_timeout() -> void:
	can_shoot = true

func takeDamage(amount : float):
	currentHitpoints -= amount
	PlayerData.setCurrentHitPoints(currentHitpoints)
	if currentHitpoints <= 0:
		handle_death()

func healDamage(amount : float):
	currentHitpoints += amount
	if currentHitpoints > PlayerData.maxHitpoints:
		currentHitpoints = PlayerData.maxHitpoints
	PlayerData.setCurrentHitPoints(currentHitpoints)

func increaseFireRate():
	projectileInterval *= 0.9
	if projectileInterval < PlayerData.minProjectileInterval:
		projectileInterval = PlayerData.minProjectileInterval

func handle_death():
	queue_free()

func spawnTempShield():
	if !hasShield:
		hasShield = true
		var instance = TEMP_SHIELD.instantiate()
		add_child.call_deferred(instance)

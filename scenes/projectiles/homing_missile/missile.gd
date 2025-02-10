extends CharacterBody3D

@export var speed : float = 5.0
@export var launchDelay : float = 1.0
@export var launchOffset : float = 1.0


var direction : Vector3 
var camera : Camera3D
var launchTimer: Timer
var missileArray: Array
var launched: bool = false


@onready var main : Node3D = get_tree().get_root().get_node("Main")
var launcher : CharacterBody3D
const TARGET = preload("res://scenes/projectiles/homing_missile/missile_target.tscn")


func _ready() -> void:
	camera = get_tree().get_first_node_in_group("camera")
	launcher = get_tree().get_first_node_in_group("boss_teleport_launcher")
	launchTimer = $LaunchTimer
	startTimer()


func _physics_process(delta: float) -> void:
	if launched:
		direction = basis.z.normalized()
		velocity = direction * speed
		reparent_to_main(self)
		move_and_collide(velocity * delta)
		launcher = get_tree().get_first_node_in_group("boss_teleport_launcher")
		if camera && !is_visible_from_camera(camera):
			if launcher:
				launcher.nrOfMissiles -= 1
				spawnTarget()
				queue_free() 


func is_visible_from_camera(camera: Camera3D) -> bool:
	return camera.is_position_in_frustum(global_transform.origin)


func startTimer():
	launchDelay
	launchTimer.stop()
	launchTimer.start(launchDelay+launchOffset)


func _on_launch_timer_timeout() -> void:
	launched = true


func reparent_to_main(node: Node3D):
	if node.get_parent():  
		var global_transform_cache = node.global_transform  # Store world transform
		node.get_parent().remove_child(node)  # Detach from current parent
		main.add_child(node)  # Add to new parent
		node.global_transform = global_transform_cache  # Restore transform


func spawnTarget() -> void:
	var instance : Node3D = TARGET.instantiate() 
	main.add_child.call_deferred(instance)

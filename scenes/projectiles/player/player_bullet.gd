extends CharacterBody3D

@export var speed : float = 10
var direction : Vector3 = Vector3.ZERO
var spawn_position : Vector3 = Vector3.ZERO


func _ready():
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	global_position = spawn_position

func _physics_process(delta):
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_collide(velocity * delta)

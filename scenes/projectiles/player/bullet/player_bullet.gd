extends CharacterBody3D

@export var speed : float = 10
var currentDamage : float

var direction : Vector3 = Vector3.ZERO
var spawnPosition : Vector3 = Vector3.ZERO

func _ready():
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	global_position = spawnPosition
	currentDamage = PlayerData.baseDamage * PlayerData.damageMultiplier

func _physics_process(delta):
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("enemies"):
			collider.take_damage(currentDamage)
		queue_free()

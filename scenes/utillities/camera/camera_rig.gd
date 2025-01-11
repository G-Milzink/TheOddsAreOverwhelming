extends CharacterBody3D

@export var followSpeed: float = 19.5
@export var baseCameraHeight: float = 2.9


var player : CharacterBody3D
var direction : Vector3
var velocityFactor : float = 2.0

func _ready() -> void:
	position.y = baseCameraHeight


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player = get_tree().get_first_node_in_group("player")
	if player:
		direction = (player.position - position).normalized() * velocityFactor
		velocity.x = direction.x * followSpeed * delta
		velocity.z = direction.z * followSpeed * delta
	move_and_collide(velocity)

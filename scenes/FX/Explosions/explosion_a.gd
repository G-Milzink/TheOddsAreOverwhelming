extends Node3D

var spawnPosition : Vector3

@onready var debris: GPUParticles3D = $Debris
@onready var smoke: GPUParticles3D = $Smoke
@onready var fire: GPUParticles3D = $Fire

func _ready() -> void:
	global_position = spawnPosition
	explode()


func explode():
	debris.emitting = true
	smoke.emitting = true
	fire.emitting = true
	await get_tree().create_timer(2.0).timeout
	queue_free()

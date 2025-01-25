extends Node3D

var spawnPosition : Vector3 = Vector3.ZERO


@onready var smoke: GPUParticles3D = $Smoke
@onready var fire: GPUParticles3D = $Fire


func _ready() -> void:
	smoke.emitting = true
	fire.emitting = true

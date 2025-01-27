extends Node3D

@onready var fase_1: GPUParticles3D = $fase_1
@onready var fase_2: GPUParticles3D = $fase_2

@export var enemyToSpawn : PackedScene

func _ready() -> void:
	fase_1.emitting = true
	fase_2.emitting = false

func _on_spawn_in_timer_timeout() -> void:
	fase_1.emitting = false
	fase_2.emitting = true


func _on_fase_2_finished() -> void:
	print("finished spawning")

extends Node3D

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var debrisUniversal: GPUParticles3D = $DebrisUniversal
@onready var debrisUnique1: GPUParticles3D = $DebrisUnique1
@onready var debrisUnique2: GPUParticles3D = $DebrisUnique2
@onready var smoke: GPUParticles3D = $Smoke
@onready var fire: GPUParticles3D = $Fire
@onready var audioFx: AudioStreamPlayer3D = $AudioFx

func _ready() -> void:
	explode()


func explode():
	debrisUniversal.emitting = true
	smoke.emitting = true
	fire.emitting = true
	
	debrisUnique1.emitting = true
	debrisUnique2.emitting = true
	
	audioFx.play()
	
	await get_tree().create_timer(2.0).timeout
	queue_free()

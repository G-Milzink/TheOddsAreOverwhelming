extends Node3D

var player : CharacterBody3D
var following : bool

@onready var crossHair: Node3D = $CrossHair
@onready var blastArea: Area3D = $BlastArea
@onready var beam: GPUParticles3D = $Beam

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	EnemySpawner.canSpawnOrbitalCannon = false
	position = player.global_position
	crossHair.visible = true
	beam.emitting = false
	following = true

func _process(delta: float) -> void:
	if following && player:
		position = player.global_position

func _on_follow_timer_timeout() -> void:
	following = false

func _on_blast_timer_timeout() -> void:
	crossHair.visible = false
	beam.emitting = true
	if blastArea.overlaps_body(player):
		player.takeDamage(50.0)

func _on_beam_finished() -> void:
	EnemySpawner.canSpawnOrbitalCannon = true
	queue_free()

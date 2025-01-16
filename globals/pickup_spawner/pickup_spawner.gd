extends Node

@export var canSpawnPickups : bool = true

var spawnTimer : Timer
var spawnInterval : float
var spawnX : float
var spawnZ : float
var randomSpawnLocation : Vector3
var instance : Node3D

const BLUE_CRYSTAL : PackedScene = preload("res://scenes/pickups/crystals/blue/blue_crystal.tscn")

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var player : Node3D = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	spawnTimer = Timer.new()
	add_child(spawnTimer)
	spawnTimer.timeout.connect(onTimeout)
	spawnInterval = randf_range(0.5, 2.0)
	spawnTimer.start(spawnInterval)

func onTimeout():
	spawnPickup()
	spawnInterval = randf_range(5.0, 20.0)
	spawnTimer.start(spawnInterval)

func spawnPickup():
	if canSpawnPickups:
		spawnBlueCrystal()

func spawnBlueCrystal():
	instance = BLUE_CRYSTAL.instantiate()
	while true:
		spawnX = randf_range(-5.0, 5.0) * 2 + player.position.x
		if spawnX < -2.0 or spawnX > 2.0:
			break
	while true:
		spawnZ = randf_range(-5.0, 5.0) * 2 + player.position.z
		if spawnZ < -2.0 or spawnZ > 2.0:
			break
	randomSpawnLocation = Vector3(spawnX, 0.2, spawnZ)
	instance.spawnLocation = randomSpawnLocation
	main.add_child.call_deferred(instance)

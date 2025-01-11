extends Node3D

@export var canSpawn = true
@export var spawnInterval : float = 2.0

var spawnPointList
var randomNumberGenerator = RandomNumberGenerator.new()
var randomNumber : int
var spawn_timer: Timer

const DRONE = preload("res://scenes/enemies/Drone/drone.tscn")
const DART = preload("res://scenes/enemies/Dart/dart.tscn")

@onready var main : Node3D = get_tree().get_root().get_node("Main")

#-------------------------------------------------------------------------------

func _ready() -> void:
	randomNumberGenerator.randomize()
	spawnPointList = get_tree().get_nodes_in_group("spawnpoints")
	spawn_timer = get_node("SpawnTimer")
	spawn_timer.set_wait_time(spawnInterval)
	if canSpawn:
		spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	spawnDart()

func spawnDrone():
	randomNumber = randomNumberGenerator.randi() % spawnPointList.size()
	var spawnLocation = spawnPointList[randomNumber].position
	var instance = DRONE.instantiate()
	instance.spawnLocation = spawnLocation
	main.add_child.call_deferred(instance)

func spawnDart():
	randomNumber = randomNumberGenerator.randi() % spawnPointList.size()
	var spawnLocation = spawnPointList[randomNumber].position
	var instance = DART.instantiate()
	instance.spawnLocation = spawnLocation
	main.add_child.call_deferred(instance)

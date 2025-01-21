extends Node

@export var canSpawn = true

var spawnPointList : Array
var randomSpawnPoint : int
var randomEnemy : int
var spawnTimer: Timer
var spawnInterval : float

var randomNumberGenerator = RandomNumberGenerator.new()
var waveNumber : int = 1
var canSpawnOrbitalCannon : bool = true

const DRONE : PackedScene = preload("res://scenes/enemies/Drone/drone.tscn")
const DART : PackedScene = preload("res://scenes/enemies/Dart/dart.tscn")
const DRONE_ARMORED : PackedScene = preload("res://scenes/enemies/Drone_Armored/drone_armored.tscn")
const ORBITAL_CANNON : PackedScene = preload("res://scenes/enemies/Orbital_Canon/orbital_cannon.tscn")

@onready var main : Node3D = get_tree().get_root().get_node("Main")

func _ready() -> void:
	spawnTimer = Timer.new()
	add_child(spawnTimer)
	spawnTimer.timeout.connect(onTimeout)
	spawnInterval = ProgressionManager.spawnInterval
	randomNumberGenerator.randomize()
	spawnPointList = get_tree().get_nodes_in_group("spawnpoints")
	if canSpawn:
		spawnTimer.start(spawnInterval)

func onTimeout() -> void:
	spawnEnemy()

func spawnEnemy():
	waveNumber = ProgressionManager.currentWave
	spawnInterval = ProgressionManager.spawnInterval
	match waveNumber:
		1:
			handleWave1()
		2:
			handleWave2()
		3:
			handleWave3()
		4:
			handleWave4()
	spawnTimer.start(spawnInterval)

#region Wave Handlers
func handleWave1():
	spawnDrone()

func handleWave2():
	randomEnemy = randi() % 100
	if (randomEnemy >= 70):
		spawnDart()
	else:
		spawnDrone()

func handleWave3():
	randomEnemy = randi() % 100
	if (randomEnemy >= 70):
		spawnDart()
		return
	if (randomEnemy >= 35):
		spawnDroneArmored()
	else:
		spawnDrone()

func handleWave4():
	randomEnemy = randi() % 100
	if (randomEnemy >= 75):
		if EnemySpawner.canSpawnOrbitalCannon == true:
			spawnOrbitalCannon()
		else:
			spawnDroneArmored()
		return
	if (randomEnemy >= 50):
		spawnDart()
		return
	if (randomEnemy >= 20):
		spawnDroneArmored()
	else:
		spawnDrone()
#endregion

#region Spawn Functions
func spawnDrone():
	randomSpawnPoint = randomNumberGenerator.randi() % spawnPointList.size()
	var spawnLocation = spawnPointList[randomSpawnPoint].position
	var instance = DRONE.instantiate()
	instance.spawnLocation = spawnLocation
	main.add_child.call_deferred(instance)

func spawnDart():
	randomSpawnPoint = randomNumberGenerator.randi() % spawnPointList.size()
	var spawnLocation = spawnPointList[randomSpawnPoint].position
	var instance = DART.instantiate()
	instance.spawnLocation = spawnLocation
	main.add_child.call_deferred(instance)

func spawnDroneArmored():
	randomSpawnPoint = randomNumberGenerator.randi() % spawnPointList.size()
	var spawnLocation = spawnPointList[randomSpawnPoint].position
	var instance = DRONE_ARMORED.instantiate()
	instance.spawnLocation = spawnLocation
	main.add_child.call_deferred(instance)

func spawnOrbitalCannon():
	randomSpawnPoint = randomNumberGenerator.randi() % spawnPointList.size()
	var instance = ORBITAL_CANNON.instantiate()
	main.add_child.call_deferred(instance)
#endregion

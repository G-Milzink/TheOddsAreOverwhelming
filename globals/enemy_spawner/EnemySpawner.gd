extends Node

@export var canSpawn = true

var spawnPointList
var randomNumberGenerator = RandomNumberGenerator.new()
var randomSpawnPoint : int
var randomEnemy : int
var spawnTimer: Timer
var spawnInterval : float
var waveNumber : int = 1

const DRONE = preload("res://scenes/enemies/Drone/drone.tscn")
const DART = preload("res://scenes/enemies/Dart/dart.tscn")
const DRONE_ARMORED = preload("res://scenes/enemies/Drone_Armored/drone_armored.tscn")

@onready var main : Node3D = get_tree().get_root().get_node("Main")

#-------------------------------------------------------------------------------

func _ready() -> void:
	spawnTimer = Timer.new()
	add_child(spawnTimer)
	spawnTimer.timeout.connect(onTimeout)
	spawnInterval = ProgressionManager.spawnDelay
	randomNumberGenerator.randomize()
	spawnPointList = get_tree().get_nodes_in_group("spawnpoints")
	if canSpawn:
		spawnEnemy()
		spawnTimer.start(spawnInterval)

func onTimeout() -> void:
	spawnEnemy()


func spawnEnemy():
	waveNumber = ProgressionManager.currentWave
	spawnInterval = ProgressionManager.spawnDelay
	match waveNumber:
		1:
			handleWave1()
		2:
			handleWave2()
		3:
			handleWave3()
	spawnTimer.start(spawnInterval)


#region Wave Handlers
func handleWave1():
	spawnDrone()

func handleWave2():
	randomEnemy = randi() % 100
	if (randomEnemy < 25):
		spawnDart()
	else:
		spawnDrone()

func handleWave3():
	randomEnemy = randi() % 100
	if (randomEnemy < 25):
		spawnDart()
	if (randomEnemy < 50):
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
#endregion
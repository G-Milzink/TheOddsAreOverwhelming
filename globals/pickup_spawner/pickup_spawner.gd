extends Node

@export var canSpawnPickups : bool = true
@export var SpawnIntervalMin: float = 5.0
@export var SpawnIntervalMax: float = 15.0

var spawnTimer : Timer
var spawnInterval : float
var spawnX : float
var spawnZ : float
var randomSpawnLocation : Vector3
var instance_rng : int
var instance : Node3D

const WHITE_CRYSTAL : PackedScene = preload("res://scenes/pickups/crystals/white/white_crystal.tscn")
const BLUE_CRYSTAL : PackedScene = preload("res://scenes/pickups/crystals/blue/blue_crystal.tscn")
const RED_CRYSTAL : PackedScene = preload("res://scenes/pickups/crystals/red/red_crystal.tscn")
const YELLOW_CRYSTAL : PackedScene = preload("res://scenes/pickups/crystals/yellow/yellow_crystal.tscn")
const GREEN_CRYSTAL : PackedScene = preload("res://scenes/pickups/crystals/green/green_crystal.tscn")

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var player : Node3D = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	spawnTimer = Timer.new()
	add_child(spawnTimer)
	spawnTimer.timeout.connect(onTimeout)
	spawnInterval = randf_range(1.0, 3.0)
	spawnTimer.start(spawnInterval)

func onTimeout():
	spawnPickup()
	spawnInterval = randf_range(SpawnIntervalMin, SpawnIntervalMax)
	spawnTimer.start(spawnInterval)

func spawnPickup():
	if !player:
		player = get_tree().get_first_node_in_group("player")
	if canSpawnPickups && player:
		instance = selectPickup().instantiate()
		while true:
			spawnX = randf_range(-4.0, 4.0) * 2 + player.position.x
			if spawnX < -3.0 or spawnX > 3.0:
				break
		while true:
			spawnZ = randf_range(-7.0, 7.0) * 2 + player.position.z
			if spawnZ < -6.0 or spawnZ > 6.0:
				break
		randomSpawnLocation = Vector3(spawnX, 0.2, spawnZ)
		instance.spawnLocation = randomSpawnLocation
		main.add_child.call_deferred(instance)

func selectPickup():
	instance_rng = randi() % 100
	var crystals = [
		{"threshold": 90.0, "crystal": RED_CRYSTAL},
		{"threshold": 80.0, "crystal": YELLOW_CRYSTAL},
		{"threshold": 65.0, "crystal": GREEN_CRYSTAL},
		{"threshold": 50.0, "crystal": BLUE_CRYSTAL},
		{"threshold": 0.0, "crystal": WHITE_CRYSTAL}
	]
	for crystal_data in crystals:
		if instance_rng >= crystal_data["threshold"]:
			if crystal_data["crystal"] == BLUE_CRYSTAL and player.hasShield:
				print("Blue pickup canceled")
				return WHITE_CRYSTAL
			if crystal_data["crystal"] == GREEN_CRYSTAL and player.currentHitpoints == PlayerData.baseHitpoints:
				print("Green pickup canceled")
				return WHITE_CRYSTAL
			return crystal_data["crystal"]
	return null  # Fallback in case no crystal is matched (shouldn't happen)

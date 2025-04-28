extends Node

var NOTHING: PackedScene
const TELEPORT_LAUNCHER = preload("res://scenes/bosses/teleport_launcher/teleport_launcher.tscn")

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var player : Node3D = get_tree().get_first_node_in_group("player")

func SpawnNextBoss():
	print_debug("SpawnNextBoss")
	spawnBoss(ProgressionManager.nextBossNumber)
	ProgressionManager.nextBossNumber += 1

func selectBoss(bossNumber: int) -> PackedScene:
	print_debug("selectBoss")
	match bossNumber:
		1:
			return TELEPORT_LAUNCHER
	return NOTHING

func spawnBoss(bossNumber: int) -> void:
	var instance = selectBoss(bossNumber).instantiate()
	instance.spawnLocation = Vector3(10, 0 ,20)
	main.add_child.call_deferred(instance)

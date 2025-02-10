extends CharacterBody3D

@export var baseHitpoints : float = 200

var hitpoints: float
var lookDirection : Vector3
var player:CharacterBody3D

var nrOfMissiles : int = 6
var canTeleport : bool = false
var isTeleporting: bool = false
var isFirstSpawn: bool = true
var collisionDamage : float = 15.0
var noVelocity: Vector3 = Vector3.ZERO

@onready var radar: Node3D = $Radar
@onready var teleportDelay: Timer = $TeleportDelay
@onready var main : Node3D = get_tree().get_root().get_node("Main")

const SELF_RESPAWN = preload("res://scenes/bosses/teleport_launcher/teleport_launcher.tscn")

func _ready() -> void:
	if isFirstSpawn:
		hitpoints = baseHitpoints
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	rotateTowardsPlayer()
	manageState()

func rotateTowardsPlayer():
	player = get_tree().get_first_node_in_group("player")
	if player:
		look_at_from_position(position, player.position)

func manageState():
	if !canTeleport && nrOfMissiles <= 0:
		canTeleport = true
		var rnd_time : float = randf_range(1.5,3.0)
		teleportDelay.start(rnd_time)

func _on_teleport_delay_timeout():
	teleport()

func teleport() :
	if isTeleporting:
		return
	isTeleporting = true
	canTeleport=false
	
	var rng_x : float = randf_range(1.0, 2.0) * 5.0 * randomSign(50)
	var rng_z : float = randf_range(1.0, 2.0) * 5.0 * randomSign(50)
	var position_offset : Vector3 = Vector3(rng_x, 0.0, rng_z)
	var target_location : Vector3 = player.position + position_offset
	
	var instance : CharacterBody3D = SELF_RESPAWN.instantiate()
	instance.position = target_location
	instance.isFirstSpawn = false
	instance.hitpoints = hitpoints
	
	var missileArray : Array = get_tree().get_nodes_in_group("boss_teleporter_launcher_missile")
	for missile in missileArray:
		queue_free()
	
	main.add_child.call_deferred(instance)
	await get_tree().create_timer(0.5).timeout
	queue_free()
	isTeleporting = false


func randomSign(plusChance : int) -> int:
	var rndSign : int = randi() % 100
	if rndSign <= plusChance:
		return 1
	return -1


func take_damage(damageTaken : float):
	hitpoints -= damageTaken
	if hitpoints <= 0:
		handleDeath()


func handleDeath():
	JuiceInjector.shakeCamera(0.2)
	queue_free()

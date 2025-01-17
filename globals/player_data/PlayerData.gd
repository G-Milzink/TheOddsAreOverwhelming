extends Node

@export var baseSpeed : float = 12.5
@export var baseDamage : float = 10.0
@export var baseHitpoints : float =  100.0

var speedFactor : float = 1
var damageFactor : float = 1
var playerHealthBar: ProgressBar 
var currentHitPoints : float

func _ready() -> void:
	playerHealthBar = get_tree().get_first_node_in_group("PlayerHealthBar")
	currentHitPoints = baseHitpoints
	playerHealthBar.set_value(currentHitPoints)

func setCurrentHitPoints(amount: float):
	currentHitPoints = amount;
	playerHealthBar.set_value(currentHitPoints)

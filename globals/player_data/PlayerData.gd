extends Node

var baseSpeed : float = 12.5
var baseDamage : float = 10.0
var maxHitpoints : float = 100.0
var currentHitPoints : float = 100.0

var damageMultiplier : float = 1.0
var maxDamageMultiplier : float = 2.0
var playerHealthBar: ProgressBar 

var projectileInterval : float = 0.4
const minProjectileInterval : float = 0.1

func _ready() -> void:
	playerHealthBar = get_tree().get_first_node_in_group("PlayerHealthBar")
	playerHealthBar.set_value(currentHitPoints)

func setCurrentHitPoints(amount: float):
	currentHitPoints = amount;
	playerHealthBar.set_value(currentHitPoints)

func increaseDamage():
	damageMultiplier += 5.0
	if damageMultiplier > maxDamageMultiplier:
		damageMultiplier = maxDamageMultiplier
	print(damageMultiplier)

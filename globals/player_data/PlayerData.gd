extends Node

var baseSpeed : float = 12.5
var baseDamage : float = 10.0
var maxHitpoints : float = 100.0
var currentHitPoints : float = 100.0

var damageMultiplier : float
const BASE_DAMAGE_MULTIPLIER : float = 1.0
var maxDamageMultiplier : float = 5.0
var playerHealthBar: ProgressBar 

var baseProjectileInterval : float = 0.6
var projectileInterval : float
const minProjectileInterval : float = 0.1

func _ready() -> void:
	playerHealthBar = get_tree().get_first_node_in_group("PlayerHealthBar")
	playerHealthBar.set_value(currentHitPoints)
	projectileInterval = baseProjectileInterval
	damageMultiplier = BASE_DAMAGE_MULTIPLIER

func reset():
	currentHitPoints = maxHitpoints
	playerHealthBar.set_value(currentHitPoints)
	projectileInterval = baseProjectileInterval
	damageMultiplier = BASE_DAMAGE_MULTIPLIER

func setCurrentHitPoints(amount: float):
	currentHitPoints = amount;
	playerHealthBar.set_value(currentHitPoints)

func increaseDamage():
	damageMultiplier += 1.0
	if damageMultiplier > maxDamageMultiplier:
		damageMultiplier = maxDamageMultiplier

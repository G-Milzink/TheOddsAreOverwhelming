extends Node3D

var canDoDamage : bool = true
var touchingPlayer : bool = false

@onready var beam: GPUParticles3D = $beam
@onready var cannonImpact: Node3D = $CannonImpact
@onready var collider: CollisionShape3D = $HitBox/Collider
@onready var damageTimer: Timer = $DamageTimer
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	beam.visible = false
	cannonImpact.visible = false
	collider.set_disabled(true)

func _process(delta: float) -> void:
		doDamage()

func fireCannon(firing : bool):
	if firing:
		beam.visible = true
		cannonImpact.visible = true
		collider.set_deferred("disabled", false)
	else:
		beam.visible = false
		cannonImpact.visible = false
		collider.set_deferred("disabled", true)


func _on_hit_box_body_entered(body: Node3D) -> void:
	touchingPlayer = true


func _on_hit_box_body_exited(body: Node3D) -> void:
	touchingPlayer = false

func doDamage():
	if canDoDamage && touchingPlayer:
		canDoDamage = false
		player.takeDamage(2.5)
		damageTimer.start()

func _on_damage_timer_timeout() -> void:
	canDoDamage = true 

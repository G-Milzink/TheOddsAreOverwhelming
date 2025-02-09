extends Node3D

var player : CharacterBody3D

@onready var crossHair: Node3D = $CrossHair
@onready var timer: Timer = $Timer
@onready var hitArea: Area3D = $HitArea
@onready var main : Node3D = get_tree().get_root().get_node("Main")

const EXPLOSION = preload("res://scenes/FX/Explosions/Missile/missile_explosion.tscn")

func _ready() -> void:
	hitArea.set_monitoring(false)
	player = get_tree().get_first_node_in_group("player")
	if player:
		position=player.position
	crossHair.visible = true
	timer.start()

func _on_timer_timeout() -> void:
	hitArea.set_monitoring(true)
	var instance : Node3D = EXPLOSION.instantiate()
	instance.position = position
	main.add_child.call_deferred(instance)
	await get_tree().create_timer(.5).timeout
	queue_free()

func _on_hit_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("Hit!")
		body.takeDamage(25.0)

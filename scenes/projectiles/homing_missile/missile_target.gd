extends Node3D

@onready var crossHair: Node3D = $CrossHair

func _ready() -> void:
	var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
	position=player.position
	crossHair.visible = true

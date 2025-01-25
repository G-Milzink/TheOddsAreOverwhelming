extends Control

@onready var main : Node3D = get_tree().get_root().get_node("Main")

func _on_back_pressed() -> void:
	main.closeOptionsMenu()

extends Control


@onready var background: TextureRect = $BackGround



func _on_start_pressed() -> void:
	visible = false
	Engine.time_scale = 1


func _on_exit_pressed() -> void:
	get_tree().quit()

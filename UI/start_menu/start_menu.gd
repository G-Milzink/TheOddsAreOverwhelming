extends Control


@onready var background: TextureRect = $BackGround
@onready var main : Node3D = get_tree().get_root().get_node("Main")



func _on_start_pressed() -> void:
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED 
	Engine.time_scale = 1
	main.menu_is_open = false


func _on_exit_pressed() -> void:
	get_tree().quit()

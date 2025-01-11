extends Node3D

var menu_is_open : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		handle_menu()

func handle_menu():
	if menu_is_open:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED 
		Engine.time_scale = 1
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Engine.time_scale = 0
	menu_is_open = !menu_is_open

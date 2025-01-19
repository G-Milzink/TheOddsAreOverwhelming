extends Node3D

var menu_is_open : bool = false
var player : CharacterBody3D

@onready var pauseMenu: Control = $CanvasLayer/PauseMenu


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	Engine.time_scale = 0

func _process(_delta: float) -> void:
	player = get_tree().get_first_node_in_group("player")
	if !player:
		Engine.time_scale = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		handle_menu()

func handle_menu():
	if menu_is_open:
		pauseMenu.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED 
		Engine.time_scale = 1
	else:
		pauseMenu.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Engine.time_scale = 0
	menu_is_open = !menu_is_open

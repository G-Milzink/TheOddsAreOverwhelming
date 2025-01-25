extends Control


@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var startGame: TextureButton = $VBox/Start
@onready var continueGame : TextureButton = $VBox/Continue
@onready var login: TextureButton = $VBox/Login
@onready var logout: TextureButton = $VBox/Logout


func _process(delta: float) -> void:
	handleGameStates()

func handleGameStates():
	if main.inGame:
		startGame.visible = false
		continueGame.visible = true
	else:
		startGame.visible = true
		continueGame.visible = false
	
	if main.loggedIn:
		login.visible = false
		logout.visible = true
	else:
		login.visible = true
		logout.visible = false
	
	if main.inGame:
		login.disabled = true
		logout.disabled = true
	else:
		login.disabled = false
		logout.disabled = false


func _on_start_pressed() -> void:
	main.startGame()

func _on_continue_pressed() -> void:
	main.continueGame()


func _on_leader_boards_pressed() -> void:
	pass # Replace with function body.

func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_login_pressed() -> void:
	main.openLoginMenu()


func _on_logout_pressed() -> void:
	main.loggedIn = false
	main.openLoginMenu()


func _on_exit_pressed() -> void:
	get_tree().quit()

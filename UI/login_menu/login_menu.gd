extends Control

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var login: TextureButton = $VBox/Login
@onready var signUp: TextureButton = $VBox/SignUp

func _ready() -> void:
	if !main.isApiOnline():
		login.set_disabled(true)
		signUp.set_disabled(true)


func _on_login_pressed() -> void:
	main.openLoginForm()

func _on_sign_up_pressed() -> void:
	main.openSignUpForm()


func _on_offline_pressed() -> void:
	main.playOffline()

func _on_exit_pressed() -> void:
	get_tree().quit()

extends Control

@onready var main : Node3D = get_tree().get_root().get_node("Main")

func _on_login_pressed() -> void:
	main.openLoginForm()

func _on_sign_up_pressed() -> void:
	main.openSignUpForm()


func _on_offline_pressed() -> void:
	main.playOffline()

func _on_exit_pressed() -> void:
	get_tree().quit()

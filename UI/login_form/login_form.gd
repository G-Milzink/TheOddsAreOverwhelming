extends Control

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var playerId: LineEdit = $MenuPanel/VBox/PlayerId
@onready var password: LineEdit = $MenuPanel/VBox/Password



func _on_submit_pressed() -> void:
	print("PlayerId: ",playerId.get_text())
	print("Password: ",password.get_text())

func _on_back_pressed() -> void:
	main.openLoginMenu()
 

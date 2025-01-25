extends Control

var enableRetrieval : bool

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var playerId: LineEdit = $MenuPanel/VBox/PlayerId
@onready var password: LineEdit = $MenuPanel/VBox/Password
@onready var password_retrieval: CheckBox = $MenuPanel/VBox/PasswordRetrieval
@onready var emailAdress: LineEdit = $MenuPanel/VBox/EmailAdress

func _ready() -> void:
	enableRetrieval = false
	emailAdress.visible = false

func _on_password_retrieval_toggled(toggled_on: bool) -> void:
	emailAdress.visible = toggled_on
	enableRetrieval = toggled_on

func _on_submit_pressed() -> void:
	print("PlayerId: ",playerId.get_text())
	print("Password: ",password.get_text())
	if enableRetrieval:
		print("Email: ",emailAdress.get_text())

func _on_back_pressed() -> void:
	main.openLoginMenu()

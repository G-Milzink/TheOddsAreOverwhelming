extends Node3D

var inMenu : bool
var inGame : bool
var loggedIn : bool

@onready var backGround: TextureRect = $MenuLayer/BackGround
@onready var loginMenu: Control = $MenuLayer/LoginMenu
@onready var loginForm: Control = $MenuLayer/LoginForm
@onready var signUpForm: Control = $MenuLayer/SignUpForm
@onready var mainMenu: Control = $MenuLayer/MainMenu

func _ready() -> void:
	Engine.time_scale = 0.0
	inMenu = true
	inGame = false
	loggedIn = false
	backGround.visible = true
	loginMenu.visible = true
	loginForm.visible = false
	signUpForm.visible = false
	mainMenu.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		if !inMenu:
			print("open")
			openMainMenu()
			return
		if inGame && inMenu:
			print("close")
			continueGame()
			return

func startGame():
	mainMenu.visible = false
	backGround.visible = false
	inMenu = false
	inGame = true
	Engine.time_scale = 1.0

func continueGame():
	mainMenu.visible = false
	backGround.visible = false
	inMenu = false
	inGame = true
	Engine.time_scale = 1.0

#-------------------------------------------------------------------------------

func openLoginMenu():
	loginMenu.visible = true
	mainMenu.visible = false
	loginForm.visible = false
	signUpForm.visible = false

func openLoginForm():
	loginMenu.visible = false
	loginForm.visible = true

func openSignUpForm():
	loginMenu.visible = false
	signUpForm.visible = true

func playOffline():
	loggedIn = false
	loginMenu.visible = false
	loginForm.visible = false
	openMainMenu()
#-------------------------------------------------------------------------------

func openMainMenu():
	mainMenu.visible = true
	inMenu = true
	if Engine.time_scale > 0:
		Engine.time_scale = 0

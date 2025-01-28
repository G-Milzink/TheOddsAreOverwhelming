extends Node3D

var inMenu : bool
var inGame : bool
var loggedIn : bool

@onready var backGround: TextureRect = $MenuLayer/BackGround
@onready var loginMenu: Control = $MenuLayer/LoginMenu
@onready var loginForm: Control = $MenuLayer/LoginForm
@onready var signUpForm: Control = $MenuLayer/SignUpForm
@onready var mainMenu: Control = $MenuLayer/MainMenu
@onready var optionsMenu: Control = $MenuLayer/OptionsMenu
@onready var audioMenu: Control = $MenuLayer/AudioMenu


@onready var hud: Control = $MenuLayer/HUD
@onready var runTimer : Timer = get_tree().get_first_node_in_group("runtimer")
@onready var map: Node3D = $Map

const PLAYER = preload("res://scenes/player/player.tscn")

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
	optionsMenu.visible = false
	audioMenu.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		if !inMenu:
			openMainMenu()
			return
		if inGame && inMenu:
			continueGame()
			return

func startGame():
	backGround.visible = false
	mainMenu.visible = false
	loginMenu.visible = false
	loginForm.visible = false
	signUpForm.visible = false
	optionsMenu.visible = false
	audioMenu.visible = false
	inMenu = false
	inGame = true
	intializeGame()
	Engine.time_scale = 1.0

func continueGame():
	backGround.visible = false
	mainMenu.visible = false
	loginMenu.visible = false
	loginForm.visible = false
	signUpForm.visible = false
	optionsMenu.visible = false
	audioMenu.visible = false
	inMenu = false
	inGame = true
	Engine.time_scale = 1.0

func intializeGame():
	EnemySpawner.despawnAllEnemies()
	ProgressionManager.reset()
	hud.reset()
	var instance = PLAYER.instantiate()
	map.add_child(instance)
	runTimer.start()
	
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
	if !inGame:
		backGround.visible = true
	loginMenu.visible = true
	loginForm.visible = false
	signUpForm.visible = false
	optionsMenu.visible = false
	audioMenu.visible = false
	inMenu = true
	if Engine.time_scale > 0:
		Engine.time_scale = 0

func openOptionsMenu():
	optionsMenu.visible = true
	mainMenu.visible = false

func closeOptionsMenu():
	optionsMenu.visible = false
	mainMenu.visible = true

func openAudioMenu():
	optionsMenu.visible = false
	audioMenu.visible = true

func closeAudioMenu():
	optionsMenu.visible = true
	audioMenu.visible = false

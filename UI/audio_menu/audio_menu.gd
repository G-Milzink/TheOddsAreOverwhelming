extends Control

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var musicSlider: HSlider = $VBox/MusicSlider
@onready var fxSlider: HSlider = $VBox/FXSlider
@onready var uiSlider: HSlider = $VBox/UISlider


var masterBusIndex : int
var musicBusIndex : int
var effectsBusIndex : int
var uiBusIndex : int

var settings : Dictionary

func _ready() -> void:
	musicBusIndex = AudioServer.get_bus_index("Music")
	effectsBusIndex = AudioServer.get_bus_index("FX")
	uiBusIndex = AudioServer.get_bus_index("UI")
	masterBusIndex = AudioServer.get_bus_index("Master")
	print(OS.get_data_dir())
	loadSettings()

func loadSettings():
	settings = SettingsManager.loadAudioSettings()
	AudioServer.set_bus_volume_db(musicBusIndex, linear_to_db(settings.get("MusicVolume")))
	musicSlider.set_value_no_signal(settings.get("MusicVolume"))
	AudioServer.set_bus_volume_db(effectsBusIndex, linear_to_db(settings.get("FxVolume")))
	fxSlider.set_value_no_signal(settings.get("FxVolume"))
	AudioServer.set_bus_volume_db(uiBusIndex, linear_to_db(settings.get("UiVolume")))
	uiSlider.set_value_no_signal(settings.get("UiVolume"))

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musicBusIndex, linear_to_db(value))

func _on_music_slider_drag_ended(_value_changed: bool) -> void:
	var value : float = db_to_linear(AudioServer.get_bus_volume_db(musicBusIndex))
	SettingsManager.saveAudioSettings("MusicVolume", value)

func _on_fx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(effectsBusIndex, linear_to_db(value))

func _on_fx_slider_drag_ended(_value_changed: bool) -> void:
	var value : float = db_to_linear(AudioServer.get_bus_volume_db(effectsBusIndex))
	SettingsManager.saveAudioSettings("FxVolume", value)

func _on_ui_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(uiBusIndex, linear_to_db(value))

func _on_ui_slider_drag_ended(_value_changed: bool) -> void:
	var value : float = db_to_linear(AudioServer.get_bus_volume_db(uiBusIndex))
	SettingsManager.saveAudioSettings("UiVolume", value)

func _on_back_pressed() -> void:
	main.closeAudioMenu()

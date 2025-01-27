extends Control

@onready var main : Node3D = get_tree().get_root().get_node("Main")

var masterBusIndex : int
var musicBusIndex : int
var effectsBusIndex : int
var uiBusIndex : int

func _ready() -> void:
	musicBusIndex = AudioServer.get_bus_index("Music")
	effectsBusIndex = AudioServer.get_bus_index("FX")
	uiBusIndex = AudioServer.get_bus_index("UI")
	masterBusIndex = AudioServer.get_bus_index("Master")





func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musicBusIndex, linear_to_db(value))


func _on_fx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(effectsBusIndex, linear_to_db(value))


func _on_ui_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(uiBusIndex, linear_to_db(value))


func _on_back_pressed() -> void:
	main.closeAudioMenu()

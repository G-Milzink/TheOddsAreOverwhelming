extends Node3D

@export var color : Color = Color.WHEAT
@export var pulseFrequency : float = 1.0
@export var intensity: float = 0.5

var time_passed: float = 0.0

@onready var light: OmniLight3D = $Light

func _ready() -> void:
	light.set_color(color)
	time_passed += randf_range(0.01,0.4)

func _process(delta: float):
	time_passed += delta
	var sine_value = get_sine_wave(time_passed, pulseFrequency)
	light.set_param(Light3D.PARAM_ENERGY,sine_value*intensity)

func get_sine_wave(t: float, frequency: float = 1.0) -> float:
	return 0.5 + 0.5 * sin(t * TAU * frequency)

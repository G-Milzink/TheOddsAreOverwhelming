extends Node

var cameraShakeTimer : Timer
var initalRotation : Vector3
@onready var camera = get_tree().get_first_node_in_group("camera")



func _ready() -> void:
	setupCamerTimer()
	initalRotation = camera.rotation_degrees

func setupCamerTimer():
	cameraShakeTimer = Timer.new()
	add_child(cameraShakeTimer)
	cameraShakeTimer.set_one_shot(true)
	cameraShakeTimer.timeout.connect(cameraShakeTimeout)

func shakeCamera(intensity : float):
	var x = randf_range(-intensity, intensity) + initalRotation.x
	var y = randf_range(-intensity, intensity) + initalRotation.y
	var z = randf_range(-intensity, intensity) + initalRotation.z
	cameraShakeTimer.start(0.05)
	Engine.time_scale = 0.9
	camera.rotation_degrees = Vector3(x,y,z)

func cameraShakeTimeout():
	Engine.time_scale = 1
	camera.rotation_degrees = Vector3(-90, 0, 0)

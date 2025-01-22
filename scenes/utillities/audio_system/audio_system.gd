extends Node3D

@onready var nextWave: AudioStreamPlayer3D = $nextWave


func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func playAudioFx(selector : String) -> void:
	match selector:
		"nextWave":
			nextWave.play()
		_:
			pass

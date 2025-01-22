extends Node3D

var spawnLocation : Vector3 = Vector3.ZERO
var flashing : bool = false

@onready var despawnTimer: Timer = $Despawner/DespawnTimer
@onready var flashTimer: Timer = $Despawner/FlashTimer
@onready var audioFx: AudioStreamPlayer3D = $AudioFx

func _ready() -> void:
	global_position = spawnLocation
	despawnTimer.start()

func _on_static_body_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		flashTimer.stop()
		visible = false
		PlayerData.increaseDamage()
		audioFx.play()
	if body.is_in_group("pickuprejector"):
		PickupSpawner.spawnPickup()
		queue_free()

func _on_despawn_timer_timeout() -> void:
	if flashing:
		queue_free()
	else:
		flashing = true
		despawnTimer.start()
		flashTimer.start()

func _on_flash_timer_timeout() -> void:
	if flashing:
		self.visible = !self.visible

func _on_audio_fx_finished() -> void:
	queue_free()

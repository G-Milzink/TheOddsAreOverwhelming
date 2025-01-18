extends Node3D

var spawnLocation : Vector3 = Vector3.ZERO

func _ready() -> void:
	global_position = spawnLocation


func _on_static_body_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		ProgressionManager.increase_score(ProgressionManager.blueXtalReward)
		queue_free()
	if body.is_in_group("pickuprejector"):
		print("respawn")
		PickupSpawner.spawnBlueCrystal()
		queue_free()

extends Node3D


func _on_static_body_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		ProgressionManager.increase_score(ProgressionManager.blueXtalReward)
		queue_free()

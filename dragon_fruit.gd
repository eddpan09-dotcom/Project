extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bird"):
		get_tree().get_root().get_node("Scene 1").add_score()
		queue_free()

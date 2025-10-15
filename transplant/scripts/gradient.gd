extends TextureRect

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.contains("Robot"):
		get_parent().queue_free()
		get_tree().change_scene_to_file("res://scenes/end.tscn")

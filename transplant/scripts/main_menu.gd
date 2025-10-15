extends Control

func _on_play_pressed() -> void:
	AudioManager.ui_button.play()
	queue_free()
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_options_pressed() -> void:
	AudioManager.ui_button.play()
	queue_free()
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_credits_button_pressed() -> void:
	AudioManager.ui_button.play()
	await get_tree().create_timer(get_process_delta_time()).timeout
	queue_free()
	get_tree().change_scene_to_file("res://scenes/credits_menu.tscn")

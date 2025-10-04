extends Control

func _on_button_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

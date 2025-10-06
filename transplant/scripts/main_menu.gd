extends Control

func _ready() -> void:
	preload("res://scenes/level_1.tscn")
	preload("res://scenes/level_2.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

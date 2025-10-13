extends Control

func _ready() -> void:
	$HBoxContainer/Button2.disabled = LevelsCompleted.level_2_disabled
	$HBoxContainer/Button3.disabled = LevelsCompleted.level_3_disabled
	$HBoxContainer/Button4.disabled = LevelsCompleted.level_4_disabled

func _on_button_1_pressed() -> void:
	AudioManager.ui_button.play()
	preload_level_1()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_button_2_pressed() -> void:
	AudioManager.ui_button.play()
	preload_level_2()
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func _on_button_3_pressed() -> void:
	AudioManager.ui_button.play()
	preload_level_3()
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")

func _on_button_4_pressed() -> void:
	AudioManager.ui_button.play()
	preload_level_4()
	get_tree().change_scene_to_file("res://scenes/level_4.tscn")

func _on_back_button_pressed() -> void:
	AudioManager.ui_button.play()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func preload_level_1() -> void:
	preload("res://scenes/player_1.tscn")
	preload("res://scenes/robot_1.tscn")
	preload("res://scenes/button.tscn")
	preload("res://scenes/door.tscn")
	preload("res://scenes/trash.tscn")
	preload("res://scenes/pause_menu.tscn")
	preload("res://scenes/menu_button.tscn")
	preload("res://scenes/level_complete.tscn")
	preload("res://scenes/goal.tscn")

func preload_level_2() -> void:
	preload("res://scenes/player_2.tscn")
	preload("res://scenes/robot_2.tscn")

func preload_level_3() -> void:
	preload("res://scenes/player_3.tscn")
	preload("res://scenes/robot_3.tscn")
	preload("res://scenes/lily_gate.tscn")
	preload("res://scenes/rafflesia_gate.tscn")

func preload_level_4() -> void:
	preload("res://scenes/player_4.tscn")
	preload("res://scenes/robot_4.tscn")
	preload("res://scenes/gradient.tscn")

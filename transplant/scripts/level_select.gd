extends Control

@onready var button_2 := $HBoxContainer/Button2
@onready var button_3 := $HBoxContainer/Button3
@onready var button_4 := $HBoxContainer/Button4
@onready var canvas_layer := $CanvasLayer

func _ready() -> void:
	button_2.disabled = LevelsCompleted.level_2_disabled
	button_3.disabled = LevelsCompleted.level_3_disabled
	button_4.disabled = LevelsCompleted.level_4_disabled
	canvas_layer.hide()

func _on_button_1_pressed() -> void:
	AudioManager.ui_button.play()
	canvas_layer.show()
	await get_tree().create_timer(2 * get_process_delta_time()).timeout
	queue_free()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_button_2_pressed() -> void:
	AudioManager.ui_button.play()
	canvas_layer.show()
	await get_tree().create_timer(2 * get_process_delta_time()).timeout
	queue_free()
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func _on_button_3_pressed() -> void:
	AudioManager.ui_button.play()
	canvas_layer.show()
	await get_tree().create_timer(2 * get_process_delta_time()).timeout
	queue_free()
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")

func _on_button_4_pressed() -> void:
	AudioManager.ui_button.play()
	canvas_layer.show()
	await get_tree().create_timer(2 * get_process_delta_time()).timeout
	queue_free()
	get_tree().change_scene_to_file("res://scenes/level_4.tscn")

func _on_back_button_pressed() -> void:
	AudioManager.ui_button.play()
	queue_free()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

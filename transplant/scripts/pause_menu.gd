extends Control

func _ready() -> void:
	hide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and not get_tree().paused:
		_pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		_resume()

func _resume():
	get_tree().paused = false
	hide()

func _pause():
	get_tree().paused = true
	show()

func _on_resume_button_pressed() -> void:
	_resume()

func _on_restart_button_pressed() -> void:
	_resume()
	get_tree().reload_current_scene()

func _on_level_select_button_pressed() -> void:
	_resume()
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

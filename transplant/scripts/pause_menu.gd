extends CanvasLayer

func _ready() -> void:
	hide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and not get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()

func resume():
	get_tree().paused = false
	hide()

func pause():
	get_tree().paused = true
	show()

func _on_resume_button_pressed() -> void:
	resume()
	AudioManager.ui_button.play()

func _on_restart_button_pressed() -> void:
	resume()
	AudioManager.ui_button.play()
	get_tree().reload_current_scene()

func _on_level_select_button_pressed() -> void:
	resume()
	AudioManager.ui_button.play()
	get_parent().queue_free()
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

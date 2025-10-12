extends Control

func _ready() -> void:
	$AnimationPlayer/AnimatedSprite2D.play("default")

func _on_back_button_pressed() -> void:
	AudioManager.ui_button.play()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

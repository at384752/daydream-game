extends Control

var times_played = 0

func _ready() -> void:
	$AnimationPlayer/AnimatedSprite2D.play("walk")

func _on_back_button_pressed() -> void:
	AudioManager.ui_button.play()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_pressed() -> void:
	if times_played < 1:
		$AnimationPlayer/AnimatedSprite2D.play("die")
		times_played = times_played + 1

extends Control

var times_played := 0

@onready var anim := $AnimationPlayer/AnimatedSprite2D

func _ready() -> void:
	anim.play("walk")

func _on_back_button_pressed() -> void:
	AudioManager.ui_button.play()
	queue_free()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_pressed() -> void:
	if times_played < 1:
		anim.play("die")
		times_played = times_played + 1

extends CanvasLayer

var goal: StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	goal = get_node("../Goal")
	goal.level_complete.connect(on_level_complete)
	hide()

func on_level_complete() -> void:
	if get_parent().name.contains("1"):
		LevelsCompleted.level_2_disabled = false
	elif get_parent().name.contains("2"):
		LevelsCompleted.level_3_disabled = false
	elif get_parent().name.contains("3"):
		LevelsCompleted.level_4_disabled = false
	show()
	get_tree().paused = true


func _on_level_select_button_pressed() -> void:
	get_tree().paused = false
	AudioManager.ui_button.play()
	get_parent().queue_free()
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	AudioManager.ui_button.play()
	get_parent().queue_free()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

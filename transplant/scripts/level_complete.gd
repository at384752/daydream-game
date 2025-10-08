extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var goal_node = get_node("../Goal")
	goal_node.level_complete.connect(on_level_complete)
	hide()

func on_level_complete() -> void:
	show()
	get_tree().paused = true


func _on_level_select_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

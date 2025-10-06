extends CanvasLayer

func _ready() -> void:
	show()

func _on_menu_button_pressed() -> void:
	get_node("../PauseMenu")._pause()
	hide()

func _process(_delta: float) -> void:
	if get_tree().paused:
		hide()
	else:
		show()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and not get_tree().paused:
		hide()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		show()

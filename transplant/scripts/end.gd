extends Control

@onready var canvas_layer := $CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas_layer.hide()
	set_process(false)
	AudioManager.ambient_piano_music.stop()
	await get_tree().create_timer(2.0).timeout
	AudioManager.birdsong_beside_stream.play()
	await get_tree().create_timer(10.0).timeout
	canvas_layer.show()
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_anything_pressed():
		AudioManager.birdsong_beside_stream.stop()
		AudioManager.ambient_piano_music.play()
		queue_free()
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

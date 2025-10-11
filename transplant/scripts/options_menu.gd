extends Control

var master_bus_id
var music_bus_id
var sfx_bus_id

func _ready() -> void:
	master_bus_id = AudioServer.get_bus_index("Master")
	music_bus_id = AudioServer.get_bus_index("Music")
	sfx_bus_id = AudioServer.get_bus_index("SFX")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_h_slider_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(master_bus_id, value)

func _on_h_slider_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(music_bus_id, value)

func _on_h_slider_2sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(sfx_bus_id, value)

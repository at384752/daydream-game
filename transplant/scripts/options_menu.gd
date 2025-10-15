extends Control

var master_bus_id: int
var music_bus_id: int
var sfx_bus_id: int

@onready var slider_master := $VBoxContainer/HSliderMaster
@onready var slider_music := $VBoxContainer/HSliderMusic
@onready var slider_sfx := $VBoxContainer/HSlider2SFX

func _ready() -> void:
	master_bus_id = AudioServer.get_bus_index("Master")
	music_bus_id = AudioServer.get_bus_index("Music")
	sfx_bus_id = AudioServer.get_bus_index("SFX")
	
	slider_master.value = AudioServer.get_bus_volume_linear(master_bus_id)
	slider_music.value = AudioServer.get_bus_volume_linear(music_bus_id)
	slider_sfx.value = AudioServer.get_bus_volume_linear(sfx_bus_id)

func _on_back_button_pressed() -> void:
	AudioManager.ui_button.play()
	queue_free()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_h_slider_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(master_bus_id, value)

func _on_h_slider_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(music_bus_id, value)

func _on_h_slider_2sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(sfx_bus_id, value)

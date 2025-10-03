extends StaticBody2D

@export var link_code = 0

var is_open = false

@onready var collision_door = $CollisionShape2D_TileDoor
@onready var animation_player = $AnimationPlayer
@onready var button = $"../Button"

func _change_state() -> void:
	is_open = not is_open
	if is_open:
		collision_door.set_disabled(true)
		animation_player.play("open")
	else:
		collision_door.set_disabled(false)
		animation_player.play_backwards("open")

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if not is_open and anim_name == "open":
		animation_player.play("idle")

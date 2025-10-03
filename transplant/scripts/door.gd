extends StaticBody2D

@export var link_code: int

var is_open = false
var play_count = 0

@onready var collision_door = $CollisionShape2D_TileDoor
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	var button_node = get_node("../Button" + str(link_code))
	if button_node.link_code == link_code:
		button_node.pressed.connect(_open)

func _change_state():
	is_open = not is_open
	if is_open:
		collision_door.set_disabled(true)
		animation_player.play("open")
	else:
		collision_door.set_disabled(false)
		animation_player.play_backwards("open")

func _open():
	if play_count < 1:
		animation_player.play("open")
		is_open = true
		_on_animation_player_animation_finished("open")
		play_count = play_count + 1

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if is_open and anim_name == "open":
		$AnimatedSprite2D.set_frame_and_progress(7, 0)

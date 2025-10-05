extends StaticBody2D

@export var link_code: int

var play_count = 0

@onready var collision_door = $CollisionShape2D_TileDoor
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	var button_node = get_node("../Button" + str(link_code))
	button_node.pressed.connect(_open)

func _open():
	if play_count < 1:
		animation_player.play("open")
		play_count = play_count + 1

extends StaticBody2D

@export var link_code: int

var play_count: int = 0
var button: StaticBody2D

@onready var collision_door := $CollisionShape2D_TileDoor
@onready var animation_player := $AnimationPlayer

func _ready() -> void:
	button = get_node("../Button" + str(link_code))
	button.pressed.connect(_open)

func _open():
	if play_count < 1:
		animation_player.play("open")
		AudioManager.door_open.play()
		play_count = play_count + 1

extends StaticBody2D

var bodies: Array[Node2D]
var play_count := 0
var player
var robot

@onready var area = $Area2D

signal level_complete

func _ready() -> void:
	player = get_node("../Player")
	robot = get_node("../Robot")

func _process(_delta: float) -> void:
	bodies = area.get_overlapping_bodies()
	
	if bodies.has(player) and bodies.has(robot):
		if Input.is_action_just_pressed("sacrifice") and player.is_on_floor():
			sacrifice()

func sacrifice() -> void:
	if play_count < 1:
		play_count = play_count + 1
		player.anim.play("transfer")
		player.set_process(false)
		player.set_physics_process(false)
		player.camera.set_zoom(Vector2(2, 2))
		await get_tree().create_timer(0.65).timeout
		AudioManager.rip.play()
		await get_tree().create_timer(1.0).timeout
		level_complete.emit()

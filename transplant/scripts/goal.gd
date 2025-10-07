extends StaticBody2D

var bodies
var play_count = 0

signal level_complete

func _process(_delta: float) -> void:
	bodies = $Area2D.get_overlapping_bodies()
	
	if bodies.has(get_node("../Player")) and bodies.has(get_node("../Robot")):
		if Input.is_action_just_pressed("sacrifice") and get_node("../Player").is_on_floor():
			sacrifice()

func sacrifice() -> void:
	if play_count < 1:
		play_count = play_count + 1
		get_node("../Player").anim.play("transfer")
		get_node("../Player").set_process(false)
		get_node("../Player").set_physics_process(false)
		get_node("../Player").camera.set_zoom(Vector2(2, 2))
		await get_tree().create_timer(1.0).timeout
		level_complete.emit()

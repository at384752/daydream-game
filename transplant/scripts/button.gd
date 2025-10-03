extends StaticBody2D

@onready var anim = $AnimatedSprite2D
@export var link_code = 0

signal pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var bodies = $Area2D.get_overlapping_bodies()
	if not bodies.is_empty():
		for body in bodies:
			if body.name == "Player" or body.name == "Robot":
				anim.set_frame(1)
				emit_signal("pressed")
	else:
		anim.set_frame(0)

extends StaticBody2D

@onready var anim = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var bodies = $Area2D.get_overlapping_bodies()
	if bodies != null:
		for body in bodies:
			if body.name == "Player" or body.name == "Robot":
				anim.set_frame(1)
	else:
		anim.set_frame(0)

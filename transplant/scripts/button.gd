extends StaticBody2D

@onready var anim = $AnimatedSprite2D
@onready var area = $Area2D
@export var link_code: int

signal pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var bodies = area.get_overlapping_bodies()
	if not bodies.is_empty():
		for body in bodies:
			if body.name == "Player" or body.name == "Robot":
				anim.set_frame(1)
				pressed.emit()
	else:
		anim.set_frame(0)

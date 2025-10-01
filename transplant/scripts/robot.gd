extends RigidBody2D

var picked = false

func _physics_process(_delta: float) -> void:
	if picked:
		self.position = get_node("../Player/Marker2D").global_position

func _input(_event: InputEvent) -> void:
	# Search for items to pick up when pressing E
	if Input.is_action_just_pressed("pick up"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").canPickUp:
				picked = true
				get_node("../Player").canPickUp = false
	
	# Drop held item when pressing S
	if Input.is_action_just_pressed("down") and picked:
		picked = false
		get_node("../Player").canPickUp = true
		apply_central_force(Vector2())
	
	# Throw held item when pressing Q
	if Input.is_action_just_pressed("throw") and picked:
		picked = false
		get_node("../Player").canPickUp = true
		if not get_node("../Player").anim.flip_h:
			apply_impulse(Vector2(-500, -750))
		else:
			apply_impulse(Vector2(500, -750))

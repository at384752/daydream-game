extends RigidBody2D

var picked = false

func _physics_process(_delta: float) -> void:
	if picked:
		self.position = get_node("../Player/Marker2D").global_position

func _input(_event: InputEvent) -> void:
	# Search for items to pick up when pressing Z
	if Input.is_action_just_pressed("pick up"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").canPickUp:
				picked = true
				get_node("../Player").canPickUp = false
				set_freeze_enabled(true)
	
	# Drop held item when pressing DOWN
	if Input.is_action_just_pressed("down") and picked:
		picked = false
		get_node("../Player").canPickUp = true
		set_freeze_enabled(false)
		apply_central_force(Vector2())
	
	# Throw held item when pressing X
	if Input.is_action_just_pressed("throw") and picked:
		picked = false
		get_node("../Player").canPickUp = true
		set_freeze_enabled(false)
		
		if not get_node("../Player").anim.flip_h:
			apply_impulse(Vector2(get_node("../Player").velocity.x - 400, -250))
		else:
			apply_impulse(Vector2(get_node("../Player").velocity.x + 400, -250))

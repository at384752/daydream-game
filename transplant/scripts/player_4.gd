extends RigidBody2D

var picked = false

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func _physics_process(_delta: float) -> void:
	if picked:
		self.position = get_node("../Robot/Marker2D").global_position

func _input(_event: InputEvent) -> void:
	# Search for items to pick up when pressing Z
	if Input.is_action_just_pressed("pick up"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Robot" and get_node("../Robot").canPickUp:
				picked = true
				get_node("../Robot").canPickUp = false
				set_freeze_enabled(true)
	
	# Drop held item when pressing DOWN
	if Input.is_action_just_pressed("down") and picked:
		picked = false
		get_node("../Robot").canPickUp = true
		set_freeze_enabled(false)
		apply_central_force(Vector2())
	
	# Throw held item when pressing X
	if Input.is_action_just_pressed("throw") and picked:
		picked = false
		get_node("../Robot").canPickUp = true
		set_freeze_enabled(false)
		
		if not get_node("../Robot").anim.flip_h:
			apply_impulse(Vector2(get_node("../Robot").velocity.x - 400, -250))
		else:
			apply_impulse(Vector2(get_node("../Robot").velocity.x + 400, -250))

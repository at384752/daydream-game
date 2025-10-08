extends RigidBody2D

var picked = false

@onready var arm = $Area2D2

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	set_freeze_mode(FREEZE_MODE_KINEMATIC)

func _physics_process(_delta: float) -> void:
	if picked:
		self.position = get_node("../Player/Marker2D").global_position
		
		if get_node("../Player").anim.flip_h and not Input.is_action_pressed("up"):
			rotation_degrees = 180
		elif not get_node("../Player").anim.flip_h and not Input.is_action_pressed("up"):
			rotation_degrees = 0

func _input(_event: InputEvent) -> void:
	# Search for items to pick up when pressing Z
	if Input.is_action_just_pressed("pick up"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").canPickUp:
				picked = true
				get_node("../Player").canPickUp = false
				set_freeze_enabled(true)
	
	if Input.is_action_pressed("up") and picked:
		rotation_degrees = 90
	
	# Drop held item when pressing DOWN
	if Input.is_action_just_pressed("down") and picked:
		picked = false
		get_node("../Player").canPickUp = true
		set_freeze_enabled(false)
	
	# Throw held item when pressing X
	if Input.is_action_just_pressed("throw") and picked:
		picked = false
		get_node("../Player").canPickUp = true
		set_freeze_enabled(false)
		
		if not get_node("../Player").anim.flip_h and get_node("../Player").velocity.x == 0:
			apply_impulse(Vector2(-400, -150))
		elif get_node("../Player").anim.flip_h and get_node("../Player").velocity.x == 0:
			apply_impulse(Vector2(400, -150))
		else:
			apply_impulse(Vector2(get_node("../Player").velocity.x * 0.85, -50))

extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -500.0

@onready var area = $Area2D

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func switch_control():
	if not get_node("../Player").camera_on_player:
		get_node("../Player").camera_on_player = true
		$AnimatedSprite2D.play("idle")
		set_process(false)
		set_physics_process(false)
		get_node("../Player").set_process(true)
		get_node("../Player").set_physics_process(true)
	else:
		get_node("../Player").camera_on_player = false
		set_process(true)
		set_physics_process(true)
		get_node("../Player").set_process(false)
		get_node("../Player").set_physics_process(false)

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("switch") and is_on_floor():
		switch_control()
	
	if not get_node("../Player").camera_on_player:
		get_node("../Player").camera.global_position = $Marker2D.global_position
	
	var bodies = area.get_overlapping_bodies()
	if not bodies.is_empty():
		for body in bodies:
			if (body.name.contains("Door") or body.name.contains("Button")) and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
				var position_a = self.position + Vector2(0, -2)
				var position_b = self.position + Vector2(velocity.x * delta, -2)
				self.position = position_a.lerp(position_b, delta)

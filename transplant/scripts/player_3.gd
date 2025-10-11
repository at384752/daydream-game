extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -500.0

@onready var anim = $AnimatedSprite2D
@onready var area = $Area2D
@onready var camera = $Camera2D

var camera_on_player = true

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

func _process(delta: float) -> void:
	if Input.is_action_pressed("left") and is_on_floor():
		anim.set_flip_h(false)
		anim.play("walk")
	
	if Input.is_action_pressed("right") and is_on_floor():
		anim.set_flip_h(true)
		anim.play("walk")
	
	if Input.is_action_just_pressed("jump"):
		anim.play("jump")
	
	if velocity.y > 0:
		anim.play("fall")
	
	if not Input.is_anything_pressed() and is_on_floor():
		anim.play("idle")
	
	if Input.is_action_pressed("left") and not is_on_floor():
		anim.set_flip_h(false)
	
	if Input.is_action_pressed("right") and not is_on_floor():
		anim.set_flip_h(true)
	
	if Input.is_action_just_pressed("switch") and is_on_floor():
		switch_control()
	
	if camera_on_player:
		camera.global_position = $Marker2D.global_position
	else:
		camera.global_position = get_node("../Robot/Marker2D").global_position
	
	var bodies = area.get_overlapping_bodies()
	if not bodies.is_empty():
		for body in bodies:
			if (body.name.contains("Door") or body.name.contains("Button")) and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
				var position_a = self.position + Vector2(0, -2)
				var position_b = self.position + Vector2(velocity.x * delta, -2)
				self.position = position_a.lerp(position_b, delta)

func switch_control():
	if not camera_on_player:
		camera_on_player = true
		set_process(true)
		set_physics_process(true)
		get_node("../Robot").set_process(false)
		get_node("../Robot").set_physics_process(false)
	else:
		camera_on_player = false
		anim.play("idle")
		set_process(false)
		set_physics_process(false)
		get_node("../Robot").set_process(true)
		get_node("../Robot").set_physics_process(true)

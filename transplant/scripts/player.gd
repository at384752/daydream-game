extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0
const PUSH_FORCE = 100
const BLOCK_MAX_VELOCITY = 180

var canPickUp = true

@onready var area = $Area2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

@onready var anim = $AnimatedSprite2D

func _process(delta: float) -> void:
	if Input.is_action_pressed("left") and is_on_floor():
		anim.set_flip_h(false)
		if get_node("../Robot").picked:
			anim.play("walk_hold")
		else:
			anim.play("walk")
	
	if Input.is_action_pressed("right") and is_on_floor():
		anim.set_flip_h(true)
		if get_node("../Robot").picked:
			anim.play("walk_hold")
		else:
			anim.play("walk")
	
	if Input.is_action_just_pressed("up"):
		if get_node("../Robot").picked:
			anim.play("jump_hold")
		else:
			anim.play("jump")
	
	if velocity.y > 0:
		if get_node("../Robot").picked:
			anim.play("fall_hold")
		else:
			anim.play("fall")
	
	if not Input.is_anything_pressed() and is_on_floor():
		if get_node("../Robot").picked:
			anim.play("idle_hold")
		else:
			anim.play("idle")
	
	if Input.is_action_just_pressed("left") and not is_on_floor():
		anim.set_flip_h(false)
	
	if Input.is_action_pressed("right") and not is_on_floor():
		anim.set_flip_h(true)
	
	var bodies = area.get_overlapping_bodies()
	if not bodies.is_empty():
		for body in bodies:
			if body.name.contains("Door"):
				var position_a = self.position + Vector2(0, -2)
				var position_b = self.position + Vector2(velocity.x * delta, -2)
				self.position = position_a.lerp(position_b, delta)

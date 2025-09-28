extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0
const PUSH_FORCE = 100
const BLOCK_MAX_VELOCITY = 180

var canPickUp = true

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

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_block = collision.get_collider()
		
		if collision_block.is_in_group("Blocks") and abs(collision_block.get_linear_velocity().x) < BLOCK_MAX_VELOCITY:
			collision_block.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)

	move_and_slide()

@onready var anim = $AnimatedSprite2D

func _process(_delta: float) -> void:
	if Input.is_action_pressed("left") and is_on_floor():
		anim.set_flip_h(false)
		anim.play("walk")
	
	if Input.is_action_pressed("right") and is_on_floor():
		anim.set_flip_h(true)
		anim.play("walk")
	
	if Input.is_action_just_pressed("up"):
		anim.play("jump")
	
	if velocity.y > 0:
		anim.play("fall")
	
	if not Input.is_anything_pressed() and is_on_floor():
		anim.play("idle")
	
	if Input.is_action_just_pressed("left") and not is_on_floor():
		anim.set_flip_h(false)
	
	if Input.is_action_pressed("right") and not is_on_floor():
		anim.set_flip_h(true)

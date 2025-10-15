extends CharacterBody2D

const SPEED := 400.0
const JUMP_VELOCITY := -500.0

var canPickUp := true
var player: RigidBody2D

@onready var area := $Area2D
@onready var camera := $Camera2D
@onready var anim := $AnimatedSprite2D

func _ready() -> void:
	player = get_node("../Player")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		await get_tree().create_timer(delta).timeout
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
	
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and is_on_floor():
		if player.picked:
			anim.play("walk_hold")
		else:
			anim.play("walk")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		await get_tree().create_timer(2 * delta).timeout
		if player.picked:
			anim.play("jump_hold")
			AudioManager.jump.play()
		else:
			anim.play("jump")
			AudioManager.jump.play()
	
	if velocity.y > 0:
		if player.picked:
			anim.play("fall_hold")
		else:
			anim.play("fall")
	
	if not Input.is_anything_pressed() and is_on_floor():
		if player.picked:
			anim.play("idle_hold")
		else:
			anim.play("idle")
	
	if Input.is_action_pressed("left"):
		anim.set_flip_h(false)
	
	if Input.is_action_pressed("right"):
		anim.set_flip_h(true)
	
	var bodies: Array[Node2D] = area.get_overlapping_bodies()
	if not bodies.is_empty():
		for body in bodies:
			if (body.name.contains("Door") or body.name.contains("Button")) and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
				var position_a := self.position + Vector2(0, -2)
				var position_b := self.position + Vector2(velocity.x * delta, -2)
				self.position = position_a.lerp(position_b, delta)
	
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and is_on_floor():
		if not AudioManager.footstep_metal.is_playing():
			AudioManager.footstep_metal.play()

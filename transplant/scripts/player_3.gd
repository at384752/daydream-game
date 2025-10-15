extends CharacterBody2D


const SPEED := 350.0
const JUMP_VELOCITY := -500.0

@onready var anim := $AnimatedSprite2D
@onready var area := $Area2D
@onready var camera := $Camera2D
@onready var marker := $Marker2D

var camera_on_player := true
var robot: CharacterBody2D
var robot_marker2d: Marker2D

func _ready() -> void:
	robot = get_node("../Robot")
	robot_marker2d = get_node("../Robot/Marker2D")

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
		anim.play("walk")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		await get_tree().create_timer(2 * delta).timeout
		anim.play("jump")
		AudioManager.jump.play()
	
	if velocity.y > 0:
		anim.play("fall")
	
	if not Input.is_anything_pressed() and is_on_floor():
		anim.play("idle")
	
	if Input.is_action_pressed("left"):
		anim.set_flip_h(false)
	
	if Input.is_action_pressed("right"):
		anim.set_flip_h(true)
	
	if Input.is_action_just_pressed("switch") and is_on_floor():
		switch_control()
	
	if camera_on_player:
		camera.global_position = marker.global_position
	else:
		camera.global_position = robot_marker2d.global_position
	
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

func switch_control():
	AudioManager.ui_button.play()
	if not camera_on_player:
		camera_on_player = true
		set_process(true)
		set_physics_process(true)
		robot.set_process(false)
		robot.set_physics_process(false)
	else:
		camera_on_player = false
		anim.play("idle")
		set_process(false)
		set_physics_process(false)
		robot.set_process(true)
		robot.set_physics_process(true)

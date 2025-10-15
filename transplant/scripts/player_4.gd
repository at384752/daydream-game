extends RigidBody2D

var picked := false
var robot: CharacterBody2D
var robot_marker2d: Marker2D

@onready var anim := $AnimatedSprite2D
@onready var area := $Area2D

func _ready() -> void:
	anim.play("idle")
	robot = get_node("../Robot")
	robot_marker2d = get_node("../Robot/Marker2D")

func _physics_process(_delta: float) -> void:
	if picked:
		self.position = robot_marker2d.global_position

func _input(_event: InputEvent) -> void:
	# Search for items to pick up when pressing Z
	if Input.is_action_just_pressed("pick up"):
		var bodies = area.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Robot" and robot.canPickUp:
				picked = true
				robot.canPickUp = false
				set_freeze_enabled(true)
	
	# Drop held item when pressing DOWN
	if Input.is_action_just_pressed("down") and picked:
		picked = false
		robot.canPickUp = true
		set_freeze_enabled(false)
		apply_central_force(Vector2())
	
	# Throw held item when pressing X
	if Input.is_action_just_pressed("throw") and picked:
		picked = false
		robot.canPickUp = true
		set_freeze_enabled(false)
		
		if not robot.anim.flip_h:
			apply_impulse(Vector2(robot.velocity.x - 400, -250))
		else:
			apply_impulse(Vector2(robot.velocity.x + 400, -250))

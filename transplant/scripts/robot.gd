extends RigidBody2D

var picked := false
var player: CharacterBody2D
var player_marker2d: Marker2D

@onready var anim := $AnimatedSprite2D
@onready var area := $Area2D

func _ready() -> void:
	anim.play("idle")
	player = get_node("../Player")
	player_marker2d = get_node("../Player/Marker2D")

func _physics_process(_delta: float) -> void:
	if picked:
		self.position = player_marker2d.global_position

func _input(_event: InputEvent) -> void:
	# Search for items to pick up when pressing Z
	if Input.is_action_just_pressed("pick up"):
		var bodies: Array[Node2D] = area.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and player.canPickUp:
				picked = true
				player.canPickUp = false
				set_freeze_enabled(true)
	
	# Drop held item when pressing DOWN
	if Input.is_action_just_pressed("down") and picked:
		picked = false
		player.canPickUp = true
		set_freeze_enabled(false)
		apply_central_force(Vector2())
	
	# Throw held item when pressing X
	if Input.is_action_just_pressed("throw") and picked:
		picked = false
		player.canPickUp = true
		set_freeze_enabled(false)
		
		if not player.anim.flip_h:
			apply_impulse(Vector2(player.velocity.x - 400, -250))
		else:
			apply_impulse(Vector2(player.velocity.x + 400, -250))

extends CharacterBody2D

@export var speed = 75.0
@export var jump_velocity = -250.0
@export var gravity = 800.0

@onready var sprite = $AnimatedSprite2D

var color = "green"

func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# input
	var dir = 0
	if Input.is_action_pressed("move_left"):
		dir -= 1
	if Input.is_action_pressed("move_right"):
		dir += 1

	if Input.is_action_just_pressed("swap_color"):
		if color == "green":
			color = "blue"
		else:
			color = "green"

	velocity.x = dir * speed

	# jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()

	# animations
	if not is_on_floor():
		sprite.play("jump_"+color)
	elif dir == 0:
		sprite.play("idle_"+color)
	else:
		sprite.play("move_"+color)
		sprite.flip_h = dir > 0

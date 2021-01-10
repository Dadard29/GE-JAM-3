extends KinematicBody2D

export var GRAVITY = -100
export var SPEED = Vector2(400, 1400)

var FLOOR_NORMAL = Vector2.DOWN
var _velocity = Vector2.ZERO

var speed_direction = 1
var _activated = false

signal die


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func activate():
	_activated = true

func deactivate():
	_activated = false

func die():
	emit_signal("die")

func _physics_process(_delta):
	if not _activated:
		return
	
	var slide_count = get_slide_count()
	if slide_count:
		var collision = get_slide_collision(slide_count - 1)
		var collider = collision.collider
		if collider.is_in_group("obstacles"):
			die()
	
	if Input.is_action_pressed("ui_right"):
		_velocity.x = SPEED.x
	elif Input.is_action_pressed("ui_left"):
		_velocity.x = -SPEED.x
	else:
		_velocity.x = 0
		

	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			_velocity.y = SPEED.y * speed_direction
			
		else:
			_velocity.y = 0
	else:
		_velocity.y += GRAVITY
	
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

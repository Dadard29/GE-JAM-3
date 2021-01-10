extends KinematicBody2D

signal jumping
signal landing
signal die

export var GRAVITY = 100
export var SPEED = Vector2(400, 1400)

var FLOOR_NORMAL = Vector2.UP
var _velocity = Vector2.ZERO
var _activated = false

var is_jumping = true

func die():
	emit_signal("die")

func activate():
	_activated = true

func deactivate():
	_activated = false

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
			_velocity.y = -SPEED.y
			
			is_jumping = true
			emit_signal("jumping")
		else:
			_velocity.y = 0
	else:
		_velocity.y += GRAVITY
		
	if is_jumping and _velocity.y == 0 and is_on_floor():
		is_jumping = false
		emit_signal("landing")
	
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

class_name SmoothMover
extends Node

@export var acceleration: float
@export var deceleration: float
@export var max_speed: float


func get_new_velocity(delta: float, velocity: Vector2, rotation: float, dir: Vector2) -> Vector2:
	dir = dir.normalized()
	
	if dir == Vector2.ZERO:
		var old_velocity := velocity
		velocity -= velocity.normalized() * deceleration * delta
		
		if old_velocity.sign() != velocity.sign():
			velocity = Vector2.ZERO
		
	elif velocity == Vector2.ZERO:
		velocity = Vector2.from_angle(rotation) * max_speed * 0.1
		
	else:
		velocity += dir * acceleration * delta
		
		if velocity.length() > max_speed:
			velocity = velocity.normalized() * max_speed
	
	return velocity


func get_new_rotation(velocity: Vector2, rotation: float) -> float:
	return rotation if velocity == Vector2.ZERO else velocity.angle()

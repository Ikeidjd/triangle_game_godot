class_name Player
extends CharacterBody2D

@onready var smooth_mover: SmoothMover = %SmoothMover


func _physics_process(delta: float) -> void:
	var dir := Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		dir.y -= 1
	if Input.is_action_pressed("move_down"):
		dir.y += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	
	velocity = smooth_mover.get_new_velocity(delta, velocity, rotation, dir)
	move_and_slide()
	rotation = smooth_mover.get_new_rotation(velocity, rotation)

class_name Chaser
extends CharacterBody2D

@onready var smooth_mover: SmoothMover = %SmoothMover
@export var player: Player


func _physics_process(delta: float) -> void:
	velocity = smooth_mover.get_new_velocity(delta, velocity, rotation, player.position - position)
	move_and_slide()
	rotation = smooth_mover.get_new_rotation(velocity, rotation)

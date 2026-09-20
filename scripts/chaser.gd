class_name Chaser
extends Area2D

@onready var smooth_mover: SmoothMover = %SmoothMover
@export var player: Player

var velocity: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	velocity = smooth_mover.get_new_velocity(delta, velocity, rotation, player.position - position)
	rotation = smooth_mover.get_new_rotation(velocity, rotation)
	
	position += velocity * delta

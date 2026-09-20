class_name Charger
extends Area2D

enum State {
	Targeting,
	Accelerating,
	Decelerating,
}

@onready var smooth_mover: SmoothMover = %SmoothMover

@export var player: Player

var velocity: Vector2 = Vector2.ZERO
var state: State = State.Targeting
var dir: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	match state:
		State.Targeting:
			dir = player.position - position
			state = State.Accelerating
		State.Accelerating:
			velocity = smooth_mover.get_new_velocity(delta, velocity, rotation, dir)
			rotation = smooth_mover.get_new_rotation(velocity, rotation)
			
			if abs(velocity.length() - smooth_mover.max_speed) <= 1.0:
				state = State.Decelerating
		State.Decelerating:
			velocity = smooth_mover.get_new_velocity(delta, velocity, rotation, Vector2.ZERO)
			rotation = smooth_mover.get_new_rotation(velocity, rotation)
			
			if velocity == Vector2.ZERO:
				state = State.Targeting
	
	position += velocity * delta

class_name Player
extends CharacterBody2D

@onready var smooth_mover: SmoothMover = %SmoothMover
@onready var bullet_cooldown: Timer = %BulletCooldown
@export var bullet_scene: PackedScene
@export var bullet_speed: float


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
	
	if Input.is_action_just_pressed("shoot") and bullet_cooldown.is_stopped():
		var bullet: Bullet = bullet_scene.instantiate()
		bullet.position = position
		bullet.linear_velocity = (get_global_mouse_position() - position).normalized() * bullet_speed
		get_tree().root.add_child(bullet)
		bullet_cooldown.start()

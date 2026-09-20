class_name Player
extends Area2D

@onready var smooth_mover: SmoothMover = %SmoothMover
@onready var bullet_cooldown: Timer = %BulletCooldown
@onready var iframes: Timer = %IFrames
@onready var hit_sound: AudioStreamPlayer = %HitSound

@export var bullet_scene: PackedScene
@export var bullet_speed: float

var velocity: Vector2 = Vector2.ZERO


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
	rotation = smooth_mover.get_new_rotation(velocity, rotation)
	
	position += velocity * delta
	
	if not iframes.is_stopped():
		return
	
	if Input.is_action_just_pressed("shoot") and bullet_cooldown.is_stopped():
		var bullet: Bullet = bullet_scene.instantiate()
		bullet.position = position
		bullet.linear_velocity = (get_global_mouse_position() - position).normalized() * bullet_speed
		get_tree().root.add_child(bullet)
		bullet_cooldown.start()
	
	for area in get_overlapping_areas():
		if (area.collision_layer & CollisionLayer.Enemy) != 0:
			iframes.start()
			hit_sound.play()
			
			hide()
			
			# You move faster after getting hit
			var old_smooth_mover := smooth_mover.duplicate()
			smooth_mover.acceleration *= 4
			smooth_mover.max_speed *= 1.5
			
			var i := 8.0
			var tween := create_tween()
			
			while i < 256.0:
				tween.tween_property(self, "visible", false, iframes.wait_time / i)
				tween.tween_property(self, "visible", true, iframes.wait_time / i)
				
				tween.tween_property(self, "visible", false, iframes.wait_time / i)
				tween.tween_property(self, "visible", true, iframes.wait_time / i)
				
				i *= 2.0
			
			tween.tween_callback(func(): smooth_mover = old_smooth_mover)









# Writing at the bottom of the file is annoying, so I added some space

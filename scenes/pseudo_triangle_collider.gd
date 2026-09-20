class_name PseudoTriangleCollider
extends CollisionPolygon2D

@export var pseudo_triangle: PseudoTriangle


func _ready() -> void:
	# For rotations
	position = -Vector2(pseudo_triangle.width, pseudo_triangle.height) * 0.5

	set_polygon(PackedVector2Array([
		Vector2(pseudo_triangle.width, pseudo_triangle.height * 0.5),
		Vector2(0.0, pseudo_triangle.height),
		Vector2(pseudo_triangle.width * pseudo_triangle.indent_width_proportion,
			pseudo_triangle.height * 0.5),
		Vector2(0.0, 0.0),
	]))
	
	print(polygon)

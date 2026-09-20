class_name PseudoTriangle
extends Polygon2D

@export var width: float
@export var height: float
@export var indent_width_proportion: float


func _ready() -> void:
	# For rotations
	position = -Vector2(width, height) * 0.5

	set_polygon(PackedVector2Array([
		Vector2(width, height * 0.5),
		Vector2(0.0, height),
		Vector2(width * indent_width_proportion, height * 0.5),
		Vector2(0.0, 0.0),
	]))
	
	print(polygon)

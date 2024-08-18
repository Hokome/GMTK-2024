extends Node2D
class_name CircleDraw
# Feel free to steal

## How many points per pixel of radius
const PIXEL_PER_POINT: float = 20
const MIN_POINTS: int = 8

@export var radius: float:
	set(val):
		radius = val
		var points := generate_points()
		if circle:
			circle.points = points
		if disk:
			disk.polygon = points

@export var circle: Line2D
@export var disk: Polygon2D

func _ready() -> void:
	radius = radius

func generate_points() -> PackedVector2Array:
	var resolution: int = MIN_POINTS + floori(radius / PIXEL_PER_POINT)
	var angle_step := 2 * PI / resolution
	var points: PackedVector2Array = []
	points.resize(resolution)
	for i in resolution:
		var angle := angle_step * i
		points[i] = Vector2(cos(angle), sin(angle)) * radius
	return points

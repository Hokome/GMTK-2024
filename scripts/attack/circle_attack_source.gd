extends AttackSource
class_name CircleAttackSource

@export var radius: float
@export var angle_step: float

var angle: float

func attack_position() -> Vector2:
	var angle_rad = deg_to_rad(angle)
	angle += angle_step
	return global_position + Vector2(cos(angle_rad), sin(angle_rad)) * radius

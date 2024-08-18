extends AttackSource
class_name RandomAttackSource

@export var variation_radius: float

func attack_position() -> Vector2:
	var random_vector := Vector2(randf() - 0.5, randf() - 0.5)
	return global_position + random_vector.limit_length() * variation_radius

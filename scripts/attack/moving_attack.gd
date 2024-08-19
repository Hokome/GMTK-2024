extends Node2D
class_name MovingAttack

@export var speed: float

func _physics_process(delta: float) -> void:
	var direction: Vector2 = transform.basis_xform(Vector2.RIGHT)
	position += delta * speed * direction

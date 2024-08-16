extends CharacterBody2D
class_name Entity

@export var base_speed: float
var movement_direction: Vector2

func _physics_process(_delta: float) -> void:
	velocity = movement_direction * base_speed
	move_and_slide()

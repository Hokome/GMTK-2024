extends Node
class_name PlayerController

@onready var entity: Entity = get_parent()

func _physics_process(_delta: float) -> void:
	var input_direction := Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	# Makes sure the character is always moving
	if input_direction.length_squared() > 0.1:
		# Normalize and not Limit length since we want full speed all the time
		entity.movement_direction = input_direction.normalized()

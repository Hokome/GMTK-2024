extends Node

var target:Entity
@onready var entity: Entity = get_parent()

func _physics_process(delta: float) -> void:
	#Change direction based on player
	var direction := entity.position.direction_to(target.position)
	entity.movement_direction = direction

extends Node
class_name BandMemberController

var front_member: Entity
@onready var entity: Entity = get_parent()

func _physics_process(delta: float) -> void:
	entity.movement_direction

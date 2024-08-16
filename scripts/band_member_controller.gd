extends Node
class_name BandMemberController

var front_member: Entity
@onready var entity: Entity = get_parent()

func _ready() -> void:
	entity.position = front_member.position

func _physics_process(_delta: float) -> void:
	var direction := entity.position.direction_to(front_member.position)
	entity.movement_direction = direction

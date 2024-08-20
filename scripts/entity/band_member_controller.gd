extends Node
class_name BandMemberController

const TARGET_DISTANCE := 50.0

var front_member: Entity
@onready var entity: Entity = get_parent()

func _ready() -> void:
	entity.position = front_member.position + Vector2(10,0)

func _physics_process(_delta: float) -> void:
	var direction := front_member.position - entity.position
	if direction.length_squared() > TARGET_DISTANCE * TARGET_DISTANCE:
		entity.movement_direction = direction.normalized()

extends Node
class_name BandMemberController

var front_member: Entity
@onready var entity: Entity = get_parent()
#just for debugging purposes
@export var pointer:Sprite2D

func _ready() -> void:
	entity.position = front_member.position + Vector2(10,0)
	#print("ready: " + name+" |"+str(entity.position))

func _physics_process(_delta: float) -> void:
	var direction := entity.position.direction_to(front_member.position)
	pointer.position = 10*direction
	entity.movement_direction = direction

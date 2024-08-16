extends CharacterBody2D
# THIS CLASS SHOULD NOT DO ANYTHING ON ITS OWN, IT IS A MERE PUPPET THAT IS RESPONSIBLE FOR COLLISION PHYSICS AND MOVEMENT
# Please implement things like health, input, enemy AI, attacks etc. as child nodes and do not inherit the class
class_name Entity

@export var speed: float
var movement_direction: Vector2

func _physics_process(_delta: float) -> void:
	velocity = movement_direction * speed
	move_and_slide()

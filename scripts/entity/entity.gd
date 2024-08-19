extends CharacterBody2D
# THIS CLASS SHOULD NOT DO ANYTHING ON ITS OWN, IT IS A MERE PUPPET THAT IS RESPONSIBLE FOR COLLISION PHYSICS AND MOVEMENT
# Please implement things like health, input, enemy AI, attacks etc. as child nodes and do not inherit the class
class_name Entity

const SPEED_DEBUFF_MULTIPLIER := 0.5

@export var speed: float
var speed_debuff_time := 0.0
var movement_direction: Vector2

func _physics_process(delta: float) -> void:
	var final_speed := speed
	if speed_debuff_time > 0:
		speed_debuff_time -= delta
		final_speed *= SPEED_DEBUFF_MULTIPLIER
	velocity = movement_direction * final_speed
	move_and_slide()

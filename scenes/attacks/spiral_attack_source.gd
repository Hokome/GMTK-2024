extends AttackSource
class_name SpiralAttackSource

@export var angle_step: float
var angle: float

func spawn_attack() -> void:
	if !attack_scene: return
	var attack: Node2D = attack_scene.instantiate()
	attack.rotation_degrees = angle
	angle += angle_step
	game.add_child(attack)
	attack.global_position = attack_position()

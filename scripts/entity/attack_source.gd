extends Node2D
class_name AttackSource

@export var attack_scene: PackedScene

func spawn_attack() -> void:
	if !attack_scene: return
	var attack: Node2D = attack_scene.instantiate()
	game.add_child(attack)
	attack.global_position = global_position

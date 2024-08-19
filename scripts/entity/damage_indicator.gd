extends Node2D

func damage(damage: float):
	var damage_number: DamageNumber = preload("res://ui/damage_number.tscn").instantiate()
	game.add_child(damage_number)
	damage_number.global_position = global_position
	damage_number.set_damage(damage)

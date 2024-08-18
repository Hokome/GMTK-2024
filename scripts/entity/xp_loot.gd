extends Node2D
class_name XPLoot

@export var value: int = 1

func loot():
	game.loot(value, global_position)

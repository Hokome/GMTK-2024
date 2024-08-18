extends Node2D
class_name XPLoot

@export var value: int = 1

func loot():
	game.loot.call_deferred(value, global_position)

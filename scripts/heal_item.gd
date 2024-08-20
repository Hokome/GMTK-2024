extends Node

@export var amount := 20.0

func collect():
	game.player.get_node("health").health += amount

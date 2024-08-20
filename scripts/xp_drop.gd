extends Node

@export var amount: int = 1

func collect():
	game.xp.current += amount
	game.xp.play_sound()

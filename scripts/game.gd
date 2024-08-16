extends Node
class_name Game

var player: Entity

func start():
	spawn_player()

func spawn_player():
	var player_scene := preload("res://scenes/player.tscn")
	player = player_scene.instantiate()
	add_child(player)

extends Node
class_name Game

var player: Entity

func start():
	spawn_player()

func spawn_player():
	var player_scene := preload("res://scenes/player.tscn")
	player = player_scene.instantiate()
	add_child(player)
	
	var member_scene := preload("res://scenes/band_member.tscn")
	var member_entity: Entity = member_scene.instantiate()
	var member: BandMemberController = member_entity.get_node("controller")
	player.get_node("band_leader").add_member(member)

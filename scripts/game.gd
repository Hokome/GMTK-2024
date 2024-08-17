extends Node
class_name Game

var player: Entity

func start():
	var level_scene := preload("res://scenes/test_level.tscn")
	var level = level_scene.instantiate()
	add_child(level)
	
	spawn_player()


func spawn_player():
	var player_scene := preload("res://scenes/player.tscn")
	player = player_scene.instantiate()
	add_child(player)
	
	spawn_member()
	spawn_member()

func spawn_member():
	var member_scene := preload("res://scenes/band_member.tscn")
	var member_entity: Entity = member_scene.instantiate()
	member_entity.name = "member"
	var member: BandMemberController = member_entity.get_node("controller")
	player.get_node("band_leader").add_member(member)
	

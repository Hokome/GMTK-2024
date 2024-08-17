extends Node
class_name Game

var player: Entity

func start():
	spawn_player()

func spawn_player():
	var level_scene :=preload("res://scenes/test_level.tscn")
	var player_scene := preload("res://scenes/player.tscn")
	player = player_scene.instantiate()
	var level = level_scene.instantiate()
	add_child(level)
	add_child(player)
	
	var member_scene := preload("res://scenes/band_member.tscn")
	var member_entity: Entity = member_scene.instantiate()
	var member_entity2: Entity = member_scene.instantiate()
	member_entity.name="entity1"
	member_entity2.name="entity2"
	var member: BandMemberController = member_entity.get_node("controller")
	var member2: BandMemberController = member_entity2.get_node("controller")
	player.get_node("band_leader").add_member(member)
	player.get_node("band_leader").add_member(member2)
	level.get_node("Spawner").leader_ref = player as Entity

extends Node
class_name Game

var menu: MenuManager
var player: Entity
var paused := false:
	set(val):
		paused = val
		Engine.time_scale = 0 if paused else 1

var start_time := 0
var started := false

func start():
	started = true
	hud.visible = true
	
	var level_scene := preload("res://scenes/test_level.tscn")
	var level = level_scene.instantiate()
	add_child(level)
	
	spawn_player()
	start_time = Time.get_unix_time_from_system()

func spawn_player():
	var player_scene := preload("res://scenes/player.tscn")
	player = player_scene.instantiate()
	add_child(player)
	player.get_node("health").died.connect(game_over)
	
	spawn_member()
	spawn_member()
	
func spawn_member():
	var member_scene := preload("res://scenes/band_member.tscn")
	var member_entity: Entity = member_scene.instantiate()
	member_entity.name = "member"
	var member: BandMemberController = member_entity.get_node("member_controller")
	player.get_node("band_leader").add_member(member)
	
func game_over():
	paused = true
	menu.select_menu("game_over")

func cleanup():
	started = false
	for c in get_children():
		c.queue_free()
	paused = false
	hud.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo(): return
	if event.is_pressed():
		if event.is_action("pause"):
			menu.select_menu("pause")
			paused = true

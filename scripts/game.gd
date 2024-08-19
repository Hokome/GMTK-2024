extends Node
class_name Game

const BPM: float = 125.0
const ANIMATION_FPS: float = (BPM / 60.0)

var menu: MenuManager
var player: Entity
var xp: XP
var paused := false:
	set(val):
		paused = val
		Engine.time_scale = 0 if paused else 1

var elapsed_time := 0.0
var started := false

var tilemap_layer:TileMapLayer

var upgrades: Array[BandMemberUpgrade] = [
	preload("res://assets/upgrades/bass_drum_upgrade.tres"),
	preload("res://assets/upgrades/snare_drum_upgrade.tres"),
	preload("res://assets/upgrades/tuba_upgrade.tres"),
	preload("res://assets/upgrades/cymbal_upgrade.tres"),
	#preload("res://assets/upgrades/trumpet_upgrade.tres"),
	preload("res://assets/upgrades/keytar_upgrade.tres"),
	preload("res://assets/upgrades/piano_upgrade.tres"),
	preload("res://assets/upgrades/flute_upgrade.tres"),
	preload("res://assets/upgrades/strings_upgrade.tres"),
]
var xp_drops: Dictionary = {
	1: preload("res://scenes/xp_drop.tscn"),
}

func _process(delta: float) -> void:
	elapsed_time += delta
	hud.update_time(elapsed_time)

func start():
	var upgrade_menu: UpgradeMenu = menu.get_node("upgrade")
	if !upgrade_menu.upgrade_chosen.is_connected(game.spawn_member):
		upgrade_menu.upgrade_chosen.connect(game.spawn_member)

	started = true
	hud.visible = true
	
	var level_scene := preload("res://scenes/test_level.tscn")
	var level = level_scene.instantiate()
	tilemap_layer = level.get_node("tile_map_layer") as TileMapLayer
	add_child(level)
	
	spawn_player()
	
	xp = XP.new()
	xp.value_changed.connect(hud.set_xp)
	add_child(xp)
	hud.set_next_xp(xp.next)
	xp.current = 0
	
	elapsed_time = 0.0

func spawn_player():
	var player_scene := preload("res://scenes/player.tscn")
	player = player_scene.instantiate()
	add_child(player)
	player.get_node("health").died.connect(game_over)
	
	#for u in upgrades:
		#spawn_member(u)
	spawn_member(upgrades[0])

func spawn_member(upgrade: BandMemberUpgrade):
	var member_scene := preload("res://scenes/band_member.tscn")
	var member_entity: Entity = member_scene.instantiate()
	member_entity.name = "member"
	var member: BandMemberController = member_entity.get_node("member_controller")
	var leader: BandLeader = player.get_node("band_leader")
	leader.add_member(member)
	leader.add_track(upgrade.track)
	
	member_entity.add_child(upgrade.attack.instantiate())
	var sprite: AnimatedSprite2D = member_entity.get_node("sprite")
	sprite.sprite_frames = upgrade.frames
	upgrade.frames.set_animation_speed("default", ANIMATION_FPS)
	sprite.animation = "default"
	sprite.play()

func loot(value: int, position: Vector2):
	for i in value:
		var scene: PackedScene = xp_drops[1]
		var drop: XPDrop = scene.instantiate()
		add_child(drop)
		drop.position = position

func select_upgrades() -> Array[BandMemberUpgrade]:
	const UPGRADE_COUNT := 3
	if upgrades.size() < UPGRADE_COUNT: upgrades
	var selection: Array[BandMemberUpgrade] = []
	while selection.size() < UPGRADE_COUNT:
		var upgrade: BandMemberUpgrade = upgrades.pick_random()
		if selection.has(upgrade): continue
		selection.append(upgrade)
	return selection

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
			if !started or paused: return
			menu.select_menu("pause")
			paused = true

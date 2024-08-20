extends Node
class_name XP

signal value_changed(new_value: int)
signal level_upped(new_next: int)

var current: int = 0:
	set(val):
		current = val
		value_changed.emit(current)
		if val >= next:
			level_up()

var level: int = 0

var next: int = 2
const GROWTH: int = 1

var audio_source: AudioStreamPlayer
var xp_collect_index := 0
var xp_collect_sfx: Array[AudioStreamWAV] = [
	preload("res://assets/sfx/xp_1.wav"),
	preload("res://assets/sfx/xp_2.wav"),
	preload("res://assets/sfx/xp_3.wav"),
	preload("res://assets/sfx/xp_4.wav"),
	preload("res://assets/sfx/xp_5.wav"),
	preload("res://assets/sfx/xp_6.wav"),
	preload("res://assets/sfx/xp_7.wav"),
	preload("res://assets/sfx/xp_8.wav"),
]

func _ready() -> void:
	audio_source = AudioStreamPlayer.new()
	audio_source.bus = "SFX"
	add_child(audio_source)

func level_up():
	level += 1
	game.paused = true
	var upgrade_menu: UpgradeMenu = game.menu.select_menu("upgrade")
	upgrade_menu.show_upgrades(game.select_upgrades())
	
	var old_next := next
	next += GROWTH
	level_upped.emit(next)
	current -= old_next

func play_sound():
	if !audio_source.playing:
		audio_source.stream = xp_collect_sfx[xp_collect_index]
		xp_collect_index = posmod(xp_collect_index + 1, xp_collect_sfx.size())
		audio_source.play()

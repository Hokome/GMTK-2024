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

var next: int = 10
const GROWTH: int = 10

func level_up():
	level += 1
	game.paused = true
	game.menu.select_menu("upgrade")
	var old_next := next
	next += GROWTH
	level_upped.emit(next)
	current -= old_next

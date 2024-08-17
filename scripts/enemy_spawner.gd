extends Node2D

var spawn = preload("res://scenes/enemy.tscn")
var limit: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_timer_timeout() -> void:
	if limit<=0:
		$timer.stop()
	var temp = spawn.instantiate()
	temp.get_node("follow_player").target = game.player
	get_parent().add_child(temp)
	limit-=1

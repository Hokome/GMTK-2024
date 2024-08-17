extends Node2D

var spawn = preload("res://scenes/enemy.tscn")
var limit: int = 10
var offset: float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_timer_timeout() -> void:
	if limit<=0:
		$timer.stop()
	var enemy: Entity = spawn.instantiate()
	game.add_child(enemy)
	var random_direction := Vector2(randf() - 0.5, randf() - 0.5).normalized()
	enemy.global_position = random_direction * offset
	
	enemy.get_node("follow_player").target = game.player
	
	limit-=1

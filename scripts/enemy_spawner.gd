extends Node2D
class_name Spawner

var spawn = preload("res://scenes/enemy.tscn")
var offset: float = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_timer_timeout() -> void:
	var enemy: Entity = spawn.instantiate()
	game.add_child(enemy)
	var random_direction := Vector2(randf() - 0.5, randf() - 0.5).normalized()
	enemy.global_position = global_position + random_direction * offset
	
	enemy.get_node("follow_player").target = game.player

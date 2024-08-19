extends Node2D
class_name Spawner

var spawn = preload("res://scenes/enemy.tscn")
var offset: float = 500
const HP_PER_SECOND: float = 0.5

func _on_timer_timeout() -> void:
	var enemy: Entity = spawn.instantiate()
	game.add_child(enemy)
	var random_direction := Vector2(randf() - 0.5, randf() - 0.5).normalized()
	enemy.global_position = global_position + random_direction * offset
	
	enemy.get_node("follow_player").target = game.player
	var enemy_health: Health = enemy.get_node("health")
	enemy_health.max_health += HP_PER_SECOND / game.elapsed_time
	enemy_health.health = enemy_health.max_health

extends Node2D
class_name Spawner

var spawn = preload("res://scenes/enemy.tscn")
var offset: float = 500
const HP_PER_SECOND: float = 0.5

var tilemap_layer:TileMapLayer

func _ready() -> void:
	tilemap_layer = game.tilemap_layer

func _on_timer_timeout() -> void:
	var enemy: Entity = spawn.instantiate()
	game.add_child(enemy)
	
	var spawn_loc
	var counter = 10
	while counter>0:
		counter-=1
		var random_direction= Vector2(randf() - 0.5, randf() - 0.5).normalized()
		#spawn_loc = global_position + random_direction * offset
		spawn_loc = get_global_mouse_position()
		var tile = tilemap_layer.get_cell_tile_data(tilemap_layer.local_to_map(spawn_loc))
		if !tile || !tile.get_custom_data("spawnable"):	
			print(tilemap_layer.local_to_map(spawn_loc),tile)
			enemy.queue_free()
			return
	
	enemy.global_position = spawn_loc
	
	enemy.get_node("follow_player").target = game.player
	var enemy_health: Health = enemy.get_node("health")
	enemy_health.max_health += HP_PER_SECOND / game.elapsed_time
	enemy_health.health = enemy_health.max_health

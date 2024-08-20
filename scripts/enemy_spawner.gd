extends Node2D
class_name Spawner

var spawn = preload("res://scenes/enemy.tscn")
var offset: float = 3
const HP_PER_SECOND: float = 1

var tilemap_layer: TileMapLayer
var spawn_rect: Rect2

func _ready() -> void:
	tilemap_layer = game.tilemap_layer
	spawn_rect = tilemap_layer.get_used_rect()
	var tile_scale := tilemap_layer.tile_set.tile_size.x
	spawn_rect.position *= tile_scale
	spawn_rect.size *= tile_scale

func _on_timer_timeout() -> void:
	var enemy: Entity = spawn.instantiate()
	game.add_child(enemy)
	
	var spawn_position: Vector2
	var counter = 50
	while true:
		counter -= 1
		if counter <= 0:
			push_warning("Enemy spawning is taking too long")
			enemy.queue_free()
			return
		spawn_position = Vector2(
			randf_range(spawn_rect.position.x, spawn_rect.end.x),
			randf_range(spawn_rect.position.y, spawn_rect.end.y))
		#print(spawn_position)
				
		
		
		var t = get_tree().get_nodes_in_group("band")
		#print(t)
		for m in t:
			var mem = m as Node2D
			var dist = mem.position.distance_to(spawn_position*offset)
			print("dist",dist)
			if dist<50:
				spawn_position=spawn_position-mem.position.direction_to(spawn_position*offset)
				break
			
		var data := tilemap_layer.get_cell_tile_data(tilemap_layer.local_to_map(spawn_position))
		if !data: continue
		var spawnable = data.get_custom_data("spawnable")
		
		if spawnable:
			spawn_position *= offset
			break
	
	enemy.global_position = spawn_position
	
	
	enemy.get_node("follow_player").target = game.player
	var enemy_health: Health = enemy.get_node("health")
	enemy_health.max_health += HP_PER_SECOND / game.elapsed_time
	enemy_health.health = enemy_health.max_health

extends Area2D
class_name Collectible

signal collected

@export var magnet_distance: float = 100
@export var magnet_speed: float = 200
@onready var magnet_distance_sqr: float = magnet_distance * magnet_distance

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	var diff := game.player.global_position - global_position
	if diff.length_squared() < magnet_distance_sqr:
		position += magnet_speed * delta * diff.normalized()

func _on_body_entered(body: Node2D) -> void:
	if body == game.player:
		collected.emit()
		queue_free()

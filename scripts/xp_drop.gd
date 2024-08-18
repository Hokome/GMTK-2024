extends Area2D
class_name XPDrop

const MAGNET_DISTANCE: float = 100
const MAGNET_DISTANCE_SQR: float = MAGNET_DISTANCE * MAGNET_DISTANCE
const MAGNET_SPEED: float = 200

@export var amount: int = 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	var diff := game.player.global_position - global_position
	if diff.length_squared() < MAGNET_DISTANCE_SQR:
		position += MAGNET_SPEED * delta * diff.normalized()

func _on_body_entered(body: Node2D) -> void:
	if body == game.player:
		game.xp.current += amount
		queue_free()

extends Area2D

@export var damage: float

var hit_bodies: Array[Node2D] = []

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is not Entity: return
	if hit_bodies.has(body): return
	
	hit_bodies.append(body)
	body.get_node("health").damage(damage)
	
func reset_hit():
	hit_bodies.clear()

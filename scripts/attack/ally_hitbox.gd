extends Area2D
class_name AllyHitbox

@export var damage: float

var hit_bodies: Array[Node2D] = []
var colliding_bodies: Array[Node2D]

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is not Entity: return
	if hit_bodies.has(body): return
	
	colliding_bodies.append(body)
	body.get_node("health").damage(damage)

func _on_body_exited(body: Node2D) -> void:
	if body is not Entity: return
	if colliding_bodies.has(body):
		colliding_bodies.erase(body)

func reset_hit():
	hit_bodies.clear()
	for b in colliding_bodies:
		b.get_node("health").damage(damage)

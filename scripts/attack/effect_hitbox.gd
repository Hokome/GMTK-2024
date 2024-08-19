extends Area2D
class_name EffectHitbox

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is not Entity: return

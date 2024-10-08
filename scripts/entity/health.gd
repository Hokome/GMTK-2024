extends Node
class_name Health

signal died
signal health_changed(new_value: float)
signal damage_taken(damage: float)

@export var invincible := false

@export var max_health: float = 100
var health: float:
	set(value):
		var old := health
		health = clamp(value, 0, max_health)
		if old == health: return
		
		health_changed.emit(health)
		if value <= 0:
			die()

func _physics_process(delta: float) -> void:
	invincible = false

func _ready() -> void:
	health = max_health

func damage(amount: float):
	if invincible: return
	health -= amount
	damage_taken.emit(amount)

func die() -> void:
	died.emit()

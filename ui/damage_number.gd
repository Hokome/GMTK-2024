extends Node2D
class_name DamageNumber

@export var label: Label

func set_damage(damage: float) -> void:
	label.text = "%s" % floori(damage)

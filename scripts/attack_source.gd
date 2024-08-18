extends Node
class_name AttackSource

var attack_scene: PackedScene

@onready var timer := Timer.new()

func _ready() -> void:
	add_child(timer)

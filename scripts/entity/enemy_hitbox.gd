extends Area2D
class_name EnemyHitbox

@export var damage: float
@onready var attack_cooldown: Timer = $cooldown

var overlapping_body_count: int = 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _physics_process(_delta: float) -> void:
	if attack_cooldown and attack_cooldown.time_left: return
	
	if overlapping_body_count:
		game.player.get_node("health").damage(damage)
		if attack_cooldown: attack_cooldown.start()

func _on_body_entered(body: Node2D) -> void:
	if body is not Entity: return
	
	overlapping_body_count += 1

func _on_body_exited(body: Node2D) -> void:
	if body is not Entity: return
	overlapping_body_count -= 1

extends CanvasLayer
class_name HUD

@export var time_label: Label
@export var xp_bar: ProgressBar

func set_xp(value: int) -> void:
	xp_bar.value = value

func set_next_xp(value: int) -> void:
	xp_bar.max_value = value

func update_time(time: float):
	var minutes := floori(time / 60)
	var seconds := floori(fmod(time, 60))
	var remainder := floori(fmod(time, 1) * 10)
	
	time_label.text = "%02d:%02d:%s" % [minutes, seconds, remainder]

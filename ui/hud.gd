extends CanvasLayer
class_name HUD

@export var time_label: Label
@export var xp_bar: ProgressBar

func _process(_delta: float) -> void:
	if !game.started: return
	var elapsed_time: float = Time.get_ticks_usec() - game.start_time
	elapsed_time /= 1000.0
	elapsed_time = roundf(elapsed_time)
	
	var time_dict := Time.get_datetime_dict_from_unix_time(elapsed_time)

func set_xp(value: int) -> void:
	xp_bar.value = value

func set_next_xp(value: int) -> void:
	xp_bar.max_value = value

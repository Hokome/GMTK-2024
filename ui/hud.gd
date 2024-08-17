extends CanvasLayer
class_name HUD

@export var time_label: Label

func _process(delta: float) -> void:
	if !game.started: return
	var elapsed_time := Time.get_ticks_usec() - game.start_time
	elapsed_time /= 1000.0
	elapsed_time = roundf(elapsed_time)
	
	var time_dict := Time.get_datetime_dict_from_unix_time(elapsed_time)

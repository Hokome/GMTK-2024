extends Control
class_name SettingsMenu

func _ready() -> void:
	AudioServer.add_bus()
	AudioServer.add_bus()
	AudioServer.set_bus_name(1, "Music")
	AudioServer.set_bus_name(2, "SFX")

func slider_to_db(value: float) -> float:
	return lerpf(-20, 0, value / 100.0)

func _on_audio_slider_value_changed(value: float, channel: StringName) -> void:
	var bus_index := AudioServer.get_bus_index(channel)
	AudioServer.set_bus_mute(bus_index, value <= 0)
	
	var volume_db := slider_to_db(value)
	AudioServer.set_bus_volume_db(bus_index, volume_db)

func _on_save_pressed() -> void:
	game.menu.back()

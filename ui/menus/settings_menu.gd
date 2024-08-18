extends Control
class_name SettingsMenu

@onready var res_drop_down: OptionButton = $center_container/entire_container/v_box_container/resolution_container/res_drop_down
@onready var window_drop_down: OptionButton = $center_container/entire_container/v_box_container/resolution_container/window_drop_down

var resolutions : Dictionary = {
	"800x600":Vector2i(800, 600),
	"1152x648":Vector2i(1152, 648),
	"1280x728":Vector2i(1280, 728),
	"1920x1080":Vector2i(1920, 1080),
}

var window_modes : Dictionary = {
	"Window":DisplayServer.WINDOW_MODE_WINDOWED,
	"Fullscreen":DisplayServer.WINDOW_MODE_FULLSCREEN
}

func _ready() -> void:
	AudioServer.add_bus()
	AudioServer.add_bus()
	AudioServer.set_bus_name(1, "Music")
	AudioServer.set_bus_name(2, "SFX")
	add_resolutions_to_option_btns()
	res_drop_down.selected=1
	window_drop_down.selected=0

func slider_to_db(value: float) -> float:
	return lerpf(-20, 0, value / 100.0)

func _on_audio_slider_value_changed(value: float, channel: StringName) -> void:
	var bus_index := AudioServer.get_bus_index(channel)
	AudioServer.set_bus_mute(bus_index, value <= 0)
	
	var volume_db := slider_to_db(value)
	AudioServer.set_bus_volume_db(bus_index, volume_db)

func _on_save_pressed() -> void:
	save_prefs()
	game.menu.back()

func add_resolutions_to_option_btns():
	for r in resolutions:
		res_drop_down.add_item(r)
	for m in window_modes:
		window_drop_down.add_item(m)

func _on_res_drop_down_item_selected(index: int) -> void:
	var key = res_drop_down.get_item_text(index)
	var size = resolutions.get(key)
	get_window().set_size(size)
	
	var screen_center = DisplayServer.screen_get_position()+DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(screen_center-window_size/2)

func _on_border_check_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,toggled_on)

func _on_window_drop_down_item_selected(index: int) -> void:
	DisplayServer.window_set_mode(window_modes.get(window_drop_down.get_item_text(index)))

func save_prefs():
	
	pass

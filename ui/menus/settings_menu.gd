class_name SettingsMenu extends Control

@onready var res_drop_down: OptionButton = $center_container/entire_container/v_box_container/resolution_container/res_drop_down
@onready var window_drop_down: OptionButton = $center_container/entire_container/v_box_container/resolution_container/window_drop_down

@onready var master_slider: VSlider = $center_container/entire_container/v_box_container/music_container/master_slider
@onready var music_slider: VSlider = $center_container/entire_container/v_box_container/music_container/music_slider
@onready var sfx_slider: VSlider = $center_container/entire_container/v_box_container/music_container/sfx_slider

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

var user_settings:UserSettings

func _ready() -> void:
	add_resolutions_to_option_btns()
	res_drop_down.selected=1
	window_drop_down.selected=0
	load_settings()

func load_settings()-> void:
	user_settings = UserSettings.load_or_create()
	
	master_slider.value = user_settings.master_vol
	music_slider.value = user_settings.music_vol
	sfx_slider.value = user_settings.sfx_vol

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
	if user_settings:
		
		user_settings.master_vol = master_slider.value
		user_settings.music_vol = music_slider.value
		user_settings.sfx_vol = sfx_slider.value
		user_settings.save()

func _on_input_pressed() -> void:
	game.menu.push_menu("input_remapping")

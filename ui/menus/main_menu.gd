extends Control
class_name MainMenu

func _on_start_pressed() -> void:
	game.start()
	game.menu.select_menu(null)
	$main_theme.stop()

func _on_settings_pressed() -> void:
	game.menu.push_menu("settings")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_visibility_changed() -> void:
	if !$main_theme.is_inside_tree(): return
	
	if visible:
		$main_theme.play()

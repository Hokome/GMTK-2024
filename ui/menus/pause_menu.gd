extends Control

func _on_resume_pressed() -> void:
	game.paused = false
	game.menu.select_menu(null)

func _on_settings_pressed() -> void:
	game.menu.push_menu("settings")

func _on_quit_pressed() -> void:
	get_tree().quit()

extends Control

func _on_resume_btn_pressed() -> void:
	game.paused = false
	game.menu.select_menu(null)

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

extends Control
class_name MainMenu

func _on_start_pressed() -> void:
	game.start()
	game.menu.select_menu(null)

func _on_quit_pressed() -> void:
	get_tree().quit()

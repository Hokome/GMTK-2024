extends CanvasLayer
class_name MainMenu

func _on_start_pressed() -> void:
	game.start()
	visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()

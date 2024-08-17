extends Control


func _on_retry_pressed() -> void:
	game.cleanup()
	game.start.call_deferred()
	game.menu.select_menu(null)


func _on_back_pressed() -> void:
	game.cleanup()
	game.menu.select_menu("main")

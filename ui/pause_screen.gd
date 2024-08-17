extends Control

func _on_resume_btn_pressed() -> void:
	print("RESUME GAME")
	pass # Replace with function body.

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

extends Control

func _on_back_pressed() -> void:
	print("back")
	game.cleanup()
	game.menu.select_menu("main")

func _on_visibility_changed() -> void:
	if !is_inside_tree(): return
	$center_container/v_box_container/back.grab_focus()

extends CanvasLayer
class_name MenuManager

@export var starting_menu: Control

var current_menu: Control

func _ready():
	game.menu = self
	select_menu(starting_menu)

func select_menu(menu):
	if current_menu:
		current_menu.visible = false
	
	if menu == null: return
	
	if menu is String:
		if menu.is_empty(): return
		current_menu = get_node(menu)
	if menu is Control:
		current_menu = menu
	
	if current_menu:
		current_menu.visible = true

func exit():
	get_tree().quit()

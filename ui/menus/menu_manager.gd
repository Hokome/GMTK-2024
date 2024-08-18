extends CanvasLayer
class_name MenuManager

@export var starting_menu: Control

var current_menu: Control
var menu_stack: Array[Control] = []

func _ready():
	game.menu = self
	select_menu(starting_menu)

func select_menu(menu):
	menu_stack.clear()
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

func push_menu(menu):
	if menu == null: return
	
	var next_menu: Control
	if menu is String:
		if menu.is_empty(): return
		next_menu = get_node(menu)
	if menu is Control:
		next_menu = menu
	
	if current_menu != null:
		current_menu.visible = false
		menu_stack.push_back(current_menu)
	
	current_menu = next_menu
	current_menu.visible = true

func back() -> void:
	if menu_stack.is_empty(): return
	
	current_menu.visible = false
	
	current_menu = menu_stack.pop_back()
	current_menu.visible = true

func exit():
	get_tree().quit()

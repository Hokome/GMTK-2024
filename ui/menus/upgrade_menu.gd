extends Control
class_name UpgradeMenu

signal upgrade_chosen(upgrade: BandMemberUpgrade)

@export var buttons_parent: Control
@export var button_scene: PackedScene

func show_upgrades(upgrades: Array[BandMemberUpgrade]):
	for upgrade in upgrades:
		var option: UpgradeOption = button_scene.instantiate()
		buttons_parent.add_child(option)
		option.upgrade = upgrade
		
		option.button.pressed.connect(choose_upgrade.bind(upgrade))

func choose_upgrade(upgrade: BandMemberUpgrade):
	upgrade_chosen.emit(upgrade)
	game.menu.select_menu(null)
	game.paused = false
	for c in buttons_parent.get_children():
		c.queue_free()

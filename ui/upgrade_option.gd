extends Control
class_name UpgradeOption

@export var title_label: Label
@export var description_text: RichTextLabel
@export var icon_rect: TextureRect
@export var button: Button

var upgrade: BandMemberUpgrade:
	set(val):
		upgrade = val
		
		title_label.text = upgrade.title
		description_text.text = upgrade.description
		icon_rect.texture = upgrade.icon

extends PanelContainer

var action_list: Control
@export var input_remapper_scene: PackedScene
var is_remapping := false
var action_to_remap = null
var remapping_button: Button

var remappable_inputs = {
	"print": "Print",
}

func _ready():
	InputMap.load_from_project_settings()
	action_list = %Actions
	for c in action_list.get_children():
		c.queue_free()
	
	for action in remappable_inputs:
		var remapper = input_remapper_scene.instantiate()
		var action_label: Label = remapper.get_node("ActionName")
		var remap_button: Button = remapper.get_node("RemapButton")
		
		action_label.text = remappable_inputs[action]
		var events := InputMap.action_get_events(action)
		if events.size() > 0:
			remap_button.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			remap_button.text = "None"
		
		action_list.add_child(remapper)
		remap_button.pressed.connect(_on_input_button_pressed.bind(remap_button, action))

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.text = "Press key..."

func _input(event):
	if !is_remapping: return
	if !(event is InputEventKey or event is InputEventMouseButton): return
	if !event.is_pressed(): return
	
	InputMap.action_erase_events(action_to_remap)
	InputMap.action_add_event(action_to_remap, event)
	remapping_button.text = event.as_text().trim_suffix(" (Physical)")
	
	is_remapping = false
	action_to_remap = null
	remapping_button = null
	
	accept_event()

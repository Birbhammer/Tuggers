extends Control

@onready var InputButtonScene = preload("res://InputSettings/input_button.tscn")
@onready var ActionList = $PanelContainer/TabContainer/Keybinds/VBoxContainer/ActionList

var is_remapping = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"Left-Key1": "P1 Left",
	"Right-Key1": "P1 Right",
	"Jump-Key1": "P1 Jump",
	"Left-Key2": "P2 Left",
	"Right-Key2": "P2 Right",
	"Jump-Key2": "P2 Jump",
}

func _ready() -> void:
	CreateActionList()

func CreateActionList():
	InputMap.load_from_project_settings()
	
	for item in ActionList.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button: Button = InputButtonScene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		
		ActionList.add_child(button)
		button.pressed.connect(OnInputButtonPressed.bind(button,action))

func OnInputButtonPressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press Input..."


func _input(event):
	if is_remapping:
		if (event is InputEventKey):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			UpdateActionList(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()

func UpdateActionList(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")

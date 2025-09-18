extends Node

@onready var base: Node2D = $Base
@onready var credits: Node2D = $Credits
@onready var options: Node2D = $Options
@onready var characterselect: Node2D = $CharacterSelectMenu
@onready var backbutton: Button = $BackButton

var DisplaySetting = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
var ResolutionSetting = Vector2(1920,1080)

@export var P1_Controls: Resource = null
@export var P2_Controls: Resource = null

@onready var P1_Selection_Controller: Marker2D = $CharacterSelectMenu/SelectionControllers/P1
@onready var P2_Selection_Controller: Marker2D = $CharacterSelectMenu/SelectionControllers/P2

@onready var ChadPOS: Marker2D = $CharacterSelectMenu/SelectionPOS/ChadPOS
@onready var NerdPOS: Marker2D = $CharacterSelectMenu/SelectionPOS/NerdPOS
@onready var ResetPOS1: Marker2D = $CharacterSelectMenu/SelectionPOS/ResetPOSP1
@onready var ResetPOS2: Marker2D = $CharacterSelectMenu/SelectionPOS/ResetPOSP2

var NerdLocalIndex: int = 99
var ChadLocalIndex: int = 98

func _ready() -> void:
	base.visible = true
	credits.visible = false
	options.visible = false
	characterselect.visible = false
	backbutton.visible = false

func _on_start_button_pressed() -> void:
	#Add logic for selecting controllers
	#get_tree().change_scene_to_file("res://Levels/main.tscn")
	base.visible = false
	characterselect.visible = true
	backbutton.visible = true


func _on_options_button_pressed() -> void:
	base.visible = false
	options.visible = true
	backbutton.visible = true


func _on_credits_button_pressed() -> void:
	base.visible = false
	credits.visible = true
	backbutton.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/tutorial.tscn")


func _on_back_button_pressed() -> void:
	base.visible = true
	credits.visible = false
	options.visible = false
	characterselect.visible = false
	backbutton.visible = false


func _on_display_mode_list_item_selected(index: int) -> void:
	match index:
		0:
			DisplaySetting = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
		1:
			DisplaySetting = DisplayServer.WINDOW_MODE_WINDOWED


func _on_apply_graphics_button_pressed() -> void:
	DisplayServer.window_set_mode(DisplaySetting)
	DisplayServer.window_set_size(ResolutionSetting)
	DisplayServer.window_set_position(Vector2(50, 50))


func _on_resolution_list_item_selected(index: int) -> void:
	match index:
		0:
			ResolutionSetting = Vector2(1920,1080)
		1:
			ResolutionSetting = Vector2(1280,720)
		2:
			ResolutionSetting = Vector2(640,480)

func _process(delta: float) -> void:
	if characterselect.visible == true:
		#Player 1
		if Input.is_action_just_pressed(P1_Controls.Left):
			if P1_Selection_Controller.position == ResetPOS1.position:
				if ChadLocalIndex != 1:
					P1_Selection_Controller.position = ChadPOS.position
					ChadLocalIndex = 0
			if P1_Selection_Controller.position == NerdPOS.position:
				P1_Selection_Controller.position = ResetPOS1.position
				NerdLocalIndex = 99
		if Input.is_action_just_pressed(P1_Controls.Right):
			if P1_Selection_Controller.position == ResetPOS1.position:
				if NerdLocalIndex != 1:
					P1_Selection_Controller.position = NerdPOS.position
					NerdLocalIndex = 0
			if P1_Selection_Controller.position == ChadPOS.position:
				P1_Selection_Controller.position = ResetPOS1.position
				ChadLocalIndex = 98
				#Player 2
		if Input.is_action_just_pressed(P2_Controls.Left):
			if P2_Selection_Controller.position == ResetPOS2.position:
				if ChadLocalIndex != 0:
					P2_Selection_Controller.position = ChadPOS.position
					ChadLocalIndex = 1
			if P2_Selection_Controller.position == NerdPOS.position:
				P2_Selection_Controller.position = ResetPOS2.position
				NerdLocalIndex = 99
		if Input.is_action_just_pressed(P2_Controls.Right):
			if P2_Selection_Controller.position == ResetPOS2.position:
				if NerdLocalIndex != 0:
					P2_Selection_Controller.position = NerdPOS.position
					NerdLocalIndex = 1
			if P2_Selection_Controller.position == ChadPOS.position:
				P2_Selection_Controller.position = ResetPOS2.position
				ChadLocalIndex = 98


func _unhandled_input(event: InputEvent) -> void:
	if 1 == 5:
		#Player 1
		if event.is_action_pressed(P1_Controls.Left):
			if P1_Selection_Controller.position == ResetPOS1.position:
				if ChadLocalIndex != 1:
					P1_Selection_Controller.position = ChadPOS.position
					ChadLocalIndex = 0
			if P1_Selection_Controller.position == NerdPOS.position:
				P1_Selection_Controller.position = ResetPOS1.position
				NerdLocalIndex = 99
		if event.is_action_pressed(P1_Controls.Right):
			if P1_Selection_Controller.position == ChadPOS.position:
				P1_Selection_Controller.position = ResetPOS1.position
				ChadLocalIndex = 98
			if P1_Selection_Controller.position == ResetPOS1.position:
				if NerdLocalIndex != 1:
					P1_Selection_Controller.position = NerdPOS.position
					NerdLocalIndex = 0
				#Player 2
		if event.is_action_pressed(P2_Controls.Left):
			if P2_Selection_Controller.position == ResetPOS2.position:
				if ChadLocalIndex != 0:
					P2_Selection_Controller.position = ChadPOS.position
					ChadLocalIndex = 1
			if P2_Selection_Controller.position == NerdPOS.position:
				P2_Selection_Controller.position = ResetPOS2.position
				NerdLocalIndex = 99
		if event.is_action_pressed(P2_Controls.Right):
			if P2_Selection_Controller.position == ChadPOS.position:
				P2_Selection_Controller.position = ResetPOS2.position
				ChadLocalIndex = 98
			if P2_Selection_Controller.position == ResetPOS2.position:
				if NerdLocalIndex != 0:
					P2_Selection_Controller.position = NerdPOS.position
					NerdLocalIndex = 1

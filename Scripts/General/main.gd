extends Node

@onready var viewport1: SubViewport = $VBoxContainer/SubViewportContainer/SubViewport
@onready var viewport2: SubViewport = $VBoxContainer/SubViewportContainer2/SubViewport

#Camera Tracking
@onready var camera1: Camera2D = $VBoxContainer/SubViewportContainer/SubViewport/NerdCamera
@onready var camera2: Camera2D = $VBoxContainer/SubViewportContainer2/SubViewport/ChadCamera
@export var NerdTrackingPOS: Vector2
@export var ChadTrackingPOS: Vector2
@export var CameraSpeed: float

@onready var chad: CharacterBody2D = $VBoxContainer/SubViewportContainer/SubViewport/Game/Players/Chad
@onready var nerd: CharacterBody2D = $VBoxContainer/SubViewportContainer/SubViewport/Game/Players/Nerd

@onready var PauseMenu: Control = $InputSettings
@onready var MusicBar: HSlider = $InputSettings/PanelContainer/TabContainer/Sound/HSlider

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	viewport2.world_2d = viewport1.world_2d
	PauseMenu.visible = false
	MusicBar.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))

func _process(delta: float) -> void:
	#*******************************Nerd Velocity Tracking******************************************
	#Camera Y offset is controlled by normalized vector. Might need some playing with to get feeling smooth
	var NerdVelocity = Vector2(nerd.get_real_velocity().x, nerd.get_real_velocity().y)
	var NerdNormalizedVel = NerdVelocity.normalized()
	var NerdAdjust = Vector2(nerd.position.x + 900, (nerd.position.y + NerdNormalizedVel.y * 1500))
	NerdTrackingPOS = NerdAdjust + Vector2(NerdNormalizedVel.x, (-NerdNormalizedVel.y * .10) * 900)
	#***********************************************************************************************
	#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Chad Velocity Tracking$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	#Camera Y offset is controlled by normalized vector. Might need some playing with to get feeling smooth
	var ChadVelocity = Vector2(chad.get_real_velocity().x, chad.get_real_velocity().y)
	var ChadNormalizedVel = ChadVelocity.normalized()
	var ChadAdjust = Vector2(chad.position.x - 900, (chad.position.y + ChadNormalizedVel.y * 1500))
	ChadTrackingPOS = ChadAdjust + Vector2(ChadNormalizedVel.x, (-ChadNormalizedVel.y * .10) * 900)
	#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	camera1.position = camera1.position.lerp(NerdTrackingPOS, CameraSpeed * delta)
	camera2.position = camera2.position.lerp(ChadTrackingPOS, CameraSpeed * delta)
	
	
	if Input.is_action_just_pressed("Menu"):
		PauseMenu.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	


func _on_resume_button_pressed() -> void:
	PauseMenu.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/menu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

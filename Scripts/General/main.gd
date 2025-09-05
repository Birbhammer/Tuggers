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

func _ready() -> void:
	viewport2.world_2d = viewport1.world_2d

func _process(delta: float) -> void:
	#--This could use a normalized vector of projected velocity instead of hard coded position-------

	#NerdTrackingPOS = Vector2(nerd.position.x + 900, nerd.position.y)
	#ChadTrackingPOS = Vector2(chad.position.x + 900, chad.position.y)
			#Idea will be for camera to track where player is going not just infront of them
	
	#************************************Velocity Tracking******************************************
	#Camera Y offset is controlled by normalized vector. Might need some playing with to get feeling smooth
	var NerdVelocity = Vector2(nerd.get_real_velocity().x, nerd.get_real_velocity().y)
	var NerdNormalizedVel = NerdVelocity.normalized()
	var NerdAdjust = Vector2(nerd.position.x + 900, (nerd.position.y + NerdNormalizedVel.y * 1500))
	NerdTrackingPOS = NerdAdjust + Vector2(NerdNormalizedVel.x, (-NerdNormalizedVel.y * .10) * 900)
	#------------------------------------------------------------------------------------------------
	camera1.position = camera1.position.lerp(NerdTrackingPOS, CameraSpeed * delta)
	camera2.position = camera2.position.lerp(ChadTrackingPOS, CameraSpeed * delta)
	
	

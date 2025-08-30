extends Node

@onready var viewport1: SubViewport = $VBoxContainer/SubViewportContainer/SubViewport
@onready var viewport2: SubViewport = $VBoxContainer/SubViewportContainer2/SubViewport
@onready var camera1: Camera2D = $VBoxContainer/SubViewportContainer/SubViewport/Camera2D
@onready var camera2: Camera2D = $VBoxContainer/SubViewportContainer2/SubViewport/Camera2D
@onready var chad: CharacterBody2D = $VBoxContainer/SubViewportContainer/SubViewport/Game/Players/Chad
@onready var nerd: CharacterBody2D = $VBoxContainer/SubViewportContainer/SubViewport/Game/Players/Nerd

func _ready() -> void:
	viewport2.world_2d = viewport1.world_2d

func _process(delta: float) -> void:
	camera1.position = nerd.position
	camera2.position = chad.position

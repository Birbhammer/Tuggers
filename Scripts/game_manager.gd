extends Node

@onready var NerdStart: Marker2D = $NerdRoomGenerator/NerdStart
@onready var Nerd: CharacterBody2D = $Players/Nerd


func _ready() -> void:
	pass
	#Nerd.position = Vector2(NerdStart.position.x, NerdStart.position.y - 50)

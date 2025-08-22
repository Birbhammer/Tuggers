extends Node2D

@onready var player = self.get_parent()
@onready var shoulderL: PinJoint2D = $ArmL
@onready var shoulderR: PinJoint2D = $ArmR


func _ready() -> void:
	shoulderL.node_a = player.get_path()
	shoulderR.node_a = player.get_path()

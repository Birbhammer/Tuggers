extends Node

@onready var joint: PinJoint2D = $Connector

var ropeSegment1 = []
var ropeSegment2 = []

var ropeStart1
var ropeStart2

@onready var Player1: CharacterBody2D = $"../LeftSide/Player1"

func _physics_process(delta: float) -> void:
	if joint.node_a.is_empty():
		if ropeStart1 != null:
				joint.set_node_a(ropeStart1.get_path())
		if ropeStart2 != null:
				joint.set_node_b(ropeStart2.get_path())
	
	ropeSegment1[9].freeze = true
	ropeSegment1[9].global_position = Player1.handR.global_position
	

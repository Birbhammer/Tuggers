extends Node2D

var gameManager: Node
var segmentNumber: int = 0

@onready var ropeStart: RigidBody2D = $RopeSegment

func _ready() -> void:
	gameManager =$"../../GameManager"
	gameManager.ropeStart1 = ropeStart
	
	for i in self.get_child_count():
		if get_child(i) is RigidBody2D:
			gameManager.ropeSegment1.append(get_child(i))
			gameManager.rope1Length -= 1
			var label = get_child(i).find_child("Label")
			label.text = str(1 + segmentNumber)
			segmentNumber += 1

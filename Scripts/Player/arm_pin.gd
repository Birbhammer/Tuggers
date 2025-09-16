extends Node2D

@onready var player = self.get_parent()
@onready var shoulderL: PinJoint2D = $ArmL
@onready var shoulderR: PinJoint2D = $ArmR

@export var RightFacingPoly: Array[Node2D]
@export var LeftFacingPoly: Array[Node2D]


func _ready() -> void:
	shoulderL.node_a = player.get_path()
	shoulderR.node_a = player.get_path()

func _process(delta: float) -> void:
	if player.velocity.x > 0:
		for i in RightFacingPoly.size():
			RightFacingPoly[i].visible = true
		for j in LeftFacingPoly.size():
			LeftFacingPoly[j].visible = false
	elif player.velocity.x < 0:
		for i in RightFacingPoly.size():
			RightFacingPoly[i].visible = false
		for j in LeftFacingPoly.size():
			LeftFacingPoly[j].visible = true

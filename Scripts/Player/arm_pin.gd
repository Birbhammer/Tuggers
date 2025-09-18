extends Node2D

class_name ArmPin

@onready var player
@onready var ArmPinLoc

#@onready var player = self.get_parent()
#@onready var ArmPinLoc = self.get_parent().find_child("ArmPinLoc", true)
@onready var shoulderL: PinJoint2D = $ArmL
@onready var shoulderR: PinJoint2D = $ArmR

@export var RightFacingPoly: Array[Node2D]
@export var LeftFacingPoly: Array[Node2D]


func _ready() -> void:
	#shoulderL.node_a = ArmPinLoc.get_path()
	#shoulderR.node_a = ArmPinLoc.get_path()
	pass

func _process(delta: float) -> void:
	if player is CharacterBody2D:
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

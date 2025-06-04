extends Node

var setup: bool = false

@onready var joint: PinJoint2D = $Connector

var ropeSegment1 = []
var ropeSegment2 = []

var ropeStart1
var ropeStart2

var rope1Length: int = 0
var rope2Length: int = 0

var ropeTotalLength: float
var ropeCurrentPosition: float = 0
var ropePreviousPosition: float = 0

var player1RopePos: int = 0
var player2RopePos: int = 0

@onready var Player1: CharacterBody2D = $"../LeftSide/Player1"
#@onready var Player2: CharacterBody2D = $"../RightSide/Player2"

func _physics_process(delta: float) -> void:
	
	if setup:
		ropeSegment1[player1RopePos].global_position = Player1.handR.global_position
		
		if (ropeCurrentPosition >= ropePreviousPosition + 1) or (ropeCurrentPosition <= (ropePreviousPosition - 1)):
			#Unfreeze
			ropeSegment1[player1RopePos].freeze = false
			
			ropePreviousPosition = ropeCurrentPosition
			
			#Player 1
			player1RopePos = abs(rope1Length + 1 + ropeCurrentPosition)
			ropeSegment1[player1RopePos].freeze = true
			#Player 2
			
		#player2RopePos = abs(rope2Length - 1 + ropeCurrentPosition)
	
	
	#ropeSegment2[9].freeze = true
	#ropeSegment2[9].global_position = Player2.handR.global_position
	


func _on_timer_timeout() -> void:
	ropeTotalLength = ((-rope1Length) + rope2Length)
	
	player1RopePos = abs((-rope1Length) - 1)
	
	joint.set_node_a(ropeStart1.get_path())
	joint.set_node_b(ropeStart2.get_path())
	
	ropeSegment1[player1RopePos].freeze = true
	
	setup = true

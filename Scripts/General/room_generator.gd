extends Node

class_name LevelGenerator
#---------------------------------------------------------------------------------------------------
#---------------------Add logic for collection of array for powerups -------------------------------
#---------------------------------------------------------------------------------------------------
var PowerUpLocations: Array[Marker2D] = []
var HazardLocations: Array[Marker2D] = []

var CurrentRoom: int = 0

@export var RoomList: Array[PackedScene] = []
@export var MaxRoomNum: int
@onready var StartPos: Marker2D = $RoomStart

func _ready() -> void:
	var last_room = null
	for i in MaxRoomNum:
		var new_room = RoomList[randi_range(0, RoomList.size() -1)].instantiate()
		if i == 0:
			new_room.position = StartPos.position
			add_child.call_deferred(new_room)
		else:
			var NewRoomStart = last_room.find_child("End")
			last_room.add_child.call_deferred(new_room)
			new_room.position = NewRoomStart.position
		
		for j in range(new_room.find_child("PowerUps").get_child_count()):
			PowerUpLocations.append(new_room.find_child("PowerUps").get_child(j))
		
		for k in range(new_room.find_child("Hazards").get_child_count()):
			HazardLocations.append(new_room.find_child("Hazards").get_child(k))
		
		last_room = new_room
	
	print(PowerUpLocations.size())

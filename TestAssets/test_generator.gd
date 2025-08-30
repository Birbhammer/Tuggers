extends Node

@export var RoomList: Array[PackedScene] = []
@export var MaxRoomNum: int
@onready var StartPos: Marker2D = $RoomStart

func _ready() -> void:
	var last_room = null
	for i in MaxRoomNum:
		var new_room = RoomList[randi_range(0, RoomList.size() -1)].instantiate()
		#add_child.call_deferred(new_room)
		if i == 0:
			new_room.position = StartPos.position
			add_child.call_deferred(new_room)
		else:
			var NewRoomStart = last_room.find_child("End")
			last_room.add_child.call_deferred(new_room)
			new_room.position = NewRoomStart.position
		
		last_room = new_room

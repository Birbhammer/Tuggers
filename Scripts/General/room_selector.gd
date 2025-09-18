extends Node

@export var RoomList: Array[PackedScene] = []
@export var NewRoomStart: Marker2D
@onready var RoomHolder = self.get_parent()

func _ready() -> void:
	if NewRoomStart != null:
		var rand_num = randi_range(0, 10)
		if rand_num == 10:
			return
		var new_room = RoomList[0].instantiate()
		RoomHolder.add_child.call_deferred(new_room)
		new_room.position = NewRoomStart.position
		var n = randi_range(0, 999)
		new_room.name = "Room_%d" %n 
	

extends ArmPin


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Chad")
	ArmPinLoc = player.find_child("ArmPinLoc", true)
	#shoulderL.node_a = ArmPinLoc.get_path()
	#shoulderR.node_a = ArmPinLoc.get_path()

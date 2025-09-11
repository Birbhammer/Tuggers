extends Node

@export var Hazard: PackedScene

func Activate() -> void:
	var nerd_generator: LevelGenerator = get_tree().get_first_node_in_group("NerdGenerator")
	var placement_room = nerd_generator.CurrentRoom + 2
	var spawned_hazard = Hazard.instantiate()
	nerd_generator.add_child(placement_room)
	spawned_hazard.position = nerd_generator.HazardLocations[placement_room].position

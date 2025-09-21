extends Node

@export var Hazard: PackedScene

func Activate(body) -> void:
	var chad_generator: LevelGenerator = get_tree().get_first_node_in_group("NerdGenerator")
	var placement_room = chad_generator.CurrentRoom + 2
	var spawned_hazard = Hazard.instantiate()
	chad_generator.add_child(placement_room)
	spawned_hazard.position = chad_generator.HazardLocations[placement_room].position

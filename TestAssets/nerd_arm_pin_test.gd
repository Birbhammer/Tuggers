extends RigidBody2D

@onready var nerd: CharacterBody2D = get_tree().get_first_node_in_group("Nerd")


func _physics_process(delta: float) -> void:
	var dir = global_position.direction_to(nerd.global_position)
	self.apply_force(dir * 5000 * delta)

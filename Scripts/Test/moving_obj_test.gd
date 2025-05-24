extends AnimatableBody2D

func _physics_process(delta: float) -> void:
	global_position.x = (global_position.x + 1)
	

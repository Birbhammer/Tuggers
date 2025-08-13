extends AnimatableBody2D

@export var SPEED = 0

func _physics_process(delta: float) -> void:
	global_position.x = (global_position.x + SPEED)

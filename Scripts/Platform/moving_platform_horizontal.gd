extends AnimatableBody2D

@export var SPEED = 0
@export var MaxDistance: Marker2D
@export var StartPOS: Marker2D

func _physics_process(delta: float) -> void:
	global_position.x = (global_position.x + SPEED)
	
	if SPEED > 0:
		if self.position.x > MaxDistance.position.x:
			self.position.x = StartPOS.position.x
	elif SPEED < 0:
		if self.position.x < MaxDistance.position.x:
			self.position.x = StartPOS.position.x

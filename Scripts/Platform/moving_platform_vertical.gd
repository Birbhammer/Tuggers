extends AnimatableBody2D

@export var SPEED = 0
@export var MaxHeight: Marker2D
@export var StartPOS: Marker2D

func _physics_process(delta: float) -> void:
	global_position.y = (global_position.y + SPEED)
	
	if SPEED < 0:
		if self.position.y < MaxHeight.position.y:
			self.position.y = StartPOS.position.y
	elif SPEED > 0:
		if self.position.y > MaxHeight.position.y:
			self.position.y = StartPOS.position.y
	

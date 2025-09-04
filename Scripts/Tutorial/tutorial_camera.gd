extends Camera2D

@export var Nerd: CharacterBody2D

func _physics_process(delta: float) -> void:
	self.position = self.position.lerp(Vector2(Nerd.position.x + 500, Nerd.position.y), 1 * delta)

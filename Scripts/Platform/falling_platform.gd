extends Node

# 1 second = 100 Health 
@export var health: int = 25
@export var SPEED: int = 2500
var draining: bool = false

@onready var collisionshape: CollisionShape2D = $CollisionShape2D

func _process(delta: float) -> void:
	if draining == true:
		# 1 second = 100 Health 
		health = health - (1 * delta)
	
	if health <= 0:
		self.global_position.y = (self.global_position.y + SPEED * delta)
		collisionshape.disabled = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player1":
		draining = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player1":
		draining = false

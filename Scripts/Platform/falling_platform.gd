extends Node

# 1 second = 100 Health 
@export var health: int
@export var SPEED: int
var draining: bool = false
var MaxHealth: int
@onready var collisionshape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	MaxHealth = health

func _process(delta: float) -> void:
	if draining == true:
		# 1 second = 100 Health 
		health = health - (1 * delta)
	elif draining == false && health < MaxHealth:
		health = health + (1 * delta) 
	
	if health <= 0:
		self.global_position.y = (self.global_position.y + SPEED * delta)
		collisionshape.disabled = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Nerd" or body.name == "Chad":
		draining = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Nerd" or body.name == "Chad":
		draining = false

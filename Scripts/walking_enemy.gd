extends Node2D

@export var SPEED = 0
@onready var LeftMax: Marker2D = $LeftMax
@onready var RightMax: Marker2D = $RightMax
var MovingRight: bool

@onready var enemybody: AnimatableBody2D = $AnimatableBody2D

func _ready() -> void:
	MovingRight = true


func _physics_process(delta: float) -> void:
	
	if enemybody.position.x >= RightMax.position.x:
		MovingRight = false
	elif enemybody.position.x <= LeftMax.position.x:
		MovingRight = true
	
	if MovingRight:
		enemybody.position.x = (enemybody.position.x + (SPEED * delta))
	else:
		enemybody.position.x = (enemybody.position.x - (SPEED * delta))
	
	

@export var KnockbackForce: int

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#Some Kind of injury logic
		body.IsStunned = true
		var player: CharacterBody2D = body
		player.Knockback(KnockbackForce)

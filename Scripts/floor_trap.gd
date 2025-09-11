extends Node2D

@export var KnockbackForce: int = 0 

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#Injury Logic
		body.IsStunned = true
		var player: CharacterBody2D = body
		player.Knockback(KnockbackForce)

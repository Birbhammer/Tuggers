extends Node2D


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#Injury Logic
		pass

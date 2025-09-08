extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#Activate Power Up. Gain Function from child and use .Activate()
		pass

extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		for i in range(get_child_count()):
			if get_child(i).is_in_group("PowerUp"):
				get_child(i).Activate(body)
	#get_parent().queue_free()

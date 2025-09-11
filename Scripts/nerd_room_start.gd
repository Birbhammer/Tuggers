extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var generator: LevelGenerator = get_tree().get_first_node_in_group("NerdGenerator")
		generator.CurrentRoom += 1
		queue_free()

extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Nerd"):
		get_tree().change_scene_to_file("res://Levels/nerd_win.tscn")
	elif body.is_in_group("Chad"):
		get_tree().change_scene_to_file("res://Levels/chad_win.tscn")

extends Node

func _on_end_body_entered(body: Node2D) -> void:
	if body.name == "Nerd":
		get_tree().change_scene_to_file("res://Levels/menu.tscn")

extends Area2D

@onready var resetPos: Marker2D = $"../ResetPOS"

func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "Player1":
		body.position = resetPos.position

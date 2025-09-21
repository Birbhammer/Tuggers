extends Node

@export var BuffTime: int = 5
var player = null

func Activate(body: Player) -> void:
		player = body 
		body.MaxJump = 2

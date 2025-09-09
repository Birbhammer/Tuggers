extends Node

var player = null

func Activate(body: Player) -> void:
	player = body 
	body.MaxJump = 2
	
	var timer = Timer.new()
	timer.wait_time = 10
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
func _on_timer_timeout():
	if player != null:
		player.MaxJump = 1
	

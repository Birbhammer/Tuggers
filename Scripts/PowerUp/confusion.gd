extends Node

@export var NerfTime: int = 5
var player = null

func Activate(body: Player) -> void:
	player = body 
	body.confusion = -1
	
	var timer = Timer.new()
	timer.wait_time = 10.0
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	timer.timeout.connect(_on_confusion_timer_timeout)
	timer.start()
	
func _on_confusion_timer_timeout():
	if player != null:
		player.confusion = 1
		#get_parent().get_parent().queue_free()
	

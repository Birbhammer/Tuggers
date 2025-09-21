extends Area2D


@export var BUFF_SOUND : AudioStreamPlayer
@export var NERF_SOUND : AudioStreamPlayer


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		for i in range(get_child_count()):
			if get_child(i).is_in_group("PowerUp"):
				if get_child(i).is_in_group("Buff"):
					BUFF_SOUND.play()
				if get_child(i).is_in_group("Nerf"):
					NERF_SOUND.play()
				get_child(i).Activate(body)
		
		self.set_collision_layer_value(3, false)
		self.set_collision_layer_value(1, false)
		self.set_collision_mask_value(3,false)
		self.set_collision_mask_value(1,false)
		self.visible = false

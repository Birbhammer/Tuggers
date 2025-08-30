extends Node

@onready var base: Node2D = $Base
@onready var credits: Node2D = $Credits
@onready var options: Node2D = $Options

func _ready() -> void:
	credits.visible = false
	options.visible = false

func _on_start_button_pressed() -> void:
	#Add logic for selecting controllers
	get_tree().change_scene_to_file("res://Levels/main.tscn")


func _on_options_button_pressed() -> void:
	base.visible = false
	options.visible = true


func _on_credits_button_pressed() -> void:
	base.visible = false
	credits.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()

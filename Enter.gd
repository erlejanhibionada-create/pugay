class_name Enter
extends Area2D

@export var connect_scene: String = "battle" 
var scene_folder = "res://Scenes/"

func _on_body_entered(body: Node2D) -> void:
	if body is Player: 
		var full_path = scene_folder + connect_scene + ".tscn"
		get_tree().change_scene_to_file(full_path)

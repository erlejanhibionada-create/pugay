extends Control

func _on_start_pressed() -> void:
	print("Start pressed")
	get_tree().change_scene_to_file("res://Scenes/level_alley.tscn")

func _on_settings_pressed() -> void:
	print("Settings pressed")


func _on_exit_pressed() -> void:
	print("Exit pressed")
	get_tree().quit()


func _on_load_pressed() -> void:
	print("Load pressed")

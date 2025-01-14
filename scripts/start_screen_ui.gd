extends Control


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_settings_button_pressed() -> void:
	pass


func _on_exit_game_button_pressed() -> void:
	get_tree().quit()

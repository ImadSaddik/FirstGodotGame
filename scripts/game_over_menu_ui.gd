extends Control

@export var gameOverUILayer: CanvasLayer

func _on_retry_button_pressed() -> void:
	gameOverUILayer.hide()
	get_tree().reload_current_scene()


func _on_exit_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen_ui.tscn")


func show_game_over_menu() -> void:
	gameOverUILayer.show()

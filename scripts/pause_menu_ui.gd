extends Control

@export var canvasLayer: CanvasLayer


func _on_resume_button_pressed() -> void:
	canvasLayer.hide()


func _on_exit_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen_ui.tscn")

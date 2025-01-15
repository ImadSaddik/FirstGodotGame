extends Control

@export var settingsView: Node
@export var startMenuView: VBoxContainer


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_settings_button_pressed() -> void:
	startMenuView.hide()
	show_child_inside_node(settingsView)
	
	
func show_child_inside_node(node: Node) -> void:
	for child in node.get_children(true):
		child.show()
		
		
func _on_exit_game_button_pressed() -> void:
	get_tree().quit()


func _on_return_to_start_menu_button_pressed() -> void:
	hide_child_inside_node(settingsView)
	
	
func hide_child_inside_node(node: Node) -> void:
	startMenuView.show()
	for child in node.get_children(true):
		child.hide()

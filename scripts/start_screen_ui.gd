extends Control

@export var music_bus_name: String
@export var sound_effects_bus_name: String
@export var settingsView: VBoxContainer
@export var levelsView: VBoxContainer
@export var startMenuView: VBoxContainer

var music_bus_index: int
var sound_effects_bus_index: int

func _ready() -> void:
	music_bus_index = AudioServer.get_bus_index(music_bus_name)
	sound_effects_bus_index = AudioServer.get_bus_index(sound_effects_bus_name)


func _on_start_game_button_pressed() -> void:
	startMenuView.hide()
	levelsView.show()


func _on_settings_button_pressed() -> void:
	startMenuView.hide()
	settingsView.show()


func _on_exit_game_button_pressed() -> void:
	get_tree().quit()


func _on_return_to_start_menu_button_pressed() -> void:
	startMenuView.show()
	settingsView.hide()
	levelsView.hide()


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		music_bus_index,
		linear_to_db(value)
	)


func _on_sound_effects_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		sound_effects_bus_index,
		linear_to_db(value)
	)


func _on_start_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_start_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")


func _on_start_level_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")

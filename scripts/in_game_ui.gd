extends Control

@export var coinCounterLabel: Label
@export var pauseButton: Panel


func update_coin_counter_label(value: int) -> void:
	coinCounterLabel.text = str(value)


func _on_pause_button_pressed() -> void:
	print("Pause button clicked")

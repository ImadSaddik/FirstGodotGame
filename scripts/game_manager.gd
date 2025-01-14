extends Node

@onready var scoreLabel: Label = $ScoreLabel
@export var inGameUI: Control
@export var pauseMenuUI: Control

var score: int = 0

func add_point():
	score += 1
	scoreLabel.text = "You collected " + str(score) + " coins."
	inGameUI.update_coin_counter_label(score)
	

func show_pause_menu() -> void:
	var canvasLayer: CanvasLayer = pauseMenuUI.get_child(0, true)
	canvasLayer.show()

extends Node

@onready var scoreLabel: Label = $ScoreLabel
@export var inGameUI: Control
@export var pauseMenuUI: Control
@export var gameOverMenuUI: Control
@onready var slime: Node2D = $"../Enemies/Slime"

var score: int = 0

func add_point():
	score += 1
	scoreLabel.text = "You collected " + str(score) + " coins."
	inGameUI.update_coin_counter_label(score)
	

func show_pause_menu() -> void:
	var canvasLayer: CanvasLayer = pauseMenuUI.get_child(0, true)
	canvasLayer.show()


func _on_player_died() -> void:
	print("Game manager - Signale received")
	gameOverMenuUI.show_game_over_menu()

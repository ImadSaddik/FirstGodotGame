extends Node

@export var scoreLabel: Label
@export var inGameUI: Control
@export var pauseMenuUI: Control
@export var winMenuUI: Control
@export var gameOverMenuUI: Control
@export var slime: Node2D
@export var player: Node2D

var score: int = 0


func add_point():
	score += 1
	scoreLabel.text = "You collected " + str(score) + " coins."
	inGameUI.update_coin_counter_label(score)
	

func show_pause_menu() -> void:
	var canvasLayer: CanvasLayer = pauseMenuUI.get_child(0, true)
	canvasLayer.show()


func _on_player_died() -> void:
	print("Player died")
	player.isDead = true
	player.play_death_sound()
	gameOverMenuUI.show_game_over_menu()


func _on_player_won() -> void:
	player.isLevelCompleted = true
	
	const maxNumberOfStars: int = 8
	winMenuUI.update_stars_based_on_score(score, maxNumberOfStars)
	
	var canvasLayer: CanvasLayer = winMenuUI.get_child(0, true)
	canvasLayer.show()

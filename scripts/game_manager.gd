extends Node

@onready var scoreLabel: Label = $ScoreLabel

var score: int = 0

func add_point():
	score += 1
	scoreLabel.text = "You collected " + str(score) + " coins."

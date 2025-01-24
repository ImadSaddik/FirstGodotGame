extends Area2D

var isBodyInside := false
var playerBody: Node2D = null


func _process(_delta: float) -> void:
	if isBodyInside and playerBody:
		playerBody.isOnLadder = true


func _on_body_entered(body: Node2D) -> void:
	playerBody = body
	isBodyInside = true
	playerBody.isOnLadder = true


func _on_body_exited(_body: Node2D) -> void:
	playerBody.isOnLadder = false
	playerBody = null
	isBodyInside = false

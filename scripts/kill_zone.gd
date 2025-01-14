extends Area2D

@onready var timer: Timer = $Timer
@export var gameOverUI: Control

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	var canvasLayer: CanvasLayer = gameOverUI.get_child(0, true)
	canvasLayer.show()

extends Area2D

signal player_won

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("WIN")
	timer.start()


func _on_timer_timeout() -> void:
	emit_signal("player_won")

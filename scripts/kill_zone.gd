extends Area2D

signal player_died

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	emit_signal("player_died")

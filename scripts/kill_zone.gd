extends Area2D

signal player_died

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	print("Kill zone - Signal emitted")
	emit_signal("player_died")

extends RigidBody2D

signal player_died

@export var timer: Timer


func _on_timer_timeout() -> void:
	queue_free()


func _on_player_died() -> void:
	emit_signal("player_died")

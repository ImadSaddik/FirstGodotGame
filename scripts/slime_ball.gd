extends RigidBody2D

@export var timer: Timer


func _on_timer_timeout() -> void:
	queue_free()

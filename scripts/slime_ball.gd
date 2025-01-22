extends RigidBody2D

signal player_died

@export var timer: Timer


func _on_timer_timeout() -> void:
	queue_free()


func _on_player_died() -> void:
	emit_signal("player_died")


func _on_area_entered(area: Area2D) -> void:
	print("Hit the ground")


func _on_ball_hit_ground() -> void:
	queue_free()

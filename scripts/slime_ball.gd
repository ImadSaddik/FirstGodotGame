extends RigidBody2D

@warning_ignore("unused_signal")
signal player_died

@export var animationTimer: Timer
@export var explosionAnimation: AnimationPlayer


func explode_slime_ball() -> void:
	explosionAnimation.play("explosion")


func _on_player_died() -> void:
	emit_signal("player_died")


func _on_ball_hit_ground() -> void:
	explosionAnimation.play("explosion")
	animationTimer.start()


func _on_animation_duration_timeout() -> void:
	queue_free()


func _on_spawn_rate_timeout() -> void:
	queue_free()

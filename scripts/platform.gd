extends AnimatableBody2D

signal player_on_platform
signal player_exited_platform


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		emit_signal("player_on_platform")


func _on_player_exited_platform(body: Node2D) -> void:
	if body.name == "Player":
		emit_signal("player_exited_platform")

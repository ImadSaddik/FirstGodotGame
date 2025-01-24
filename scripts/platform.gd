extends AnimatableBody2D

signal player_on_platform(platformCollisionShape)
signal player_exited_platform(platformCollisionShape)

@export var platformCollisionShape: CollisionShape2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_on_platform.emit(platformCollisionShape)


func _on_player_exited_platform(body: Node2D) -> void:
	if body.name == "Player":
		platformCollisionShape.set_deferred("disabled", false)
		player_exited_platform.emit(platformCollisionShape)

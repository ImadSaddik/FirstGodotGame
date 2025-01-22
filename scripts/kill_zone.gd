extends Area2D

signal player_died
signal ball_hit_ground

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		handle_player_case(body)
		emit_signal("player_died")
	elif body is TileMap:
		emit_signal("ball_hit_ground")


func handle_player_case(body: Node2D) -> void:
	body.hide()
	body.isDead = true
	
	var collisionShape2D = body.get_node("CollisionShape2D")
	collisionShape2D.queue_free()

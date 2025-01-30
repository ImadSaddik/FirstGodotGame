extends Area2D

@warning_ignore("unused_signal")
signal player_died
@warning_ignore("unused_signal")
signal ball_hit_ground

@export var isWorldKillZone: bool

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		handle_player_case(body)
	elif body is TileMap:
		emit_signal("ball_hit_ground")


func handle_player_case(body: Node2D) -> void:
	if body.shieldIsUsed and not isWorldKillZone:
		return
	
	body.hide()
	body.isDead = true
	
	var collisionShape2D = body.get_node("CollisionShape2D")
	collisionShape2D.queue_free()
	
	emit_signal("player_died")

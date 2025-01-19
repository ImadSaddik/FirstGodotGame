extends Area2D

signal player_died

func _on_body_entered(body: Node2D) -> void:
	body.hide()
	body.canMakeAction = false
	
	var collisionShape2D = body.get_node("CollisionShape2D")
	collisionShape2D.queue_free()
	
	emit_signal("player_died")
